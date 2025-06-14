"
Creates a game board.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squareCount',
		'dice',
		'gameFinished',
		'wormhole',
		'lapsGoal',
		'shipManager',
		'squareList',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Board class >> checkValidDice: aDiceCollection [

	aDiceCollection isNotEmpty ifFalse: [
		Error signal: 'At least one die is required' ]
]

{ #category : 'validation' }
Board class >> checkValidLapCount: aNumberOfLaps [

	aNumberOfLaps >= 1 ifFalse: [
		Error signal: 'Lap count must be equal or higher than 1' ]
]

{ #category : 'validation' }
Board class >> checkValidShips: aShipList [

	aShipList isNotEmpty ifFalse: [
		Error signal: 'At least one ship is required' ]
]

{ #category : 'validation' }
Board class >> checkValidSquareCount: aSquareCount [

	aSquareCount >= 2 ifFalse: [
		Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'intialization' }
Board class >> gameWith: ships and: dice and: aSquareCount and: aLapCount and: squareGenerator [

	self checkValidDice: dice.
	self checkValidSquareCount: aSquareCount.
	self checkValidShips: ships.
	self checkValidLapCount: aLapCount .

	^ self new
		  initializeWith: ships
		  and: dice
		  and: aSquareCount
		  and: aLapCount
		  and: squareGenerator
]

{ #category : 'intialization' }
Board class >> gameWithShipList: ships andDice: dice andSquareCount: aSquareCount andLaps: aLapCount andSquareGenerator: squareGenerator [

	self checkValidDice: dice.
	self checkValidSquareCount: aSquareCount.
	self checkValidShips: ships.
	self checkValidLapCount: aLapCount .

	^ self new
		  initializeWith: ships
		  and: dice
		  and: aSquareCount
		  and: aLapCount
		  and: squareGenerator
]

{ #category : 'actions' }
Board >> generateDiceResult [

	^ (dice collect: [ :die | die roll ]) sum
]

{ #category : 'initialization' }
Board >> initializeWith: aSetOfShips and: aDice and: aSquareCount and: aLapCount and: squareGenerator [

	ships := aSetOfShips.
	lapsGoal := aLapCount.
	shipManager := ShipManager withShips: aSetOfShips andLapLenght: aSquareCount andDice: aDice.
	dice := aDice.
	squareCount := aSquareCount.
	squareList :=  squareGenerator createSquares: squareCount.
	gameFinished := false.
	"wormhole := aWormhole"
]

{ #category : 'testing' }
Board >> isGameFinished [ 

	^ gameFinished
]

{ #category : 'actions' }
Board >> runGame [

	| diceResult nextPosition nextSquare nextSquarePosition |
	[ gameFinished ] whileFalse: [
		ships do: [ :aShip |
			((gameFinished not) and: (shipManager hasTurnSkips: aShip) not) ifTrue: [
				
	
				diceResult := self generateDiceResult.
				nextPosition := shipManager
					                calculateNextPositionFor: aShip
					                with: diceResult.

				

				
				shipManager moveShip: aShip to: nextPosition.
				
				nextSquarePosition := shipManager shipPosition: aShip.
				nextSquare := squareList at: nextSquarePosition.
		
				shipManager landShip: aShip atSquare: nextSquare.
	
				
				shipManager checkBattles: aShip.
				
				gameFinished := shipManager
					                hasShip: aShip
					                reachedLapGoal: lapsGoal ] ] ]
]

{ #category : 'accessing' }
Board >> shipLap: aShip [

	^ shipManager shipLap: aShip
]

{ #category : 'accessing' }
Board >> shipPosition: aShip [

	^ shipManager shipPosition: aShip
]

{ #category : 'accessing' }
Board >> shipRankings: aSetOfShips [
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

{ #category : 'accessing' }
Board >> winner [

	gameFinished
		ifTrue: [ ^ shipManager winner ]
		ifFalse: [ Error signal: 'The game is still being played' ]
]
