class TaskMailer < ApplicationMailer

  def task_created(task)
    @task = task
    @user = task.user
    mail(
      to: @user.email,
      subject: "New Task Created: #{@task.title}"
    )
  end

  def task_due_reminder(task)
    @task = task
    @user = task.user
    mail(
      to: @user.email,
      subject: "Reminder: #{@task.title} is due soon!"
    )
  end

end

