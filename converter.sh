#Write a script that prompts the user for an amount in their local currency and displays the equivalent value in another currency. Use a loop for continuous input and consider APIs for real-time conversion rates (may require additional research).
#
#!/bin/bash
read -p "enter your base currency : " FROM
read -p "enter the target currency : " TO

while true
do
	read -p "enter amount in $FROM: " AMOUNT

	if [[ "$AMOUNT" == "exit" ]] 
	then
		echo "exiting..."
		break
	fi

	if ! [[ "$AMOUNT" =~ ^[0-9]+([.][0-9]+)?$ ]]
	then
		echo "invalid amount.Please enter a numeric value"
		continue
	fi

	RESPONSE=$(curl -s "https://open.er-api.com/v6/latest/${FROM^^}")

	SUCCESS=$(echo "$RESPONSE" | grep -o '"result":"success"')
	if [[ -z "$SUCCESS" ]]
	then
		echo "failed to fetch exchange rate"
		continue
	fi
	RATE=$(echo "$RESPONSE" | grep -oP "\"${TO^^}\":[0-9.]+")
	RESULT=$(echo "$RATE" | grep -oP "[0-9.]+$")

	if [ -n "$RESULT" ]
	then
		CONVERTED=$(echo "$AMOUNT  *  $RESULT" | bc -l)
		echo "$AMOUNT $FROM = $CONVERTED $TO"
	else
		echo "Conversion failed . Invalid target currency"
	fi
done

