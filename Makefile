
.PHONY: default algorithm

default:

algorithm:
	snowball ./algorithms/dolamic.sbl -rust -o ./src/snowball/algorithms/dolamic
