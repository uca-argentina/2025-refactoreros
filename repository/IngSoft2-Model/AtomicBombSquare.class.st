"
A square that resets all ships positions (a dictionary: 'shipName' -> position) to ""1"" (positions from current lap, since this object doesn't receive lap information)
"
Class {
	#name : 'AtomicBombSquare',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
AtomicBombSquare class >> validateInitializedPosition: aPosition [

	aPosition >= 1 ifFalse: [
		Error signal:
			'A square must be initialized with a position integer equal or higher than 1' ]
]

{ #category : 'accessing' }
AtomicBombSquare class >> withPositionAt: aPosition [

	self validateInitializedPosition: aPosition.
	^ self new initializeWithPositionAt: aPosition
]

{ #category : 'actions' }
AtomicBombSquare >> applyEffectTo: shipsPositions forShip: aShip [

	shipsPositions keysDo: [ :ship |
		shipsPositions at: ship put: 1]
]

{ #category : 'accessing' }
AtomicBombSquare >> initializeWithPositionAt: aPosition [

	position := aPosition
]
