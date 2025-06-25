"
A square that makes the ship advances M parsecs forward, following list values.
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Object',
	#instVars : [
		'rewards',
		'currentRewardIndex'
	],
	#category : 'IngSoft2-Model-SquareType',
	#package : 'IngSoft2-Model',
	#tag : 'SquareType'
}

{ #category : 'actions' }
HyperJumpSquare class >> checkRewards: aParsecsList [

	aParsecsList ifEmpty: [
		Error signal: 'Parsec rewards cannot be empty' ]
]

{ #category : 'actions' }
HyperJumpSquare class >> withRewards: aSetOfDistances [

	self checkRewards: aSetOfDistances.

	^ self new initializeWithRewards: aSetOfDistances
]

{ #category : 'actions' }
HyperJumpSquare >> applyEffectTo: shipList forShip: aShip on: aBoard managedBy: aShipManager [

	| distanceInSquares |
	distanceInSquares := (rewards at: currentRewardIndex) toParsecs
	                     // aBoard parsecsPerSquare.
	aShip moveForwardBy: distanceInSquares.

	currentRewardIndex := currentRewardIndex + 1.
	currentRewardIndex > rewards size ifTrue: [
		currentRewardIndex := 1 ].

	aShipManager checkBattles: aShip on: aBoard
]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWithRewards: aSetOfDistances [

	rewards := (aSetOfDistances asSortedCollection: [ :aDistance :anotherDistance | aDistance toParsecs > anotherDistance toParsecs])
		               asArray.
	currentRewardIndex := 1
]
