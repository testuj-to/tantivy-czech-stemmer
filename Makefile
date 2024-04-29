
.PHONY: default algorithms

default:

algorithms:
	snowball ./algorithms/dolamic_aggressive.sbl -rust -o ./src/snowball/algorithms/dolamic_aggressive
	snowball ./algorithms/dolamic_light.sbl -rust -o ./src/snowball/algorithms/dolamic_light
