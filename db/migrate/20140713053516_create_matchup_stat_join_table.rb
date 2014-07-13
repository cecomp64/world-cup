class CreateMatchupStatJoinTable < ActiveRecord::Migration
  def change
    create_join_table :matchups, :stats do |t|
      # t.index [:matchup_id, :stat_id]
      # t.index [:stat_id, :matchup_id]
    end

    # Add some stats
    titles = ["Shots On Goal", "Fouls", "Corner Kicks", "Offsides", "% Time of Possession", "Yellow Cards", "Red Cards", "Saves"]
    keys = ["SG", "F", "CK", "OFF", "TPOS", "YEL", "RED", "SAVE"]

    titles.each_with_index do |title, i|
      stat = Stat.new(title: title, key: keys[i])
      stat.save
    end
  end
end
