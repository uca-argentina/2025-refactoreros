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
MoonWalkSquare >> applyEffectTo: shipList forShip: aShip on: aBoard managedBy: aShipManager [

	shipList do: [ :ship |
		ship = aShip ifFalse: [
			ship moveBackwardsBy: backwardsPush ] ].
	aShipManager checkBattles: aShip on: aBoard 
]

{ #category : 'accessing' }
MoonWalkSquare >> initializeWithBackwardsPush: aNumberOfSquares [

	backwardsPush := aNumberOfSquares
]
