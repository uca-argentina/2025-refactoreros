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
		'shipsPositions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
Board class >> checkValidDiceCollection: aDiceCollection [

	aDiceCollection isNotEmpty ifFalse: [
		Error signal: 'At least one die is required' ]
]

{ #category : 'argument validation' }
Board class >> checkValidPlayerCount: aPlayerCount [

	aPlayerCount >= 1 ifFalse: [
		Error signal: 'Player count should be equal or higher than 1' ]
]

{ #category : 'argument validation' }
Board class >> checkValidSquareCount: aSquareCount [

	aSquareCount >= 2 ifFalse: [
		Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'intialization' }
Board class >> gameWithPlayerCount: aPlayerCount andDice: aDiceCollection andSquareCount: aSquareCount andWormhole: aWormhole [

	self checkValidPlayerCount: aPlayerCount.
	self checkValidDiceCollection: aDiceCollection.
	self checkValidSquareCount: aSquareCount.

	^ self new
		  newGameWithPlayerCount: aPlayerCount
		  andDice: aDiceCollection
		  andSquareCount: aSquareCount
		  andWormhole: aWormhole 
]

{ #category : 'actions' }
Board >> checkIfShipWon: aShip [

	(shipsPositions at: aShip) >= squareCount ifTrue: [
		gameFinished := true.
		winner := aShip ]
]

{ #category : 'initialization' }
Board >> createShipsPositions [

	1 to: shipCount do: [ :i | shipsPositions at: (shipList at: i) put: 1 ]
]

{ #category : 'actions' }
Board >> generateDiceResult [

	^ (dice collect: [ :die | die roll ]) sum
]

{ #category : 'comparing' }
Board >> getWinner [

	gameFinished
		ifFalse: [ Error signal: 'Game is not finishied' ]
		ifTrue: [ ^ winner ]
]

{ #category : 'initialization' }
Board >> newGameWithShipList: aShipList andDice: aDiceCollection andSquareCount: aSquareCount andWormhole: aWormhole [

	shipCount := aShipList size.
	shipList := aShipList.
	shipsPositions := Dictionary new.
	self createShipsPositions.
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
