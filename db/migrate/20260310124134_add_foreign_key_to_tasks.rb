class AddForeignKeyToTasks < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :tasks, :users    #tasks is child table
    add_index :tasks, :user_id     # added idx on the user_id column in tasks table, so everytime whole tasks table is not scanned to find the user_id, it can directly jump to the index and find the relevant records. This significantly improves the performance of queries that filter tasks by user_id.
  end
end
