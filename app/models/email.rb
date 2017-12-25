class Email < ApplicationRecord
  has_many :recipients, inverse_of: :email
  has_many :users,through: :recipients
  belongs_to :user, inverse_of: :emails
  accepts_nested_attributes_for :recipients

  def has_owner(user)
     self.user_id == user.id
  end

  def has_recipient(user)
     @recipient = self.recipients.find(user.id)
  end
end
