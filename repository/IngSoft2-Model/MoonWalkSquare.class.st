"
A squares that move all ships but the one who land here backwards N squares.
"
Class {
	#name : 'MoonWalkSquare',
	#superclass : 'Object',
	#instVars : [
		'position',
		'backwardsPush'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
MoonWalkSquare class >> withBackwardsPush: aNumberOfSquares [

	^ self new initializeWithBackwardsPush: aNumberOfSquares
]

{ #category : 'actions' }
MoonWalkSquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

	
	shipsPositions keysDo: [ :ship |
		(aShip = ship) ifFalse: [ shipsPositions at: ship put: (shipsPositions at: ship) - backwardsPush]]
	
	"shipsPositions at: aShip put: (shipsPositions at: aShip) - 4"
	
	"shipsPositions keysDo: [ :ship |
		shipsPositions at: ship put: 1]"
]

{ #category : 'actions' }
MoonWalkSquare >> applyShieldEffectTo:newShipShields forShip: aShip [
]

{ #category : 'accessing' }
MoonWalkSquare >> initializeWithBackwardsPush: aNumberOfSquares [

	backwardsPush := aNumberOfSquares.
]
