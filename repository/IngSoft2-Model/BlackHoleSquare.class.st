"
A square that resets all ships positions (a dictionary: 'shipName' -> position) to ""1"" (positions from current lap, since this object doesn't receive lap information)
"
Class {
	#name : 'BlackHoleSquare',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
BlackHoleSquare class >> validateInitializedPosition: aPosition [

	aPosition >= 1 ifFalse: [
		Error signal:
			'A square must be initialized with a position integer equal or higher than 1' ]
]

{ #category : 'accessing' }
BlackHoleSquare class >> withPositionAt: aPosition [

	self validateInitializedPosition: aPosition.
	^ self new initializeWithPositionAt: aPosition
]

{ #category : 'actions' }
BlackHoleSquare >> applyEffectTo: shipsPositions forShip: aShip [

	shipsPositions at: aShip put: (shipsPositions at: aShip) - 4
]

{ #category : 'accessing' }
BlackHoleSquare >> initializeWithPositionAt: aPosition [

	position := aPosition
]
