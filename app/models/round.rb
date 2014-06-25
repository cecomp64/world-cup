class Round < ActiveRecord::Base
  has_many :groups
  has_many :matchups

  def group_winner(group)
    if(self.name == "GROUP")
      return group_winner_group(group)
    end
  end

  def group_runnerup(group)
    if(self.name == "GROUP")
      return group_runnerup_group(group)
    end
  end

  # First place in group stage
  def group_winner_group(group)
    winners = group_winners_group(group)
    return winners[0]
  end

  # Second place in group stage
  def group_runnerup_group(group)
    winners = group_winners_group(group)
    return winners[1]
  end

  # Find a winner for the GROUP stage
  def group_winners_group(group)
    # Sort by most points
    team_l = group.teams.sort_by(&:points).reverse

    first_place  = team_l[0]
    second_place = team_l[1]

    # Look for tie-breakers
    first_ties = []
    second_ties = []
    team_l.each do |team|
      if team.points == first_place.points
        first_ties << team
      end
      if team.points == second_place.points
        second_ties << team
      end
    end

    # Break the ties
    first_place = n_way_tie(first_ties)
    second_ties.delete(first_place)
    second_place = n_way_tie(second_ties)

    return [first_place, second_place]
  end

  # Break an n-way tie
  def n_way_tie(ties)
    winner = ties[0]
    if ties.size > 1
      n=0
      while(ties[n+1] != nil)
        winner = tie_breaker(ties[n], ties[n+1])
        n += 1
      end
    end

    return winner
  end

  # Do a tie-breaker for each team
  def tie_breaker(team1, team2)
    if (team1.points == team2.points)
      # If points are equal, check goal differential
      if (team1.goal_differential == team2.goal_differential)
        # If GD is equal, check total goals
        if (team1.goals_for == team2.goals_for)
          # Find results of head-head game
          away_winner = Matchup.where(away_team: team1, home_team: team2, round: self).where(final: true).where("awayScore > homeScore")
          home_winner = Matchup.where(home_team: team1, away_team: team2, round: self).where(final: true).where("homeScore > awayScore")

          if (away_winner.empty? and home_winner.empty? )
            # Finally, random
            return (rand(2) == 0) ? team1 : team2
          else
            return (away_winner.empty?) ? home_winner[0] : away_winner[0]
          end
        else
          return (team1.goals_for > team2.goals_for) ? team1 : team2
        end
      else
        return (team1.goal_differential > team2.goal_differential) ? team1 : team2
      end
    else
      return (team1.points > team2.points) ? team1 : team2
    end

  end
end
