class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :priority, :due_date, :created_at
  belongs_to :user
  has_many :status_histories
end
