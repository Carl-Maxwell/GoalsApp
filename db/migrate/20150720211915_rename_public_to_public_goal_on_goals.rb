class RenamePublicToPublicGoalOnGoals < ActiveRecord::Migration
  def change
    rename_column :goals, :public, :public_goal
  end
end
