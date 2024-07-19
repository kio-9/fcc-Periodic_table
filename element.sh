if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ $1 =~ ^[0-9]+$ ]]
then
SELECTED_ELEMENT=$($PSQL "SELECT atomic_number,name,symbol,atomic_mass,type,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
else
SELECTED_ELEMENT=$($PSQL "SELECT atomic_number,name,symbol,atomic_mass,type,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$1' OR symbol='$1'")
fi
if [[ -z $SELECTED_ELEMENT ]]
then
echo "I could not find that element in the database."
else
echo "$SELECTED_ELEMENT" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR ATOMIC_MASS BAR TYPE BAR MELTING_POINT BAR BOILING_POINT
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done
fi
fi
