class Matchup < ActiveRecord::Base
  # Defines accessors for home/away_team
  # i.e.  Matchup.home_team, Matchup.home_team = team, Matchup.build_home_team(), Matchup.create_home_teat()
  belongs_to :home_team,
             :class_name => "Team",
             :foreign_key => "home_id"

  belongs_to :away_team,
             :class_name => "Team",
             :foreign_key => "away_id"

  # Get constants
  include ApplicationHelper

  # Figure out who won and return the team
  def winner
    if (self.homeScore > self.awayScore)
      return self.home_team
    elsif (self.awayScore > self.homeScore)
      return self.away_team
    else
      return TEAM[:None]
    end
  end

  def tie
    return ((self.homeScore == self.awayScore) and self.final)
  end

  # Calculate the result of this match for a given team
  # TODO: Refactor this to use a better enum/constant type
  def result(team)
    # If this team is not in the match, return none
    valid = ((team == self.home_team or team == self.awayTeam) and self.final)

    if (valid)
      # Figure out if this team won or lost
      if self.winner == team
        return RESULTS[:Win]
      elsif self.tie
        return RESULTS[:Tie]
      else
        return RESULTS[:Lose]
      end
    else
      return RESULTS[:None]
    end
  end

end
