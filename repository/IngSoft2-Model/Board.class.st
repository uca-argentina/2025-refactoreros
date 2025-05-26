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

{ #category : 'actions' }
Board >> calculateNextSquare: aPosition [

	| squarePosition |

	squarePosition := aPosition.
	(aPosition > squareCount) ifTrue: [ 
			squarePosition := aPosition % squareCount.
		 ].
	
	^ squareList at: squarePosition
	
]

{ #category : 'initialization' }
Board >> creatSquareList [

	squareList := OrderedCollection new.

	(1 to: squareCount*3) do: [ :i | squareList add: (EmptySquare withPositionAt:i ) ]
]

{ #category : 'actions' }
Board >> generateDiceResult [

	^ (dice collect: [ :die | die roll ]) sum
]

{ #category : 'accessing' }
Board >> getShipLap: arg1 [

	^ shipManager getShipLap: arg1
]

{ #category : 'accessing' }
Board >> getShipPosition: arg1 [

	^ shipManager getShipPosition: arg1
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
Board >> newGameWithShipList: arg1 andDice: arg2 andSquareCount: arg3 andLaps: arg4 andWormhole: arg5 [

	shipList := arg1.
	lapsGoal := arg4.
	shipManager := ShipManager withShips: arg1.
	dice := arg2.
	squareCount := arg3.
	self creatSquareList.
	gameFinished := false.
	wormhole := arg5
]

{ #category : 'actions' }
Board >> runGame [

	| diceResult nextPosition nextSquare |
	[ gameFinished ] whileFalse: [
		shipList do: [ :aShip |
			
			gameFinished ifFalse: [ diceResult := self generateDiceResult.
			nextPosition := shipManager
				                manageNextPositionFor: aShip
				                with: diceResult.
			
			nextSquare := self calculateNextSquare: nextPosition.

			(wormhole isAWormHoleEnd: nextPosition) ifTrue: [
				nextPosition := wormhole oppositeEnd: nextPosition ].
			
			
			shipManager setPositionOf: aShip  to: nextPosition.
			shipManager landShip: aShip atSquare: nextSquare.
			
			
			gameFinished := shipManager hasShip: aShip reachedLapGoal: lapsGoal withLapLength: squareCount  ]

			
			
			 ] ]
]
