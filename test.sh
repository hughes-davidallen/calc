#!/bin/sh

CALC=./calc.native

TESTS=0
FAILURES=0

function evalAndAssertEquals() {
  ((TESTS++))
  result=$(echo "$1" | $CALC)
  if [ "$result" != "$2" ]; then
    echo "FAIL: $3: expected $2 but got $result"
    ((FAILURES++))
  fi
}

# Tests for simple integer arithmetic
evalAndAssertEquals "1+1" "2" "Basic integer addition"
evalAndAssertEquals "3-1" "2" "Basic integer subtraction"
evalAndAssertEquals "8/2" "4" "Basic even integer division"
evalAndAssertEquals "8/3" "2" "Basic rounded integer division"
evalAndAssertEquals "3*4" "12" "Basic integer multiplication"
evalAndAssertEquals "-3+8" "5" "Unary minus operator"

# Tests to verify the order of operations
evalAndAssertEquals "3*4+2*7" "26" "Multiply has precedence over add"
evalAndAssertEquals "3*7-2*4" "13" "Multiply has precedence over subtract"
evalAndAssertEquals "(2+3)*3" "15" "Parentheses have precedence over mutliply"

evalAndAssertEquals " 1   +  1 " "2" "White space is ignored"

if [ "$FAILURES" -eq "0" ]; then
  echo "\nAll $TESTS tests passed!"
else
  echo "\n$FAILURES of $TESTS tests failed."
fi

exit $FAILURES
