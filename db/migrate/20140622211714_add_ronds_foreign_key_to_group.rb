class AddRondsForeignKeyToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :round_id, :integer
  end
end
