Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'failure tests' }
BoardTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithShipCountBelowOneThenItFails [

	|aDiceCollection|
	aDiceCollection  := TwoDiceWithSixFaces new createCollection.

	self
		should: [ Board gameWithPlayerCount: 0 andDice: aDiceCollection andSquareCount: 10]
		raise: Error
		withMessageText: 'Player count should be equal or higher than 1'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithShipCountOfTwoAndTwoValidDiceAndValidSquareCountThenValid [

	| aBoard aDiceCollection |
	aDiceCollection := TwoDiceWithSixFaces new createCollection.
	aBoard := Board gameWithPlayerCount: 2 andDice: aDiceCollection andSquareCount: 10
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithZeroDieThenFails [

	| aDiceCollection |
	aDiceCollection := OrderedCollection new.

	self
		should: [ Board gameWithPlayerCount: 1 andDice: aDiceCollection andSquareCount: 10]
		raise: Error
		withMessageText: 'At least one die is required'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithZeroSquaresThenFail [

	| aDiceCollection |
	aDiceCollection := TwoDiceWithSixFaces new createCollection.

	self
		should: [ Board gameWithPlayerCount: 1 andDice: aDiceCollection andSquareCount: 0]
		raise: Error
		withMessageText: 'Square count should be equal or higher than 2'
]
