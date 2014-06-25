class AddRoundToMatchups < ActiveRecord::Migration
  def change
    add_column :matchups, :round_id, :integer

    r = Round.first
    matches = Matchup.find(:all)
  
    # Add a default value for existing matches
    matches.each do |match|
      match.round_id = r.id
      match.save
    end
  end
end
