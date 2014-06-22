# World Cup Simulator
#   Take a roster of teams and some stats and outcomes
#   Calculate who advances, and permutations for advancing for each team (N rounds)

RESULTS = [None: 0, Win: 1, Lose: 2, Tie: 3]
TEAM = [Home: 0, Away: 1, None: 2]

# A matchup represents two teams and their score
class Matchup

  attr_accessor :homeTeam, :awayTeam, :homeScore, :awayScore, :final
  def initialize(home, away, homeS=0, awayS=0, final=0)
    @final = final
    @homeTeam = home
    @awayTeam = away
    @homeScore = homeS
    @awayScore = awayS
  end

  def winner
    if (@homeScore > @awayScore)
      return @homeTeam
    elsif (@awayScore > @homeScore)
      return @awayTeam
    else
      return TEAM[:None]
    end
  end

  def tie
    return ((@homeScore == @awayScore) and @final)
  end

  # Calculate the result of this match for a given team
  def result(team)
    # If this team is not in the match, return none
    valid = ((team == @homeTeam or team == @awayTeam) and @final)

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


class Team

  attr_accessor :wins, :loss, :ties, :name
  def initialize(name, matches=[], wins=0, loss=0, ties=0)
    @name = name
    @wins = wins
    @loss = loss
    @ties = ties
    @matches = matches
  end

  def ==(other_team)
    self.name == other_team.name
  end

  # Tally all the results for this team's matchups
  def computeResults
    @matches.each do |match|
      if match.final
        result = match.result(self)
        @wins += (result == RESULTS[:Win] ? 1 : 0)
        @loss += (result == RESULTS[:Lose] ? 1 : 0)
        @ties += (result == RESULTS[:Tie] ? 1 : 0)
      end
    end
  end
end
