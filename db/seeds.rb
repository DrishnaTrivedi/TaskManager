# Create Users
user1 = User.create!(
  name: "Drishna",
  email: "drishna@gmail.com",
  password_digest: "hashedpassword123"
)

user2 = User.create!(
  name: "John Doe",
  email: "john@gmail.com",
  password_digest: "hashedpassword456"
)

# Create Tasks for user1
user1.tasks.create!([
  { title: "Buy groceries", description: "Milk, eggs, bread", status: "pending", priority: "low", due_date: 2.days.from_now },
  { title: "Finish project", description: "Complete Rails API", status: "in progress", priority: "high", due_date: 5.days.from_now },
  { title: "Read book", description: "Clean Code by Robert Martin", status: "pending", priority: "medium", due_date: 7.days.from_now }
])

# Create Tasks for user2
user2.tasks.create!([
  { title: "Go to gym", description: "Leg day", status: "pending", priority: "medium", due_date: 1.days.from_now },
  { title: "Pay bills", description: "Electricity and internet", status: "completed", priority: "high", due_date: 3.days.from_now }
])

puts "Created #{User.count} users"
puts "Created #{Task.count} tasks"