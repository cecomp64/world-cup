class Matchup < ActiveRecord::Base
  # Defines accessors for home/away_team
  # i.e.  Matchup.home_team, Matchup.home_team = team, Matchup.build_home_team(), Matchup.create_home_teat()
  belongs_to :home_team,
             :class_name => "Team",
             :foreign_key => "home_id"

  belongs_to :away_team,
             :class_name => "Team",
             :foreign_key => "away_id"

  before_save :update_teams
  # Get constants
  include ApplicationHelper

  # Figure out who won and return the team
  def winner
    if (self.homeScore > self.awayScore)
      return self.home_team
    elsif (self.awayScore > self.homeScore)
      return self.away_team
    else
      return nil
    end
  end

  def tie
    return ((self.homeScore == self.awayScore) and self.final)
  end

  # Calculate the result of this match for a given team
  # TODO: Refactor this to use a better enum/constant type
  def result(team)
    # If this team is not in the match, return none
    valid = ((team.id == self.home_team.id or team.id == self.away_team.id) and self.final)
    
    puts "Valid: #{valid.to_s}"

    if (valid)
      # Figure out if this team won or lost
      if self.winner == team
        return "WIN"
      elsif self.tie
        return "TIE"
      else
        return "LOSS"
      end
    else
      return nil
    end
  end

  # Return the goals score by the input team
  def goals_for(team)
    valid = ((team == self.home_team or team == self.away_team) and self.final)

    if (valid)
      if (self.home_team == team)
        return self.homeScore
      else
        return self.awayScore
      end
    else
      return 0
    end
  end

  # Return the goals scored agains the input team
  def goals_against(team)
    valid = ((team == self.home_team or team == self.away_team) and self.final)

    if (valid)
      if (self.home_team == team)
        return self.awayScore
      else
        return self.homeScore
      end
    else
      return 0
    end
  end

  private
    # Compute new results for the new matchup
    def update_teams
      if (home_team != nil and away_team != nil)
        puts "Updating teams"
        #match = Matchup.new(params)
        home_team.updateResults(self)
        away_team.updateResults(self)
        home_team.save
        away_team.save
      else
        return false
      end
    end
end
