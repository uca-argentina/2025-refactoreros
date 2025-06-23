"
A spaceship game.
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'lapsGoal',
		'shipManager',
		'ships',
		'board',
		'activeCards'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

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

{ #category : 'initialization' }
Game class >> createShipsNamed: shipNames on: squareCount drawingFrom: allCards [

	| ships cards |
	ships := OrderedCollection new.

	1 to: shipNames size do: [ :i |
		cards := OrderedCollection new.
		cards add: allCards atRandom.
		cards add: allCards atRandom.

		ships add: (Ship
				 for: (shipNames at: i)
				 startingAt: (Position atStartOfLapWithSquareNumbers: squareCount)
				 shieldedWith: 3
				 holding: cards) ].
	^ ships
]

{ #category : 'initialization' }
Game class >> gamePlayedBy: shipNames on: aBoard toPlayFor: aLapGoal [

	| ships allCards |
	self checkValidShipNames: shipNames.
	self checkValidLapCount: aLapGoal.

	allCards := {
		            SpeedCard new.
		            MercenaryCard new.
		            AccelerationCard new.
		            CancellationCard new.
		            RedoCard new.
		            RepeatCard new }.
	ships := self
		         createShipsNamed: shipNames
		         on: aBoard numberOfSquares
		         drawingFrom: allCards.


	^ self new initializeWith: ships on: aBoard toPlayFor: aLapGoal
]

{ #category : 'initialization' }
Game class >> gamePlayedBy: shipNames on: aBoard toPlayFor: aLapGoal drawingFrom: aDeckOfCards [

	| ships cards |
	self checkValidShipNames: shipNames.
	self checkValidLapCount: aLapGoal.

	ships := OrderedCollection new.

	1 to: shipNames size do: [ :i |
		cards := OrderedCollection new.
		cards add: aDeckOfCards removeFirst.
		cards add: aDeckOfCards removeFirst.
		ships add: (Ship
				 for: (shipNames at: i)
				 startingAt:
				 (Position atStartOfLapWithSquareNumbers: aBoard numberOfSquares)
				 shieldedWith: 3
				 holding: cards) ].

	^ self new initializeWith: ships on: aBoard toPlayFor: aLapGoal
]

{ #category : 'actions' }
Game >> applyCancellationTo: aTarget [

	| cardToBeCancelled |
	(activeCards anySatisfy: [ :aCard |
		 aCard name = aTarget cardName and:
			 aCard ownerName = aTarget shipName ]) ifFalse: [
		Error signal: 'Targeted Card is not within active permanent cards' ].

	cardToBeCancelled := activeCards detect: [ :aCard |
		                     aCard name = aTarget cardName and:
			                     aCard ownerName = aTarget shipName ].
	activeCards remove: cardToBeCancelled
]

{ #category : 'accessing' }
Game >> cardsInHandOf: aShipName [

	| queriedShip |
	

	queriedShip := self searchShipByName: aShipName.

	^ queriedShip cardsInHand
]

{ #category : 'actions' }
Game >> checkForActiveGame [

	self isGameFinished ifTrue: [ Error signal: 'The game has finished' ].
	^ true
]

{ #category : 'actions' }
Game >> checkIfAllowedToPlay: aShip [

	(shipManager hasTurnSkips: aShip) ifTrue: [
		Error signal: aShip playerName , ' must skip this turn' ]
]

{ #category : 'initialization' }
Game >> initializeWith: aSetOfships on: aBoard toPlayFor: aNumberOfLaps [

	ships := aSetOfships deepCopy.
	lapsGoal := aNumberOfLaps.
	shipManager := ShipManager withShips: ships.
	board := aBoard.
	activeCards := OrderedCollection new.
]

{ #category : 'accessing' }
Game >> isGameFinished [

	^ ships anySatisfy: [ :ship | ship hasReachedLap: lapsGoal ]
]

{ #category : 'accessing' }
Game >> lapCountOf: aShipName [

	| queriedShip |
	queriedShip := self searchShipByName: aShipName.


	^ queriedShip lapCount
]

{ #category : 'actions' }
Game >> play [

	| diceOutcome nextSquare aShip extraPointsForThrow |
	self checkForActiveGame.
	aShip := ships addLast: ships removeFirst.
	self checkIfAllowedToPlay: aShip.
	diceOutcome := board rollDice.
	extraPointsForThrow := 0.
	activeCards do: [:aCard | extraPointsForThrow := extraPointsForThrow +  (aCard applyThrowEffectFor: aShip) ].
	
	shipManager moveShip: aShip to: (diceOutcome + extraPointsForThrow).
	nextSquare := board squareAt: aShip boardPosition.
	shipManager landShip: aShip atSquare: nextSquare on: board
]

{ #category : 'accessing' }
Game >> positionOf: aShipName [

	| queriedShip |
	queriedShip := self searchShipByName: aShipName.

	^ queriedShip boardPosition
]

{ #category : 'accessing' }
Game >> rank: aSetOfShips [

	| shipsOrderedByRanking |
	shipsOrderedByRanking := aSetOfShips sorted: [ :aShip :anotherShip |
		                         aShip hasGreaterPosition: anotherShip ].

	^ OrderedCollection withAll: shipsOrderedByRanking
]

{ #category : 'accessing' }
Game >> rankingOf: aShipName [

	| queriedShip |
	queriedShip := self searchShipByName: aShipName.

	^ (self rank: ships) indexOf: queriedShip
]

{ #category : 'actions' }
Game >> searchShipByName: queriedShipName [

	^ ((ships select: [ :aShip | aShip playerName = queriedShipName ])
		   ifEmpty: [
		   Error signal: 'No ship by that name exists in the game' ]) at: 1
]

{ #category : 'accessing' }
Game >> shieldfOf: aShipName [

	| queriedShip |
	queriedShip := self searchShipByName: aShipName.

	^ queriedShip shields
]

{ #category : 'actions' }
Game >> skip [

	| aShip |
	self checkForActiveGame.
	aShip := ships addLast: ships removeFirst.
	aShip rechargeShields
]

{ #category : 'actions' }
Game >> throw: aCardName from: aShipName [

	| queriedShip card |
	queriedShip := self searchShipByName: aShipName.

	card := queriedShip throw: aCardName whenTurnOf: (ships at: 1).

	activeCards add: card
]

{ #category : 'actions' }
Game >> throw: aCardName from: aShipName to: aTarget [

	| queriedShip card |
	queriedShip := self searchShipByName: aShipName.
	card := queriedShip throw: aCardName whenTurnOf: (ships at: 1).



	card isPermanent
		ifTrue: [ activeCards add: card ]
		ifFalse: [ card applyEffectIn: self for: aTarget ]
]

{ #category : 'accessing' }
Game >> winner [

	self isGameFinished ifFalse: [
		Error signal: 'The game is still being played' ].

	^ ((self rank: ships) at: 1) playerName
]
