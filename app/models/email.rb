class Email < ApplicationRecord
  has_many :recipients, inverse_of: :email
  has_many :users,through: :recipients
  belongs_to :user, inverse_of: :emails
  accepts_nested_attributes_for :recipients
end
