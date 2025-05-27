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

{ #category : 'argument validation' }
MoonWalkSquare class >> validateInitializedPosition: aPosition [

	aPosition >= 1 ifFalse: [
		Error signal:
			'A square must be initialized with a position integer equal or higher than 1' ]
]

{ #category : 'accessing' }
MoonWalkSquare class >> withPositionAt: aPosition andBackwardsPush: aNumberOfSquares [

	self validateInitializedPosition: aPosition.
	^ self new initializeWithPositionAt: aPosition andBackwardsPush: aNumberOfSquares
]

{ #category : 'actions' }
MoonWalkSquare >> applyEffectTo: shipsPositions forShip: aShip [

	
	shipsPositions keysDo: [ :ship |
		(aShip = ship) ifFalse: [ shipsPositions at: ship put: (shipsPositions at: ship) - backwardsPush]]
	
	"shipsPositions at: aShip put: (shipsPositions at: aShip) - 4"
	
	"shipsPositions keysDo: [ :ship |
		shipsPositions at: ship put: 1]"
]

{ #category : 'accessing' }
MoonWalkSquare >> initializeWithPositionAt: aPosition andBackwardsPush: aNumberOfSquares [

	position := aPosition.
	backwardsPush := aNumberOfSquares.
]
