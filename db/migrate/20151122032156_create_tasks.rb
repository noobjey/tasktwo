class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :status, default: false
      t.string :description
      t.date :due_date
      t.integer :list_id

      t.timestamps null: false
    end
  end
end
