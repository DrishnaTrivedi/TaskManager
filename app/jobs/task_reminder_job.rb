class TaskReminderJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)
    TaskMailer.task_due_reminder(task).deliver_now
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info "Task #{task_id} not found, skipping reminder"
  end
end
