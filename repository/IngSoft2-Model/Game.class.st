"
A spaceship game.
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'dice',
		'lapsGoal',
		'shipManager',
		'squareList',
		'ships'
	],
	#category : 'IngSoft2-Model-game',
	#package : 'IngSoft2-Model',
	#tag : 'game'
}

{ #category : 'validation' }
Game class >> checkValidDice: aDiceCollection [

	aDiceCollection isNotEmpty ifFalse: [
		Error signal: 'At least one die is required' ]
]

{ #category : 'validation' }
Game class >> checkValidLapCount: aNumberOfLaps [

	aNumberOfLaps >= 1 ifFalse: [
		Error signal: 'Lap count must be equal or higher than 1' ]
]

{ #category : 'validation' }
Game class >> checkValidShips: aShipList [

	aShipList isNotEmpty ifFalse: [
		Error signal: 'At least one ship is required' ]
]

{ #category : 'validation' }
Game class >> checkValidSquareCount: aSquareCount [

	aSquareCount >= 2 ifFalse: [
		Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'intialization' }
Game class >> gamePlayedBy: ships throwing: dice with: aSquareCount and: aLapCount withABoard: aListOfSquares [

	self checkValidDice: dice.
	self checkValidSquareCount: aSquareCount.
	self checkValidShips: ships.
	self checkValidLapCount: aLapCount .

	^ self new
		  initializeWith: ships
		  and: dice
		  and: aSquareCount
		  and: aLapCount
		  and: aListOfSquares
]

{ #category : 'intialization' }
Game class >> gamePlayedBy: ships throwing: dice with: aSquareCount and: aLapCount withABoardGeneratedBy: squareGenerator [

	| aListOfSquares |
	self checkValidDice: dice.
	self checkValidSquareCount: aSquareCount.
	self checkValidShips: ships.
	self checkValidLapCount: aLapCount .

	aListOfSquares := squareGenerator createSquares: aSquareCount.
	^ self new
		  initializeWith: ships
		  and: dice
		  and: aSquareCount
		  and: aLapCount
		  and: aListOfSquares
]

{ #category : 'action' }
Game >> checkForActiveGame [

	self isGameFinished ifTrue: [ Error signal: 'The game has finished' ].
	^ true
]

{ #category : 'actions' }
Game >> generateDiceResult [

	^ (dice collect: [ :die | die roll ]) sum
]

{ #category : 'initialization' }
Game >> initializeWith: aSetOfShips and: aDice and: aSquareCount and: aLapCount and: aSquareList [

	ships := aSetOfShips.
	lapsGoal := aLapCount.
	shipManager := ShipManager2
		               withShips: aSetOfShips
		               andLapLenght: aSquareCount
		               andDice: aDice.
	dice := aDice.
	squareList := aSquareList .
]

{ #category : 'testing' }
Game >> isGameFinished [

	^ shipManager hasAnyShipReachedLaps: lapsGoal
]

{ #category : 'actions' }
Game >> play [

	| diceOutcome nextPosition nextSquare aShip |
	self checkForActiveGame.
	aShip := ships removeFirst.
	(shipManager hasTurnSkips: aShip) ifTrue: [
		Error signal: aShip , ' must skip this turn' ].
	diceOutcome := self generateDiceResult.
	nextPosition := shipManager
		                obtainNextPositionFor: aShip
		                with: diceOutcome.
	shipManager moveShip: aShip to: diceOutcome.
	nextSquare := squareList at: (nextPosition square).
	shipManager landShip: aShip atSquare: nextSquare.
	shipManager checkBattles: aShip.
	ships add: aShip
]

{ #category : 'accessing' }
Game >> shipLap: aShip [

	^ shipManager shipLap: aShip
]

{ #category : 'accessing' }
Game >> shipPosition: aShip [

	^ shipManager shipPosition: aShip
]

{ #category : 'accessing' }
Game >> shipRankings: aSetOfShips [
	| shipsOrderedByRanking |

	shipsOrderedByRanking := aSetOfShips
		sorted: [:aShip :anotherShip |
		| lap1 lap2 pos1 pos2 |
		lap1 := shipManager shipLap: aShip.
		lap2 := shipManager shipLap: anotherShip.
		lap1 = lap2
			ifTrue: [
				pos1 := shipManager shipPosition: aShip.
				pos2 := shipManager shipPosition: anotherShip.
				pos1 > pos2
			]
			ifFalse: [lap1 > lap2]].

	^ OrderedCollection withAll: shipsOrderedByRanking
]

{ #category : 'actions' }
Game >> skip [

	| aShip |
	self checkForActiveGame.
	aShip := ships removeFirst.
	shipManager skipTurnAndRechargeShields: aShip.
	ships add: aShip
]

{ #category : 'accessing' }
Game >> winner [

	self isGameFinished ifFalse: [
		Error signal: 'The game is still being played' ].
	^ shipManager winner
]
