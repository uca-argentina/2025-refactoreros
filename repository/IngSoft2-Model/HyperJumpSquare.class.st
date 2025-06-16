"
A square that makes the ship advances M parsecs forward, following list values.
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Object',
	#instVars : [
		'currentParsecRewardIndex',
		'parsecsPerSquare',
		'parsecsList'
	],
	#category : 'IngSoft2-Model-SquareType',
	#package : 'IngSoft2-Model',
	#tag : 'SquareType'
}

{ #category : 'actions' }
HyperJumpSquare class >> checkValidParsecsPerSquareNumber: numberOfParsecsPerSquare [

	numberOfParsecsPerSquare >= 1 ifFalse: [
		Error signal: 'Parsecs per square must be equal or higher than 1' ]
]

{ #category : 'actions' }
HyperJumpSquare class >> withParsecsPerSquare: numberOfParsecsPerSquare andParsecsRewards: aParsecsList [

	self checkValidParsecsPerSquareNumber: numberOfParsecsPerSquare.
	^ self new initializeWithParsecsPerSquare: numberOfParsecsPerSquare andParsecsRewards: aParsecsList
]

{ #category : 'actions' }
HyperJumpSquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

	shipsPositions at: aShip put: (shipsPositions at: aShip) + ((parsecsList at: currentParsecRewardIndex) // parsecsPerSquare ).

	currentParsecRewardIndex := currentParsecRewardIndex + 1.
	currentParsecRewardIndex > parsecsList size ifTrue: [ currentParsecRewardIndex := 1 ]
]

{ #category : 'actions' }
HyperJumpSquare >> applyShieldEffectTo: newShipShields forShip: aShip [
]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWithParsecsPerSquare: numberOfParsecsPerSquare andParsecsRewards: aParsecsList [
	parsecsPerSquare := numberOfParsecsPerSquare.
	parsecsList := (aParsecsList asSortedCollection: [ :a :b | a > b ]) asArray.
	currentParsecRewardIndex := 1
]
