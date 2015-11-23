class User < ActiveRecord::Base
  has_many :lists

  def self.find_or_create_from_oauth(auth_data)
    user = find_or_create_by(uid: auth_data[:uid]) do |new_user|
      new_user.username    = auth_data[:info][:nickname]
      new_user.token = auth_data[:credentials][:token]
    end

    user
  end

end
