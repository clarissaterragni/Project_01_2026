Assumptions made during my reasonings:

* the user never selects a time or frequency equal to 0
* the delay implemented is integer, as number of clock cycles. If the user selects generic values of delay and clock frequency which result in non-integer number of clock periods, the counter\_limit is approximated to the nearest lower integer number
* if the delay is smaller than one clock period (given the chosen clock frequency), the timer does not count any cycles
