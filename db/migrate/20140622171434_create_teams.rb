class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.int :wins
      t.int :loss
      t.int :ties
      t.string :name

      t.timestamps
    end
  end
end
