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
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
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
Game class >> checkValidShipNames: shipNames [

	shipNames isNotEmpty ifFalse: [
		Error signal: 'At least one ship is required' ]
]

{ #category : 'validation' }
Game class >> checkValidSquareCount: aSquareCount [

	aSquareCount >= 2 ifFalse: [
		Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'intialization' }
Game class >> gamePlayedBy: shipNames rolling: dice and: aLapCount withABoard: squares [

	self checkValidDice: dice.
	self checkValidSquareCount: squares size.
	self checkValidShipNames: shipNames.
	self checkValidLapCount: aLapCount.

	^ self new
		  initializeWith: shipNames
		  rolling: dice
		  with: squares size
		  and: aLapCount
		  withABoard: squares
]

{ #category : 'intialization' }
Game class >> gamePlayedBy: shipNames rolling: dice with: aSquareCount and: aLapCount withABoardGeneratedBy: squareGenerator [

	| squares |
	self checkValidDice: dice.
	self checkValidSquareCount: aSquareCount.
	self checkValidShipNames: shipNames.
	self checkValidLapCount: aLapCount.

	squares := squareGenerator createSquares: aSquareCount.
	^ self new
		  initializeWith: shipNames
		  rolling: dice
		  with: aSquareCount
		  and: aLapCount
		  withABoard: squares
]

{ #category : 'actions' }
Game >> checkForActiveGame [

	self isGameFinished ifTrue: [ Error signal: 'The game has finished' ].
	^ true
]

{ #category : 'actions' }
Game >> checkIfAllowedToPlay: aShip [

	(shipManager hasTurnSkips: aShip) ifTrue: [
		Error signal: aShip , ' must skip this turn' ]
]

{ #category : 'actions' }
Game >> checkIfItsPartOfTheGame: queriedShip [

	ships
		detect: [ :aShip | aShip = queriedShip ]
		ifNone: [ Error signal: 'There is no such ship at current game' ]
]

{ #category : 'initialization' }
Game >> initializeWith: shipNames rolling: aDice with: aSquareCount and: aLapCount withABoard: aSquareList [

	ships := shipNames.
	lapsGoal := aLapCount.
	shipManager := ShipManager
		               withShips: ships
		               andDice: aDice.
	dice := aDice deepCopy.
	squareList := aSquareList deepCopy
]

{ #category : 'accessing' }
Game >> isGameFinished [

	^ ships anySatisfy: [ :ship | ship hasReachedLap: lapsGoal ]
]

{ #category : 'accessing' }
Game >> lapCountOf: aShip [

	self checkIfItsPartOfTheGame: aShip.

	^ aShip position lap
]

{ #category : 'actions' }
Game >> play [

	| diceOutcome nextSquare aShip |
	self checkForActiveGame.
	aShip := ships addLast: ships removeFirst.
	self checkIfAllowedToPlay: aShip.
	diceOutcome := self rollDice.
	shipManager moveShip: aShip to: diceOutcome.
	nextSquare := squareList at: (self positionOf: aShip).
	shipManager landShip: aShip atSquare: nextSquare
]

{ #category : 'accessing' }
Game >> positionOf: aShip [

	self checkIfItsPartOfTheGame: aShip.

	^ aShip position square
]

{ #category : 'accessing' }
Game >> rank: aSetOfShips [

	| shipsOrderedByRanking |
	shipsOrderedByRanking := aSetOfShips sorted: [ :aShip :anotherShip |
		                         | lap1 lap2 pos1 pos2 |
		                         lap1 := self lapCountOf: aShip.
		                         lap2 := self lapCountOf: anotherShip.
		                         lap1 = lap2
			                         ifTrue: [
				                         pos1 := self positionOf: aShip.
				                         pos2 := self positionOf: anotherShip.
				                         pos1 > pos2 ]
			                         ifFalse: [ lap1 > lap2 ] ].

	^ OrderedCollection withAll: shipsOrderedByRanking
]

{ #category : 'actions' }
Game >> rollDice [

	^ (dice collect: [ :die | die roll ]) sum
]

{ #category : 'actions' }
Game >> skip [

	| aShip |
	self checkForActiveGame.
	aShip := ships addLast: ships removeFirst.
	shipManager skipTurnAndRechargeShields: aShip
]

{ #category : 'accessing' }
Game >> winner [

	| rankedShips |
	self isGameFinished ifFalse: [
		Error signal: 'The game is still being played' ].

	rankedShips := ships asSortedCollection: [ :aShip :anotherShip |
		               aShip position square > anotherShip position square ].

	^ (rankedShips at: 1) playerName
]
