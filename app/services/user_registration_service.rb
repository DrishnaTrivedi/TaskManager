class UserRegistrationService
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    user = User.new(@params)
    if user.save
      OpenStruct.new(success?: true, user: user)
    else
      OpenStruct.new(success?: false, errors: user.errors.full_messages)
    end
  end
end