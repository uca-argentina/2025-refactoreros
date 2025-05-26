Class {
	#name : 'EmptySquare',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
EmptySquare class >> withPositionAt: aPosition [
	^ self new initializeWithPositionAt: aPosition
]

{ #category : 'actions' }
EmptySquare >> applyEffectTo: shipsPositions forShip: aShip [

	
	^ shipsPositions 
]

{ #category : 'accessing' }
EmptySquare >> initializeWithPositionAt: aPosition [
	position := aPosition.
]
