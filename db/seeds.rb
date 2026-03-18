# db/seeds.rb

# Clear existing data
puts "Clearing existing data..."
StatusHistory.destroy_all
Task.destroy_all
User.destroy_all

# Create users
puts "Creating users..."
user1 = User.create!(
  name: "Matt",
  email: "matt@gmail.com",
  password: "123456"
)

user2 = User.create!(
  name: "John",
  email: "john@gmail.com",
  password: "123456"
)

# Create tasks for user1
puts "Creating tasks..."
Task.create!(
  title: "Build API",
  description: "Build a RESTful API with Rails",
  status: "pending",
  priority: "high",
  due_date: 1.year.from_now,
  user: user1
)

Task.create!(
  title: "Write tests",
  description: "Write RSpec tests for all endpoints",
  status: "in progress",
  priority: "high",
  due_date: 1.year.from_now,
  user: user1
)

Task.create!(
  title: "Setup database",
  description: "Configure PostgreSQL database",
  status: "completed",
  priority: "medium",
  due_date: 1.year.from_now,
  user: user1
)

Task.create!(
  title: "Deploy to production",
  description: "Deploy the app to Heroku",
  status: "pending",
  priority: "low",
  due_date: 1.year.from_now,
  user: user1
)

Task.create!(
  title: "Build frontend",
  description: "Build React frontend for the API",
  status: "pending",
  priority: "medium",
  due_date: 1.year.from_now,
  user: user1
)

# Create tasks for user2
Task.create!(
  title: "Review pull requests",
  description: "Review open PRs on GitHub",
  status: "pending",
  priority: "high",
  due_date: 1.year.from_now,
  user: user2
)

Task.create!(
  title: "Fix bug in login",
  description: "Fix authentication bug",
  status: "in progress",
  priority: "high",
  due_date: 1.year.from_now,
  user: user2
)

puts "Done! Created:"
puts "  #{User.count} users"
puts "  #{Task.count} tasks"