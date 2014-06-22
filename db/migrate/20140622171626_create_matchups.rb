class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :home_id
      t.integer :away_id
      t.integer :homeScore
      t.integer :awayScore
      t.boolean :final

      t.timestamps
    end
  end
end
