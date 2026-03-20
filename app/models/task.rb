
class Task < ApplicationRecord
    before_update :track_status_change 
    has_many :status_histories, dependent: :destroy
    after_create :send_task_created_email
    after_create :schedule_due_reminder

    belongs_to :user
    validates :title, presence: true
    validates :status, presence: true, inclusion: { in: ['pending', 'in progress', 'completed'] }
    validates :priority, presence: true, inclusion: { in: ['low', 'medium', 'high'] } 
    validate :check_due_date
    
    def check_due_date
        if due_date.present? and due_date < Date.today
            errors.add(:due_date, "Due date cannot be in the past")
        end
    end

    def track_status_change
        if status_changed?
            StatusHistory.create!(
             task: self,
            from_status: status_was,
            to_status: status,
            changed_at: Time.now
        )
        end
    end

    def send_task_created_email
        TaskMailer.task_created(self).deliver_later
    end

    def schedule_due_reminder
        return unless due_date.present?
        reminder_time = due_date - 24.hours
        TaskReminderJob.set(wait_until: reminder_time).perform_later(id)
    end

end
