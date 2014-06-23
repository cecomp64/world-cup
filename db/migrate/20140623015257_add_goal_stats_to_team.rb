class AddGoalStatsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :goals_for, :integer
    add_column :teams, :goals_against, :integer
  end
end
