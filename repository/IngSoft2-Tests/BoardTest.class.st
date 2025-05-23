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
BoardTest >> testWhenBoardGameFinishesAnd2ndShipIsAtFinalSquareThenInvalid [

	| aBoard dice aSquareCount wormhole|
	aSquareCount := 10.
	dice := OneDieWithOneFace new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aBoard := Board gameWithPlayerCount: 2 andDice: dice andSquareCount: aSquareCount andWormhole: wormhole.
	aBoard startGame .
	self deny: (aBoard isFinishedGamePlayerName: 'Player 2' atSquare: aSquareCount )
]

{ #category : 'tests' }
BoardTest >> testWhenBoardGameFinishesAnd2ndShipIsAtPreviousToFinalSquareThenValid [

	| aBoard dice aSquareCount wormhole|
	aSquareCount := 10.
	dice := OneDieWithOneFace new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aBoard := Board gameWithPlayerCount: 2 andDice: dice andSquareCount: aSquareCount andWormhole: wormhole.
	aBoard startGame .
	self assert: (aBoard isFinishedGamePlayerName: 'Player 2' atSquare: aSquareCount - 1 )
]

{ #category : 'tests' }
BoardTest >> testWhenBoardGameFinishesAndAPositionForAnInexistingShipIsValidatedThenFails [

	| aBoard dice aSquareCount wormhole|
	aSquareCount := 10.
	dice := OneDieWithOneFace new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aBoard := Board gameWithPlayerCount: 2 andDice: dice andSquareCount: aSquareCount andWormhole: wormhole.
	aBoard startGame .
	self should: [aBoard isFinishedGamePlayerName: 'Player 3' atSquare: aSquareCount ]
		raise: Error withMessageText: 'There is no player with such name'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardGameFinishesAndWinnerIsAtFinalSquareThenValid [

	| aBoard dice aSquareCount wormhole|
	aSquareCount := 10.
	dice := OneDieWithOneFace new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aBoard := Board gameWithPlayerCount: 2 andDice: dice andSquareCount: aSquareCount andWormhole: wormhole.
	aBoard startGame .
	self assert: (aBoard isFinishedGamePlayerName: 'Player 1' atSquare: aSquareCount )
]

{ #category : 'tests' }
BoardTest >> testWhenBoardGameWithMockDieIsStartedAndAShipWinsThenValid [

	| aBoard dice wormhole|
	dice := OneDieWithOneFace new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aBoard := Board gameWithPlayerCount: 2 andDice: dice andSquareCount: 10 andWormhole: wormhole.
	aBoard startGame .
	self assert: aBoard isGameFinished 
]

{ #category : 'tests' }
BoardTest >> testWhenBoardGameWithMockDieIsStartedAndShip1WinsThenValid [

	| aBoard dice wormhole|
	dice := OneDieWithOneFace new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aBoard := Board gameWithPlayerCount: 2 andDice: dice andSquareCount: 10 andWormhole: wormhole.
	aBoard startGame .
	self assert: (aBoard doesPlayerNameWon: 'Player 1')
]

{ #category : 'tests' }
BoardTest >> testWhenBoardGameWithMockDieIsStartedAndShip2WinsThenInvalid [

	| aBoard dice wormhole |
	dice := OneDieWithOneFace new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aBoard := Board gameWithPlayerCount: 2 andDice: dice andSquareCount: 10 andWormhole: wormhole.
	aBoard startGame .
	self deny: (aBoard doesPlayerNameWon: 'Player 2')
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithShipCountBelowOneThenItFails [

	|dice wormhole|
	dice  := TwoDiceWithSixFaces new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.

	self
		should: [ Board gameWithPlayerCount: 0 andDice: dice andSquareCount: 10 andWormhole: wormhole ]
		raise: Error
		withMessageText: 'Player count should be equal or higher than 1'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithValidShipCountAndValidDiceCollectionAndValidSquareCountAndValidWormholesThenValid [

	self
		shouldnt: [
			| aBoard dice wormhole|
			dice := TwoDiceWithSixFaces new createCollection.
			wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
			aBoard := Board
				          gameWithPlayerCount: 2
				          andDice: dice
				          andSquareCount: 10
				          andWormhole: wormhole ]
		raise: Error
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithZeroDieThenFails [

	| dice wormhole|
	dice := OrderedCollection new.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.

	self
		should: [ Board gameWithPlayerCount: 1 andDice: dice andSquareCount: 10 andWormhole: wormhole]
		raise: Error
		withMessageText: 'At least one die is required'
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithZeroSquaresThenFail [

	| aDiceCollection wormhole|
	aDiceCollection := TwoDiceWithSixFaces new createCollection.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.

	self
		should: [ Board gameWithPlayerCount: 1 andDice: aDiceCollection andSquareCount: 0 andWormhole: wormhole ]
		raise: Error
		withMessageText: 'Square count should be equal or higher than 2'
]
