class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :priority
      t.datetime :due_date
      t.integer :user_id

      t.timestamps
    end
  end
end
