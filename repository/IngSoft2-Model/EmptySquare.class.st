"
A square that doesn't affect ships positions (a dictionary: 'shipName' -> position; positions from current lap, since this object doesn't receive lap information)
"
Class {
	#name : 'EmptySquare',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
EmptySquare class >> validateInitializedPosition: aPosition [

	aPosition >= 1 ifFalse: [
		Error signal:
			'A square must be initialized with a position integer equal or higher than 1' ]
]

{ #category : 'accessing' }
EmptySquare class >> withPositionAt: aPosition [

	self validateInitializedPosition: aPosition.
	^ self new initializeWithPositionAt: aPosition
]

{ #category : 'actions' }
EmptySquare >> applyEffectTo: shipsPositions forShip: aShip [

]

{ #category : 'accessing' }
EmptySquare >> initializeWithPositionAt: aPosition [

	position := aPosition
]
