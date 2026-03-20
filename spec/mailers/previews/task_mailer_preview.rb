# Preview all emails at http://localhost:3000/rails/mailers/task_mailer_mailer
class TaskMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/task_mailer_mailer/task_created
  def task_created
    TaskMailer.task_created
  end

  # Preview this email at http://localhost:3000/rails/mailers/task_mailer_mailer/task_due_reminder
  def task_due_reminder
    TaskMailer.task_due_reminder
  end

end
