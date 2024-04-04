#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#$($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

  #CREATE TEAMS TABLE

  #Create if loop that inserts team if not already in table
  if [[ $WINNER != "winner" ]]
  then 
    #get winner id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    #If team doesn't exist
    if [[ -z $WINNER_ID ]]
    then

    #Insert team
      INSERT_TEAMS_RESULTS_WINNER=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")

      if [[ $INSERT_TEAMS_RESULTS_WINNER == "INSERT 0 1" ]]
      then
        echo team inserted
      fi

      #Get winner_id
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      
      echo $WINNER_ID
    fi
  echo $WINNER_ID
  fi

  #Create if loop that inserts team if not already in table
  if [[ $OPPONENT != "opponent" ]]
  then 
    #get opponent id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    #If team doesn't exist
    if [[ -z $OPPONENT_ID ]]
    then

    #Insert team
      INSERT_TEAMS_RESULTS_OPPONENT=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")

      if [[ $INSERT_TEAMS_RESULTS_OPPONENT == "INSERT 0 1" ]]
      then
        echo opponent team inserted
      fi

      #Get OPPONENT_id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      
      echo $OPPONENT_ID
    fi
  echo $OPPONENT_ID
  fi

#Insert data into games table

INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")

echo $INSERT_GAMES_RESULT




done
