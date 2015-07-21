class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.integer :user_id
      t.boolean :completed
      t.boolean :public

      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end
