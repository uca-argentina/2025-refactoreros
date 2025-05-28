"
A square that increases landed ship position in ""4"" squares. (Positions: a dictionary: 'shipName' -> position; positions from current lap, since this object doesn't receive lap information)
"
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
HyperSpaceJumpSquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

	(shipsPositions at: aShip put: (shipsPositions at: aShip) + 4)

]

{ #category : 'actions' }
HyperSpaceJumpSquare >> applyShieldEffectTo: shipShields forShip: aShip [

	| currentShields |
	currentShields := shipShields at: aShip.

	(currentShields = 0)  ifFalse: [ 
		shipShields at: aShip put: currentShields - 1.
				 ].
]

{ #category : 'accessing' }
HyperSpaceJumpSquare >> initializeWithPositionAt: aPosition [

	position := aPosition
]
