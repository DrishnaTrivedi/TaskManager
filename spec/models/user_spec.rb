require 'rails_helper'

RSpec.describe User, type: :model do
  it {
    should have_many(:tasks).dependent(:destroy)
  }

  it{
    should validate_presence_of(:name)
  }
  it{
    should validate_presence_of(:email)
  }

  it{
    should validate_uniqueness_of(:email).case_insensitive
  }

  it "should downcase email address before saving"  do
    user = create(:user , email: "MATT@GMAIL.COM")
    expect(user.email).to eq ("matt@gmail.com")
  end


  it  "should be invalid without a password" do
    user = build(:user, password: nil)
    expect(user). to_not be_valid
  end
end