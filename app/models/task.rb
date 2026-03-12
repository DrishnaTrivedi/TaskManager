class Task < ApplicationRecord
    before_update :track_status_change 
    has_many :status_histories, dependent: :destroy

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
end
