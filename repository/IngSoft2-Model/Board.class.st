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
		'wormhole',
		'lapsGoal',
		'shipManager',
		'squareList'
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
Board class >> checkValidLapCount: aNumberOfLaps [

	aNumberOfLaps >= 1 ifFalse: [
		Error signal: 'Lap count must be equal or higher than 1' ]
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
	self checkValidLapCount: aNumberOfLaps .

	^ self new
		  newGameWithShipList: aShipList
		  andDice: aDiceCollection
		  andSquareCount: aSquareCount
		  andLaps: aNumberOfLaps
		  andWormhole: aWormhole
]

{ #category : 'initialization' }
Board >> createSquareList [

	squareList := OrderedCollection new.

	(1 to: squareCount*lapsGoal) do: [ :i | squareList add: (EmptySquare withPositionAt:i ) ]
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
		ifTrue: [ ^ shipManager getWinner ]
		ifFalse: [ Error signal: 'The game is still being played' ]
]

{ #category : 'testing' }
Board >> isGameFinished [ 

	^ gameFinished
]

{ #category : 'initialization' }
Board >> newGameWithShipList: aNewGame andDice: aDice andSquareCount: aSquareCount andLaps: aLaps andWormhole: aWormhole [

	shipList := aNewGame.
	lapsGoal := aLaps.
	shipManager := ShipManager withShips: aNewGame andLapLenght: aSquareCount.
	dice := aDice.
	squareCount := aSquareCount.
	self createSquareList.
	gameFinished := false.
	wormhole := aWormhole
]

{ #category : 'actions' }
Board >> newLapAdjustedPositionForShip: aShip thatLandedOn: aPosition [

	| lapAdjustedPosition |
	shipManager
		placeTheShip: aShip
		position: aPosition 
		withLapLength: squareCount.

	lapAdjustedPosition := shipManager getShipPosition: aShip.
	^ lapAdjustedPosition
]

{ #category : 'actions' }
Board >> runGame [

	| diceResult nextPosition nextSquare nextSquarePosition |
	[ gameFinished ] whileFalse: [
		shipList do: [ :aShip |
			gameFinished ifFalse: [
				
				diceResult := self generateDiceResult.
				nextPosition := shipManager
					                calculateNextPositionFor: aShip
					                with: diceResult.

				
				nextSquarePosition := shipManager calculateLandingPositionFor: aShip movingTo: (nextPosition % squareCount).
				nextSquare := squareList at: nextSquarePosition.
				
				shipManager moveShip: aShip to: nextPosition.
				
				shipManager landShip: aShip atSquare: nextSquare.
				
				gameFinished := shipManager
					                hasShip: aShip
					                reachedLapGoal: lapsGoal ] ] ]
]
