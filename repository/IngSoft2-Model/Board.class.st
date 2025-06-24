"
Contains collaborators that can be used for creating multiple games. 
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares',
		'parsecs',
		'dice'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'validation' }
Board class >> checkValidDice: aDiceCollection [

	aDiceCollection isNotEmpty ifFalse: [
		Error signal: 'At least one die is required' ]
]

{ #category : 'validation' }
Board class >> checkValidSquareCount: aSquareCount [

    aSquareCount >= 2 ifFalse: [
        Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'instance creation' }
Board class >> populatedBy: aSquareGenerator anAmountOf: aNumberOfSquares withTotalDistanceOf: aNumberOfParsecs toBePlayedOnRolling: aDiceSet [

	| aSetOfSquares |
	aSetOfSquares := aSquareGenerator createSquares: aNumberOfSquares.
	
	self checkValidDice: aDiceSet.
	self checkValidSquareCount: aNumberOfSquares.

	^ self new
		  initializePopulatedOf: aSetOfSquares
		  withDistanceOf: aNumberOfParsecs
		  toBePlayedOnRolling: aDiceSet
]

{ #category : 'instance creation' }
Board class >> populatedOf: aSetOfSquares withTotalDistanceOf: aNumberOfParsecs toBePlayedOnRolling: aDiceSet [

	self checkValidDice: aDiceSet.

	^ self new
		  initializePopulatedOf: aSetOfSquares
		  withDistanceOf: aNumberOfParsecs
		  toBePlayedOnRolling: aDiceSet
]

{ #category : 'initialization' }
Board >> initializePopulatedOf: aSetOfSquares withDistanceOf: aNumberOfParsecs toBePlayedOnRolling: aDiceSet [

	squares := aSetOfSquares deepCopy.
	parsecs := aNumberOfParsecs.
	dice := aDiceSet.
]

{ #category : 'accessing' }
Board >> numberOfSquares [

	^ squares size
]

{ #category : 'accessing' }
Board >> parsecsPerSquare [
	
	^ parsecs / (squares size)
]

{ #category : 'actions' }
Board >> rollDice [

	^ ((dice collect: [ :die | die roll ]) sum) 
]

{ #category : 'as yet unclassified' }
Board >> rollDiceFor: aShip with: activeCards [
	
	| extraPointsForThrow diceResult |
	
	diceResult := (dice collect: [ :die | die roll ]) sum.
	
	
	extraPointsForThrow := 0.
	activeCards do: [:aCard | extraPointsForThrow := extraPointsForThrow +( aCard applyThrowEffectFor: aShip) ].
	
	^ diceResult + extraPointsForThrow 
]

{ #category : 'accessing' }
Board >> squareAt: aPosition [
	
	^ squares at: aPosition 
]
