class CreateStatusHistories < ActiveRecord::Migration[8.1]
  def change
    create_table :status_histories do |t|
      t.references :task, null: false, foreign_key: true
      t.string :from_status
      t.string :to_status
      t.datetime :changed_at

      t.timestamps
    end
  end
end
