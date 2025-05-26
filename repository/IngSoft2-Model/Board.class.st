"
Creates a game board.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squareCount',
		'shipList',
		'dice',
		'gameFinished',
		'winner',
		'wormhole',
		'shipsPositions',
		'shipsLaps',
		'lapsGoal',
		'shipManager'
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

{ #category : 'actions' }
Board >> generateDiceResult [

	^ (dice collect: [ :die | die roll ]) sum
]

{ #category : 'accessing' }
Board >> getShipLap: aShip [

	^ shipManager getShipLap: aShip
]

{ #category : 'accessing' }
Board >> getShipPosition: aShip [

	^ shipManager getShipPosition: aShip
]

{ #category : 'accessing' }
Board >> getWinner [

	gameFinished
		ifFalse: [ Error signal: 'The game is still being played' ]
		ifTrue: [ ^ shipManager getWinner ]
]

{ #category : 'testing' }
Board >> isGameFinished [ 

	^ gameFinished
]

{ #category : 'initialization' }
Board >> newGameWithShipList: aShipList andDice: aDiceCollection andSquareCount: aSquareCount andLaps: aNumberOfLaps andWormhole: aWormhole [

	shipList := aShipList.
	lapsGoal := aNumberOfLaps.
	shipManager := ShipManager withShips: aShipList.
	dice := aDiceCollection.
	squareCount := aSquareCount.
	gameFinished := false.
	wormhole := aWormhole
]

{ #category : 'actions' }
Board >> runGame [

	| diceResult nextPosition |
	[ gameFinished ] whileFalse: [
		shipList do: [ :aShip |

			diceResult := self generateDiceResult.
			nextPosition := shipManager
				                manageNextPositionFor: aShip
				                with: diceResult.

			(wormhole isAWormHoleEnd: nextPosition) ifTrue: [
				nextPosition := wormhole oppositeEnd: nextPosition ].


			shipsPositions at: aShip put: nextPosition.
			self checkIfShipWon: aShip ] ]
]
