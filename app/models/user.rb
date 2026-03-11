class User < ApplicationRecord
    has_secure_password
    has_many :tasks, dependent: :destroy
    validates :name, presence:true
    validates :password_digest, presence: true
    validates :email, presence: true, email: true
                                        # |
                                        # email: true option tells Rails to use the custom EmailValidator we defined earlier to validate the email format.it automatically looks for a validator class named EmailValidaor
end
