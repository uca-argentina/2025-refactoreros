"
Responsible for maintaining and managing ships lap and current lap position information as dictionaries. 
"
Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'shipsPositions',
		'shipsLaps',
		'shipList',
		'lapLength',
		'battleManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShipManager class >> withShips: aShipList andLapLenght: aLapLength andDice: aDice [

	^ self new initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice
]

{ #category : 'accessing' }
ShipManager >> calculateNextPositionFor: aShip with: diceResult [

	^ (shipsPositions at: aShip) + diceResult
]

{ #category : 'actions' }
ShipManager >> checkBattles: aShip [

	
	| loser |
	
	shipsPositions keysAndValuesDo: [ :ship :position |
		((shipsPositions at: ship) = (shipsPositions at: aShip) ) ifTrue: [ 
				(ship = aShip) ifFalse: [ 
					loser := battleManager battle: ship with: aShip.
				 ].
			 ].
		 ].
	
	shipsPositions at:loser put: 1
	
	
	

	
]

{ #category : 'accessing' }
ShipManager >> getShipLap: arg1 [

	^ shipsLaps at: arg1
]

{ #category : 'accessing' }
ShipManager >> getShipPosition: aShip [

	^ shipsPositions
		  at: aShip
		  ifAbsent: [ Error signal: 'There is no ship with such name' ]
]

{ #category : 'accessing' }
ShipManager >> getWinner [

	| tmp1 |
	tmp1 := shipsLaps associations asSortedCollection: [ :arg1 :arg2 |
		        arg1 value > arg2 value ].
	^ (tmp1 at: 1) key
]

{ #category : 'actions' }
ShipManager >> hasShip: aShip reachedLapGoal: lapsGoal [

	^ (shipsLaps at: aShip) >= lapsGoal
]

{ #category : 'intialization' }
ShipManager >> initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice [

	shipList := aShipList.
	lapLength := aLapLength.
	shipsPositions := Dictionary new.
	shipList do: [ :aShip | shipsPositions at: aShip put: 1 ].
	shipsLaps := Dictionary new.
	shipList do: [ :aShip | shipsLaps at: aShip put: 0 ].
	battleManager := BattleManager withShips: aShipList  andDice: aDice.
]

{ #category : 'actions' }
ShipManager >> landShip: aShip atSquare: nextSquare [

	| newShipsPositions |
	newShipsPositions := shipsPositions copy.
	nextSquare applyPositionEffectTo: newShipsPositions forShip: aShip.
	battleManager applyShieldEffectOf: nextSquare forShip: aShip.
	
	newShipsPositions := self recalculateBackwardsMovement: newShipsPositions.

	shipsPositions := newShipsPositions
]

{ #category : 'actions' }
ShipManager >> moveShip: aShip to: nextPosition [

	| shipCurrentPosition shipCurrentLaps lastTurnCompletedLaps |
	shipCurrentPosition := shipsPositions at: aShip.
	shipCurrentLaps := shipsLaps at: aShip.
	lastTurnCompletedLaps := nextPosition // lapLength.

	shipsLaps at: aShip put: shipCurrentLaps + lastTurnCompletedLaps.

	shipsPositions
		at: aShip
		put: nextPosition - (lastTurnCompletedLaps * lapLength).
		
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

{ #category : 'actions' }
ShipManager >> recalculateBackwardsMovement: newShipsPositions [

	| lapsGoneBackwards squaresGoneBackwards |
	newShipsPositions keysAndValuesDo: [ :ship :position |
		
		position <= 0 ifTrue: [
			lapsGoneBackwards := (position // lapLength) abs.
			squaresGoneBackwards := (position abs % lapLength).

			newShipsPositions at: ship put: lapLength - squaresGoneBackwards.

			shipsLaps at: ship put: (shipsLaps at: ship) - lapsGoneBackwards.
			
			(squaresGoneBackwards = 0) ifFalse: [
				shipsLaps at: ship put: (shipsLaps at: ship) - 1 ] .
			
			(shipsLaps at: ship ) <= 0 ifTrue: [ 
				shipsLaps at: ship put: 0.
				shipsPositions at: ship put: 1.
				 ]
			
			
			] ].
	
	^ newShipsPositions
	

]
