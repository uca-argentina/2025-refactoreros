"
A square that makes the ship advances M parsecs forward, following list values.
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Object',
	#instVars : [
		'position',
		'index'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
HyperJumpSquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

	| parsecList |
	parsecList := #( 10 8 6 4 ).
	index := index ifNil: [ 1 ].

	shipsPositions at: aShip put: ((shipsPositions at: aShip) + (parsecList at: index)).

	index := index + 1.
	index > parsecList size ifTrue: [ index := 1 ]
]

{ #category : 'actions' }
HyperJumpSquare >> applyShieldEffectTo: newShipShields forShip: aShip [

]

{ #category : 'accessing' }
HyperJumpSquare >> initializeWithPositionAt: aPosition [

	position := aPosition
]
