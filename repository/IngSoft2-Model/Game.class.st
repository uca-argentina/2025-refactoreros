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

	| duplicatedNames |
	shipNames isNotEmpty ifFalse: [
		Error signal: 'At least one ship is required' ].

	duplicatedNames := shipNames copy asSet select: [ :aName |
		                   (shipNames occurrencesOf: aName) > 1 ].

	duplicatedNames ifNotEmpty: [
		Error signal:
			duplicatedNames asCommaStringAnd , ' listed more than once' ]
]

{ #category : 'validation' }
Game class >> checkValidSquareCount: aSquareCount [

	aSquareCount >= 2 ifFalse: [
		Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'intialization' }
Game class >> gamePlayedBy: shipNames rolling: dice on: aBoard [

	| ships |
	self checkValidDice: dice.
	self checkValidShipNames: shipNames.

	ships := Ship
		         forMultiple: shipNames
		         allStartingAt: (Position atStartOfLapWithSquareNumbers: aBoard numberOfSquares )
		         andAllShieldedWith: 3.

	^ self new
		  initializeWith: ships
		  rolling: dice
		  on: aBoard 
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
Game >> checkIfShipExists: queriedShipName [

	(ships anySatisfy: [ :aShip | aShip playerName = queriedShipName ])
		ifFalse: [ Error signal: 'No ship by that name exists in the game' ]
]

{ #category : 'initialization' }
Game >> initializeWith: aSetOfships rolling: aDice with: aSquareCount and: aLapCount withABoard: aSquareList [

	ships := aSetOfships deepCopy.
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
Game >> lapCountOf: aShipName [

	| queriedShip |
	self checkIfShipExists: aShipName.

	queriedShip := ships detect: [ :aShip | aShip playerName = aShipName ].

	^ queriedShip lapCount 
]

{ #category : 'actions' }
Game >> play [

	| diceOutcome nextSquare aShip |
	self checkForActiveGame.
	aShip := ships addLast: ships removeFirst.
	self checkIfAllowedToPlay: aShip.
	diceOutcome := self rollDice.
	shipManager moveShip: aShip to: diceOutcome.
	nextSquare := squareList at: aShip boardPosition.
	shipManager landShip: aShip atSquare: nextSquare
]

{ #category : 'accessing' }
Game >> positionOf: aShipName [

	| queriedShip |
	self checkIfShipExists: aShipName.

	queriedShip := ships detect: [ :aShip | aShip playerName = aShipName ].

	^ queriedShip boardPosition
]

{ #category : 'accessing' }
Game >> rank: aSetOfShips [

	| shipsOrderedByRanking |
	shipsOrderedByRanking := aSetOfShips sorted: [ :aShip :anotherShip |
		                         | lap1 lap2 pos1 pos2 |
		                         lap1 := aShip lapCount.
		                         lap2 := anotherShip boardPosition.
		                         lap1 = lap2
			                         ifTrue: [
				                         pos1 := aShip boardPosition.
				                         pos2 := anotherShip boardPosition.
				                         pos1 > pos2 ]
			                         ifFalse: [ lap1 > lap2 ] ].

	^ OrderedCollection withAll: shipsOrderedByRanking
]

{ #category : 'accessing' }
Game >> rankingOf: aShipName [

	| queriedShip |
	self checkIfShipExists: aShipName.
	queriedShip := ships detect: [ :aShip | aShip playerName = aShipName ].
	^ (self rank: ships) indexOf: queriedShip
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

	self isGameFinished ifFalse: [
		Error signal: 'The game is still being played' ].

	^ ((self rank: ships) at: 1) playerName
]
