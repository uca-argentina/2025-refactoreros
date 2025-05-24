"
Creates a game board.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'shipCount',
		'squareCount',
		'shipList',
		'finalShipAndPosition',
		'dice',
		'gameFinished',
		'winner',
		'wormhole',
		'shipsPositions',
		'shipsLaps',
		'lapsGoal'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Board class >> checkValidDiceCollection: aDiceCollection [

	aDiceCollection isNotEmpty ifFalse: [
		Error signal: 'At least one die is required' ]
]

{ #category : 'validation' }
Board class >> checkValidShipList: aShipList [

	aShipList isNotEmpty ifFalse: [
		Error signal: 'At least one ship is required' ]
]

{ #category : 'validation' }
Board class >> checkValidSquareCount: aSquareCount [

	aSquareCount >= 2 ifFalse: [
		Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'intialization' }
Board class >> gameWithShipList: aShipList andDice: aDiceCollection andSquareCount: aSquareCount andLaps: aNumberOfLaps andWormhole: aWormhole [

	self checkValidDiceCollection: aDiceCollection.
	self checkValidSquareCount: aSquareCount.
	self checkValidShipList: aShipList.

	^ self new
		  newGameWithShipList: aShipList
		  andDice: aDiceCollection
		  andSquareCount: aSquareCount
		  andLaps: aNumberOfLaps
		  andWormhole: aWormhole
]

{ #category : 'actions' }
Board >> checkIfShipWon: aShip [

	| shipCurrentPosition shipCurrentLaps lastTurnCompletedLaps |
	shipCurrentPosition := shipsPositions at: aShip.
	shipCurrentLaps := shipsLaps at: aShip.
	lastTurnCompletedLaps := shipCurrentPosition // squareCount.

	shipCurrentPosition >= squareCount ifTrue: [
		shipsLaps at: aShip put: shipCurrentLaps + lastTurnCompletedLaps.
		shipsPositions at: aShip put: shipCurrentPosition - (lastTurnCompletedLaps * squareCount) 
			].


	((shipsLaps at: aShip) >= lapsGoal) ifTrue: [
		gameFinished := true.
		winner := aShip 
		].
]

{ #category : 'initialization' }
Board >> createShipsLaps [
	
	(1 to: shipCount) do:[ :i | shipsLaps at:(shipList at: i) put: 0 ]
]

{ #category : 'initialization' }
Board >> createShipsPositions [

	1 to: shipCount do: [ :i | shipsPositions at: (shipList at: i) put: 1 ]
]

{ #category : 'actions' }
Board >> generateDiceResult [

	^ (dice collect: [ :die | die roll ]) sum
]

{ #category : 'accessing' }
Board >> getShipLap: aShip [

	^ (shipsLaps at: aShip) 
	
	
]

{ #category : 'accessing' }
Board >> getShipPosition: aShip [

	^ shipsPositions at: aShip 
	
	
]

{ #category : 'comparing' }
Board >> getWinner [

	gameFinished
		ifFalse: [ Error signal: 'Game is not finishied' ]
		ifTrue: [ ^ winner ]
]

{ #category : 'testing' }
Board >> isGameFinished [ 

	^ gameFinished
]

{ #category : 'initialization' }
Board >> newGameWithShipList: aShipList andDice: aDiceCollection andSquareCount: aSquareCount andLaps: aNumberOfLaps andWormhole: aWormhole [

	shipCount := aShipList size.
	shipList := aShipList.
	lapsGoal := aNumberOfLaps.
	shipsPositions := Dictionary new.
	self createShipsPositions.
	shipsLaps := Dictionary new.
	self createShipsLaps.
	dice := aDiceCollection.
	squareCount := aSquareCount.
	gameFinished := false.
	wormhole := aWormhole
]

{ #category : 'actions' }
Board >> runGame [

	| diceResult aShip nextPosition |
	[ gameFinished ] whileFalse: [
		1 to: shipCount do: [ :i |
			aShip := shipList at: i.

			diceResult := self generateDiceResult.
			nextPosition := (shipsPositions at: aShip) + diceResult.
			
			(wormhole isAWormHoleEnd: nextPosition) ifTrue:[
				nextPosition := wormhole oppositeEnd: nextPosition.
				]. 
			
			shipsPositions at: aShip put: nextPosition.
			self checkIfShipWon: (aShip) ] ]
]
