PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]]
then

  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
  OUTPUT_VARIABE=$($PSQL "SELECT * FROM properties LEFT JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.symbol = '$1' OR elements.name = '$1'")

  elif [[ -z $OUTPUT_VARIABE ]]
  then
     OUTPUT_VARIABE=$($PSQL "SELECT * FROM properties LEFT JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
  fi

 
  if [[ -n $OUTPUT_VARIABE ]]
  then
    echo "$OUTPUT_VARIABE" | while IFS="|" read T_ID AN AM MP BP SYMBOL NAME T
    do
    echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $T, with a mass of $AM amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
    done
  else
    echo "I could not find that element in the database."
  fi
else
  echo "Please provide an element as an argument."
fi
