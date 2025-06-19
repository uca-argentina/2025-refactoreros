"
A squares that move all ships but the one who land here backwards N squares.
"
Class {
	#name : 'MoonWalkSquare',
	#superclass : 'Object',
	#instVars : [
		'backwardsPush'
	],
	#category : 'IngSoft2-Model-SquareType',
	#package : 'IngSoft2-Model',
	#tag : 'SquareType'
}

{ #category : 'actions' }
MoonWalkSquare class >> checkValidBackwardsPushNumber: squaresToPushBackwards [

	squaresToPushBackwards >= 1 ifFalse: [
		Error signal: 'Squares to push backwards must be equal or higher than 1' ]
]

{ #category : 'accessing' }
MoonWalkSquare class >> withBackwardsPush: aNumberOfSquares [

	self checkValidBackwardsPushNumber: aNumberOfSquares.

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
MoonWalkSquare >> applyShieldEffectTo: newShipShields forShip: aShip [
]

{ #category : 'accessing' }
MoonWalkSquare >> initializeWithBackwardsPush: aNumberOfSquares [

	backwardsPush := aNumberOfSquares
]
