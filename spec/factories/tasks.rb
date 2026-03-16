FactoryBot.define do
  factory :task do
    title {"Test Task"}
    description {"Test Description"}
    status  {"pending"}
    priority {"high"}
    due_date {1.year.from_now}
    association :user
  end
end
