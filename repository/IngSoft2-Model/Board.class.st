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
Board class >> gameWithShipList: aShipList andDice: aDiceCollection andSquareCount: aSquareCount andLaps: aNumberOfLaps andSquareGenerator: squareGenerator [

	self checkValidDiceCollection: aDiceCollection.
	self checkValidSquareCount: aSquareCount.
	self checkValidShipList: aShipList.
	self checkValidLapCount: aNumberOfLaps .

	^ self new
		  newGameWithShipList: aShipList
		  andDice: aDiceCollection
		  andSquareCount: aSquareCount
		  andLaps: aNumberOfLaps
		  andSquareGenerator: squareGenerator
]

{ #category : 'intialization' }
Board class >> gameWithShipList: aShipList andDice: aDiceCollection andSquareCount: aSquareCount andWormhole: aWormhole [

	self checkValidDiceCollection: aDiceCollection.
	self checkValidSquareCount: aSquareCount.
	self checkValidShipList: aShipList.

	^ self new
		  newGameWithShipList: aShipList
		  andDice: aDiceCollection
		  andSquareCount: aSquareCount
		  andWormhole: aWormhole 
]

{ #category : 'actions' }
Board >> checkIfShipWon: aShip [

	(shipsPositions at: aShip) >= squareCount ifTrue: [
		gameFinished := true.
		winner := aShip ].
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
Board >> getPositionOfShip: aShipName [

	^ shipsPositions
		  at: aShipName
		  ifAbsent: [ Error signal: 'There is no ship with such name' ]
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
Board >> getShipRankings: ships [
	| shipsOrderedByRanking |

	shipsOrderedByRanking := ships
		sorted: [:s1 :s2 | 
		| lap1 lap2 pos1 pos2 |
		lap1 := shipManager getShipLap: s1.
		lap2 := shipManager getShipLap: s2.
		lap1 = lap2
			ifTrue: [
				pos1 := shipManager getShipPosition: s1.
				pos2 := shipManager getShipPosition: s2.
				pos1 > pos2
			]
			ifFalse: [lap1 > lap2]].

	^ OrderedCollection withAll: shipsOrderedByRanking

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
Board >> newGameWithShipList: aNewGame andDice: aDice andSquareCount: aSquareCount andLaps: aLaps  andSquareGenerator: squareGenerator [

	shipList := aNewGame.
	lapsGoal := aLaps.
	shipManager := ShipManager withShips: aNewGame andLapLenght: aSquareCount andDice: aDice.
	dice := aDice.
	squareCount := aSquareCount.
	squareList :=  squareGenerator createSquares: squareCount.
	gameFinished := false.
	"wormhole := aWormhole"
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

	| diceResult nextPosition nextSquare nextSquarePosition |
	[ gameFinished ] whileFalse: [
		shipList do: [ :aShip |
			((gameFinished not) and: (shipManager hasTurnSkips: aShip) not) ifTrue: [
				
	
				diceResult := self generateDiceResult.
				nextPosition := shipManager
					                calculateNextPositionFor: aShip
					                with: diceResult.

				

				
				shipManager moveShip: aShip to: nextPosition.
				
				nextSquarePosition := shipManager getShipPosition: aShip.
				nextSquare := squareList at: nextSquarePosition.
		
				shipManager landShip: aShip atSquare: nextSquare.
	
				
				shipManager checkBattles: aShip.
				
				gameFinished := shipManager
					                hasShip: aShip
					                reachedLapGoal: lapsGoal ] ] ]
]
