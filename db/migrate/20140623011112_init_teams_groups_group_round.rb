require 'csv'

class InitTeamsGroupsGroupRound < ActiveRecord::Migration
  def up
    # Read in all teams in 2014 world cup
    team_f = "data/teams.csv"
    team_l = CSV.parse(File.read(team_f), :headers=>true)

    team_l.each do |team|
      t = Team.create(:name=>team["Team"])
      #t = compute
    end

    # This is data for the GROUP round
    r = Round.create(:name => "GROUP")

    # Read in all the groupings
    group_f = "data/groups.csv"
    group_l = CSV.parse(File.read(group_f), :headers=>true)

    group_l.each do |group| 
      # Create a new group if it doesn't exist
      name = group[0]
      team_name = group[1]
      g = Group.find_by_name(name)
      if (not g)
        g = Group.create(:name=>group[0])
        r.groups << g
      end

      # Find the team, add it to this group
      team = Team.find_by_name(team_name)
      if (team)
        g.teams << team
      else
        puts "WARNING - Could not find " + team
      end
    end

    # Read in all the match data and scores as of 6/21
    match_f = "data/matches.csv"
    match_l = CSV.parse(File.read(match_f), :headers=>true)

    match_l.each do |match|
      home = Team.find_by_name(match[0])
      home_score = match[1].to_i
      away = Team.find_by_name(match[2])
      away_score = match[3].to_i
      final = match[4]

      # Create a new match object
      if (home and away)
        m = Matchup.create(:home_id => home.id, :away_id => away.id, :homeScore => home_score, :awayScore => away_score, :final => final)
      else
        puts "WARNING - Could not find home or away team " + match[0] + "/" + match[2]
      end
    end

    # Compute scores
  end

  def down
    Team.delete_all
    Matchup.delete_all
    Group.delete_all
    Round.delete_all
  end
end
