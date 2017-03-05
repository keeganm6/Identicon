#!/bin/sh

# Rogier Hof
# 2017-02-28
# Testing loop for Cards.

a=10

until [ $a -lt 10 ]
do
  clear
  echo "=====  START TEST ==============================================="
  echo "Testing loop (infinite loop { mix test > sleep 10 > repeat} )..."
  mix test
  echo "=====  END TEST ================================================="
  sleep 10
done