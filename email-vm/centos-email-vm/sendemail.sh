#!/bin/bash

NOW=$(date)

TO="vishwa.dwp@gmail.com"
SUB="Akamai error encountered at $NOW"
MSG="The error occurred at $NOW, Contact the GYSP DevOps.."

echo -e "To: $TO\nSubject: $SUB\n\n$MSG" | ssmtp -t

echo Done

