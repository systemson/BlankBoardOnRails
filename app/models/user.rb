class User < ApplicationRecord
  has_and_belongs_to_many :roles
  has_many :recipients, inverse_of: :user
  has_many :emails, -> {where("emails.status <> 0 AND recipients.status > 0")}, through: :recipients
  has_many :unread_emails, -> {where(recipients: {status: 1, is_read: 0})}, through: :recipients, source: :email
  has_many :sent_emails, -> {where(emails: {status: 1})}, class_name: "Email"
  has_many :draft_emails, -> {where(emails: {status: 0})}, class_name: "Email"
  has_many :trash_sent, -> {where(emails: {status: -1})}, class_name: "Email"
  has_many :trash_received, -> {where(recipients: {status: -1})}, through: :recipients, source: :email
  has_secure_password

  validates_presence_of :user

  def avatar
    if(self.image == nil)
      @avatar = '/img/avatar/default.png'
    else
      @avatar = '/img/avatar/' + self.image
    end
  end

  def trash_emails
    @trash = trash_sent + trash_received
    @trash.sort_by(&:created_at)
  end

  def is_active
    if self.status > 0 || self.is_superadmin
      true
    else
      false
    end
  end

  def is_inactive
    if self.status <= 0 && !self.is_superadmin
      true
    else
      false
    end
  end

  def is_forbidden
    if self.status < 0 && !self.is_superadmin
      true
    else
      false
    end
  end

  def is_superadmin
    self.has_role(1)
  end

  def is_new
    if self.last_password_change == nil
      true
    else
      false
    end
  end

  def password_expired
    password_days = (Time.now - self.last_password_change).to_i / 1.day
    days = 30
    if self.is_new || (days > 0 && password_days > days)
      true
    else
      false
    end
  end

  def has_role(slug)
    if slug.is_a?(String)
      roles.exists?(slug: slug)
    elsif slug.is_a?(Integer)
      roles.exists?(id: slug)
    end
  end

  def permissions
    @permissions = {}
    if self.roles.empty?
      @permissions = Permission.none
    else
      self.roles.each do |r|
        @permissions = r.permissions.merge!(@permissions)
      end
    end
    @permissions
  end

  def has_permission(slug, in_module = false)
    if self.is_superadmin
      true
    elsif self.is_inactive
      false
    end

    if slug.is_a?(String)
      slug = slug.split('|')
    end

    if in_module
      self.permissions.exists?(module: slug)
    else
      self.permissions.exists?(slug: slug)
    end
  end
end
