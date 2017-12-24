class Email < ApplicationRecord
  has_many :recipients, inverse_of: :email
  belongs_to :user, inverse_of: :emails
  accepts_nested_attributes_for :recipients
end
