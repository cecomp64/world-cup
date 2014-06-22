class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :wins
      t.integer :loss
      t.integer :ties
      t.string :name

      t.timestamps
    end
  end
end
