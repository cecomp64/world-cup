class Team < ActiveRecord::Base
  # Team.matchups, Team.matchups << Matchup, Team.matchups.find
  has_many :matchups, 
           :finder_sql => proc {"select distinct m.* from matchups m, teams t where m.home_id = #{id} or m.away_id = #{id}"}

  has_and_belongs_to_many :groups

  # Get constants
  #helper :all
  include ApplicationHelper

  #def ==(other_team)
  #  self.name == other_team.name
  #end

  def updateResults(match)
    # TODO: Make wins/loss/ties be 0 by default
    if (self.wins != nil)
      result = match.result(self)
      self.wins += (result == "WIN" ? 1 : 0)
      self.loss += (result == "LOSS" ? 1 : 0)
      self.ties += (result == "TIE" ? 1 : 0)
      self.goals_for += match.goals_for(self)
      self.goals_against += match.goals_against(self)
    end
  end

  # Tally all the results for this team's matchups
  def computeResults
    self.wins = 0
    self.loss = 0
    self.ties = 0
    self.goals_for = 0
    self.goals_against = 0

    self.matchups.each do |match|
      if match.final
        updateResults(match)
      end
    end

    # TODO: Handle error
    self.save
  end

  def goal_differential
    return (self.goals_for - self.goals_against)
  end
end
