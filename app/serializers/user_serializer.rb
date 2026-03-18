class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :newly_created?
  has_many :tasks

  def newly_created?
    Date.today.prev_month < object.created_at
    # oject represents whatever object has been passed to serializer, here it is user
  end
end
