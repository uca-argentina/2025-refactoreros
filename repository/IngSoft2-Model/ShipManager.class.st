"
Responsible for maintaining and managing ships lap and current lap position information as dictionaries. 
"
Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'shipsPositions',
		'shipsLaps',
		'shipList'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShipManager class >> withShips: aShipList [

	^ self new initializeWithShips: aShipList 
]

{ #category : 'accessing' }
ShipManager >> calculateNextPositionFor: aShip with: diceResult [

	^ (shipsPositions at: aShip) + diceResult
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

	| orderedShips |
	orderedShips := shipsLaps associations asSortedCollection: [ :a :b |
		                a value > b value ].
	^ (orderedShips at: 1) key
]

{ #category : 'actions' }
ShipManager >> hasShip: aShip reachedLapGoal: lapsGoal [

	^ (shipsLaps at: aShip) >= lapsGoal
]

{ #category : 'intialization' }
ShipManager >> initializeWithShips: aShipList [

	shipList := aShipList.
	shipsPositions := Dictionary new.
	shipList do: [ :aShip | shipsPositions at: aShip put: 1 ].
	shipsLaps := Dictionary new.
	shipList do: [ :aShip | shipsLaps at: aShip put: 0 ]
]

{ #category : 'actions' }
ShipManager >> landShip: aShip atSquare: nextSquare [

	| newShipsPositions |
	newShipsPositions := shipsPositions copy.
	nextSquare applyEffectTo: newShipsPositions forShip: aShip.
	shipsPositions := newShipsPositions 
]

{ #category : 'accessing' }
ShipManager >> placeTheShip: aShip position: nextPosition withLapLength: squareCount [

	| shipCurrentPosition shipCurrentLaps lastTurnCompletedLaps |
	shipCurrentPosition := shipsPositions at: aShip.
	shipCurrentLaps := shipsLaps at: aShip.
	lastTurnCompletedLaps := nextPosition abs // squareCount.
	
	(nextPosition >= 1 and: nextPosition < squareCount) ifTrue: [ 
		shipsPositions at: aShip put: nextPosition ].

	nextPosition >= squareCount
		ifTrue: [
			shipsLaps at: aShip put: shipCurrentLaps + lastTurnCompletedLaps.
			shipsPositions
				at: aShip
				put: nextPosition - (lastTurnCompletedLaps * squareCount) ].
			
	(nextPosition <= 0 and: shipCurrentLaps >= 1) ifTrue: [ 
		 shipsLaps at: aShip put: (shipCurrentLaps - (lastTurnCompletedLaps + 1)).
			shipsPositions
				at: aShip
				put: squareCount - nextPosition abs ] .
			
	(nextPosition <= 0 and: shipCurrentLaps = 0) ifTrue: [ 
		 shipsLaps at: aShip put: 0.
			shipsPositions
				at: aShip
				put: 1 ] 
]
