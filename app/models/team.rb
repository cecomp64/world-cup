class Team < ActiveRecord::Base
  # Team.matchups, Team.matchups << Matchup, Team.matchups.find
  has_many :matchups, 
           :finder_sql => "select m.* from matchups m where m.home_id = id or m.away_id = id"

  has_and_belongs_to_many :groups

  # Get constants
  #helper :all
  include ApplicationHelper

  def ==(other_team)
    self.name == other_team.name
  end

  # Tally all the results for this team's matchups
  def computeResults
    self.wins = 0
    self.loss = 0
    self.ties = 0

    self.matchups.each do |match|
      if match.final
        result = match.result(self)
        self.wins += (result == RESULTS[:Win] ? 1 : 0)
        self.loss += (result == RESULTS[:Lose] ? 1 : 0)
        self.ties += (result == RESULTS[:Tie] ? 1 : 0)
      end
    end

    # TODO: Handle error
    self.save
  end

end
