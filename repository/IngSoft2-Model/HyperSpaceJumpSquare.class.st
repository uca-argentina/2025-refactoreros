"
A square that increases landed ship position in ""4"" squares. (Positions: a dictionary: 'shipName' -> position; positions from current lap, since this object doesn't receive lap information)
"
Class {
	#name : 'HyperSpaceJumpSquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model-SquareType',
	#package : 'IngSoft2-Model',
	#tag : 'SquareType'
}

{ #category : 'actions' }
HyperSpaceJumpSquare >> applyEffectTo: shipList forShip: aShip [

	aShip moveForwardBy: (Position at: 4 and: 0 and: 0).
	aShip loseAShield
]

{ #category : 'actions' }
HyperSpaceJumpSquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

	(shipsPositions at: aShip put: (shipsPositions at: aShip) + 4)
]

{ #category : 'actions' }
HyperSpaceJumpSquare >> applyShieldEffectTo: shipShields forShip: aShip [

	| currentShields |
	currentShields := shipShields at: aShip.

	(currentShields = 0)  ifFalse: [
		shipShields at: aShip put: (currentShields - 1).
				 ]
]
