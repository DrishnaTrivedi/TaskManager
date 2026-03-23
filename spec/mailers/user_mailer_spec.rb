require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before { ActionMailer::Base.deliveries.clear }

  let(:user) { create(:user) }
  let(:mail) { UserMailer.welcome_email(user) }

  describe "welcome_email" do
    it "sends to correct recipient" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the correct subject" do
      expect(mail.subject).to eq("Welcome to TaskManager, #{user.name}!")
    end

    it "renders the user name in the body" do
      expect(mail.body.encoded).to include(user.name)
    end

    it "renders the user email in the body" do
      expect(mail.body.encoded).to include(user.email)
    end
  end
end