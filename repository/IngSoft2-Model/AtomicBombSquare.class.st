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

	shipsPositions keysDo: [:ship |
        | lap |
        lap := (shipsPositions at: ship) value.
        shipsPositions at: ship put: (1 -> lap).
    ].
]

{ #category : 'accessing' }
AtomicBombSquare >> initializeWithPositionAt: aPosition [

	position := aPosition
]
