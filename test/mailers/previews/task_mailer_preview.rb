class TaskMailerPreview < ActionMailer::Preview
  def task_created
    task = Task.first
    TaskMailer.task_created(task)
  end

  def task_due_reminder
    task = Task.first
    TaskMailer.task_due_reminder(task)
  end
end