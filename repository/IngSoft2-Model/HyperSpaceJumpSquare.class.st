Class {
	#name : 'HyperSpaceJumpSquare',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
HyperSpaceJumpSquare class >> validateInitializedPosition: aPosition [

	aPosition >= 1 ifFalse: [
		Error signal:
			'A square must be initialized with a position integer equal or higher than 1' ]
]

{ #category : 'accessing' }
HyperSpaceJumpSquare class >> withPositionAt: aPosition [

	self validateInitializedPosition: aPosition.
	^ self new initializeWithPositionAt: aPosition
]

{ #category : 'actions' }
HyperSpaceJumpSquare >> applyEffectTo: shipsPositions forShip: aShip [

	(shipsPositions at: aShip put: (shipsPositions at: aShip) + 4)
]

{ #category : 'accessing' }
HyperSpaceJumpSquare >> initializeWithPositionAt: aPosition [

	position := aPosition
]
