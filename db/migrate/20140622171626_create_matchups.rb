class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.int :homeScore
      t.int :awayScore
      t.bool :final

      t.timestamps
    end
  end
end
