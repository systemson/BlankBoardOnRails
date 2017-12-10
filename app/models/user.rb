class User < ApplicationRecord
  has_and_belongs_to_many :roles
  has_secure_password
end
