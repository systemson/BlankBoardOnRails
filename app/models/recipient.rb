class Recipient < ApplicationRecord
  belongs_to :email, inverse_of: :recipients
  belongs_to :user, inverse_of: :recipients
  accepts_nested_attributes_for :email
end