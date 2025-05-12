"
Creates a game board.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'playerCount',
		'diceCollection'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
Board class >> checkValidPlayerCount: aPlayerCount [
	aPlayerCount >= 1 ifFalse: [ Error signal: 'Player count should be equal or higher than 1' ]
]

{ #category : 'intialization' }
Board class >> gameWithPlayerCount: aPlayerCount [
	self checkValidPlayerCount: aPlayerCount.
	^ self new newGameWithPlayerCount: aPlayerCount 

]

{ #category : 'intialization' }
Board class >> gameWithPlayerCount: aPlayerCount andDice: aDiceCollection [
	self checkValidPlayerCount: aPlayerCount.
	^ self new newGameWithPlayerCount: aPlayerCount andDice: aDiceCollection

]

{ #category : 'instance creation' }
Board >> newGameWithPlayerCount: aPlayerCount andDice: aDiceCollection [
	playerCount := aPlayerCount.
	diceCollection := aDiceCollection.
]
