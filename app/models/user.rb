class User < ApplicationRecord
  has_and_belongs_to_many :roles
  has_many :recipients, inverse_of: :user
  has_many :emails, -> {where("emails.status <> 0 AND recipients.status > 0")}, through: :recipients
  has_many :unread_emails, -> {where(recipients: {status: 1, is_read: 0})}, through: :recipients
  has_many :sent_emails, -> {where(emails: {status: 1})}, class_name: "Email"
  has_many :draft_emails, -> {where(emails: {status: 0})}, class_name: "Email"
  has_many :trash_sent, -> {where(emails: {status: -1})}, class_name: "Email"
  has_many :trash_received, -> {where(recipients: {status: -1})}, through: :recipients, source: :email
  has_secure_password

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
end
