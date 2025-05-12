"
Creates a game board.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'playerCount',
		'diceCollection',
		'squareCount'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
Board class >> checkValidDiceCollection: aDiceCollection [

	aDiceCollection isNotEmpty ifFalse: [
		Error signal: 'At least one die is required' ]
]

{ #category : 'argument validation' }
Board class >> checkValidPlayerCount: aPlayerCount [

	aPlayerCount >= 1 ifFalse: [
		Error signal: 'Player count should be equal or higher than 1' ]
]

{ #category : 'argument validation' }
Board class >> checkValidSquareCount: aSquareCount [

	aSquareCount >= 2 ifFalse: [
		Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'intialization' }
Board class >> gameWithPlayerCount: aPlayerCount andDice: aDiceCollection andSquareCount: aSquareCount [

	self checkValidPlayerCount: aPlayerCount.
	self checkValidDiceCollection: aDiceCollection.
	self checkValidSquareCount: aSquareCount.

	^ self new
		  newGameWithPlayerCount: aPlayerCount
		  andDice: aDiceCollection
		  andSquareCount: aSquareCount
]

{ #category : 'instance creation' }
Board >> newGameWithPlayerCount: aPlayerCount andDice: aDiceCollection andSquareCount: aSquareCount [

	playerCount := aPlayerCount.
	diceCollection := aDiceCollection.
	squareCount := aSquareCount
]
