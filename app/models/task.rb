class Task < ApplicationRecord
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
end
