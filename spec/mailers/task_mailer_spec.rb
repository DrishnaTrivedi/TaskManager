require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do
  describe "task_created" do
    let(:mail) { TaskMailer.task_created }

    it "renders the headers" do
      expect(mail.subject).to eq("Task created")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "task_due_reminder" do
    let(:mail) { TaskMailer.task_due_reminder }

    it "renders the headers" do
      expect(mail.subject).to eq("Task due reminder")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
