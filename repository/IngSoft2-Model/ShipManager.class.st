"
An internal collaborator for Board, that provides support for Ship game information 
"
Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'shipsPositions',
		'shipsLaps',
		'shipList',
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShipManager class >> withShips: aShipList [

	^ self new initializeWithShips: aShipList 
]

{ #category : 'accessing' }
ShipManager >> getShipLap: aShip [

	^ (shipsLaps at: aShip) 
	
	
]

{ #category : 'accessing' }
ShipManager >> getShipPosition: aShip [

	^ shipsPositions at: aShip ifAbsent: [ 
		Error signal: 'There is no ship with such name' ]
	
	
]

{ #category : 'accessing' }
ShipManager >> getWinner [

	^ winner
]

{ #category : 'actions' }
ShipManager >> hasShip: aShip reachedLapGoal: lapsGoal withLapLength: squareCount [

	| shipCurrentPosition shipCurrentLaps lastTurnCompletedLaps |
	shipCurrentPosition := shipsPositions at: aShip.
	shipCurrentLaps := shipsLaps at: aShip.
	lastTurnCompletedLaps := shipCurrentPosition // squareCount.

	shipCurrentPosition >= squareCount ifTrue: [
		shipsLaps at: aShip put: shipCurrentLaps + lastTurnCompletedLaps.
		shipsPositions
			at: aShip
			put: shipCurrentPosition - (lastTurnCompletedLaps * squareCount) ].


	(shipsLaps at: aShip) >= lapsGoal
		ifTrue: [
			winner := aShip.
			^ true ]
		ifFalse: [ ^ false ]
]

{ #category : 'intialization' }
ShipManager >> initializeWithShips: aShipList [

	shipList := aShipList.
	shipsPositions := Dictionary new.
	shipList do: [ :aShip | shipsPositions at: aShip put: 1 ].
	shipsLaps := Dictionary new.
	shipList do: [ :aShip | shipsLaps at: aShip put: 0 ]
]

{ #category : 'accessing' }
ShipManager >> manageNextPositionFor: aShip with: diceResult [

	^ (shipsPositions at: aShip) + diceResult
]

{ #category : 'action' }
ShipManager >> manageShip: aShip landedAtSquare: aSquare [

	| result |

	result := aSquare transform: (shipsPositions , aShip ).
	
	shipsPositions at: aShip put: result.
]

{ #category : 'initialization' }
ShipManager >> setPosition: aPosition for: aShip [

	shipsPositions at: aShip put: aPosition
]
