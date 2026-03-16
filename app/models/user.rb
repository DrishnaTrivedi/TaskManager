class User < ApplicationRecord
    before_save :downcase_email
    after_create :send_welcome_email


    has_secure_password
    
    has_many :tasks, dependent: :destroy
    validates :name, presence:true
    validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }
                                        # |
                                        # email: true option tells Rails to use the custom EmailValidator we defined earlier to validate the email format.it automatically looks for a validator class named EmailValidaor
    private 
    def downcase_email
        self.email = email.downcase if email.present?
    end

    def send_welcome_email
        WelcomeEmailJob.perform_later(id)
    end
end
