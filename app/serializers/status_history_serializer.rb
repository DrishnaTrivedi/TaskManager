class StatusHistorySerializer < ActiveModel::Serializer
  attributes :id, :from_status, :to_status, :changed_at
end
