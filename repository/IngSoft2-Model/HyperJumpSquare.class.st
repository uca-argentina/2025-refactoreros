"
A square that makes the ship advances M parsecs forward, following list values.
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Object',
	#instVars : [
		'parsecsList',
		'currentParsecRewardIndex'
	],
	#category : 'IngSoft2-Model-SquareType',
	#package : 'IngSoft2-Model',
	#tag : 'SquareType'
}

{ #category : 'actions' }
HyperJumpSquare class >> checkParsecRewards: aParsecsList [

	aParsecsList ifEmpty: [
		Error signal: 'Parsec rewards cannot be empty' ]
]

{ #category : 'actions' }
HyperJumpSquare class >> withParsecsRewards: aParsecsList [

	self checkParsecRewards: aParsecsList .

	^ self new initializeWithParsecsRewards: aParsecsList 
]

{ #category : 'actions' }
HyperJumpSquare >> applyEffectTo: shipList forShip: aShip on: aBoard managedBy: aShipManager [

	| distanceInSquares |
	distanceInSquares := (parsecsList at: currentParsecRewardIndex)
	                     // aBoard parsecsPerSquare.
	aShip moveForwardBy: distanceInSquares.

	currentParsecRewardIndex := currentParsecRewardIndex + 1.
	currentParsecRewardIndex > parsecsList size ifTrue: [
		currentParsecRewardIndex := 1 ].

	aShipManager checkBattles: aShip on: aBoard
]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWithParsecsRewards: aParsecsList [

	parsecsList := (aParsecsList asSortedCollection: [ :aParsecNumber :anotherParsecNumber | aParsecNumber > anotherParsecNumber ])
		               asArray.
	currentParsecRewardIndex := 1
]
