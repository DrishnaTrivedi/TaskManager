require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do

  before {ActionMailer::Base.deliveries.clear}
  let(:user) {create(:user)}
  let(:task) { create(:task , user:user)}

  describe "task_created" do

    let(:mail) {TaskMailer.task_created(task)}

    it"sends email to correct email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the correct subject" do
      expect(mail.subject).to eq("New Task Created: #{task.title}")
    end

    it "renders the task title in the body" do
      expect(mail.body.encoded).to include(task.title)
    end

    it "renders the task priority oin the body" do
      expect(mail.body.encoded).to include(task.priority)
    end


  end

  describe "task_due_reminder" do
    let(:mail) { TaskMailer.task_due_reminder(task) }

    it "sends to correct receipient" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the correct subject" do
      expect(mail.subject).to eq("Reminder: #{task.title} is due soon!")
    end

    it "renders the task title in the body" do
      expect(mail.body.encoded).to include(task.title)
    end

    it "has an attachment" do
      expect(mail.attachments.count).to eq(1)
      expect(mail.attachments.first.filename).to eq('task_details.txt')
    end

  end

end
