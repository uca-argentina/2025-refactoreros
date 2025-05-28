"
A square that makes the ship advances M parsecs forward, following list values.
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Object',
	#instVars : [
		'currentParsecRewardIndex',
		'parsecsPerSquare'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
HyperJumpSquare class >> checkValidParsecsPerSquareNumber: numberOfParsecsPerSquare [

	numberOfParsecsPerSquare >= 1 ifFalse: [
		Error signal: 'Parsecs per square must be equal or higher than 1' ]
]

{ #category : 'actions' }
HyperJumpSquare class >> withParsecsPerSquare: numberOfParsecsPerSquare [

	self checkValidParsecsPerSquareNumber: numberOfParsecsPerSquare.
	^ self new initializeWithParsecPerSquare: numberOfParsecsPerSquare
]

{ #category : 'actions' }
HyperJumpSquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

	| parsecList |
	parsecList := #( 10 8 6 4 ).
	currentParsecRewardIndex := currentParsecRewardIndex ifNil: [ 1 ].

	shipsPositions at: aShip put: ((shipsPositions at: aShip) + (parsecList at: currentParsecRewardIndex)).

	currentParsecRewardIndex := currentParsecRewardIndex + 1.
	currentParsecRewardIndex > parsecList size ifTrue: [ currentParsecRewardIndex := 1 ]
]

{ #category : 'actions' }
HyperJumpSquare >> applyShieldEffectTo: newShipShields forShip: aShip [

]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWithParsecPerSquare: numberOfParsecsPerSquare [
	parsecsPerSquare := numberOfParsecsPerSquare 
]
