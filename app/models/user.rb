class User < ApplicationRecord
  has_and_belongs_to_many :roles
  has_secure_password

  def avatar
    if(self.image == nil)
      @avatar = '/img/avatar/default.png'
    else
      @avatar = '/img/avatar/' + self.image
    end
  end
end
