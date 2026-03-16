require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { build(:task) } 
  
  it { should belong_to(:user) }
  it { should have_many(:status_histories).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_inclusion_of(:status).in_array(["pending" , "in progress" , "completed"]) }
  it { should validate_inclusion_of(:priority).in_array(%w[low medium high]) }

  it "is invalid if due date is in the past" do
    task = build(:task, due_date: 1.day.ago)
    expect(task).to_not be_valid
  end

  it "creates a status history when status changes" do
    task = create(:task, status: "pending")
    task.update!(status: "completed")
  
    expect(task.status_histories.count).to eq(1)
    expect(task.status_histories.last.from_status).to eq("pending")
    expect(task.status_histories.last.to_status).to eq("completed")
  end

  it "does not create a status history when status does not change" do
    task = create(:task, status: "pending")
    task.update!(title: "New Title")
  
    expect(task.status_histories.count).to eq(0)
  end
end