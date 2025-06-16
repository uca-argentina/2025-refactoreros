Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'failure tests' }
GameTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
GameTest >> testA01WhenBoardGameWithMockDieIsRanAndAShipWinsThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: aBoard winner equals: 'Player 1'
]

{ #category : 'tests' }
GameTest >> testA02WhenBoardGameWithTwoShipsAndMockDieIsRanAndShip1WinsThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 11 1 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' 'Player 2' ).
	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: aBoard winner equals: 'Player 1'
]

{ #category : 'tests' }
GameTest >> testA03WhenBoardGameWithTwoShipsAndMockDieIsRanAndShip2WinsThenInvalid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 12 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' 'Player 2' ).
	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self deny: aBoard winner equals: 'Player 2'
]

{ #category : 'tests' }
GameTest >> testA05WhenBoardGameFinishesAnd2ndShipIsPastFinalSquareThenInvalid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 1 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll:
		             #( 'Player 1' 'Player 2' ).
	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					 andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self deny: (aBoard shipPosition: 'Player 2') >= 10
]

{ #category : 'tests' }
GameTest >> testA06WhenBoardGameIsAskedForThePositionOfAnInexistingShipThenFails [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					 andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self
		should: [ aBoard shipPosition: 'Player 2' ]
		raise: Error
		withMessageText: 'There is no ship with such name'
]

{ #category : 'tests' }
GameTest >> testA07WhenBoardIsCreatedWithEmptyShipListItFails [

	| dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #(  ).
	self
		should: [
			Game
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 10
				andLaps: 1
				andSquareGenerator: squareGenerator ]
		raise: Error
		withMessageText: 'At least one ship is required'
]

{ #category : 'tests' }
GameTest >> testA08WhenBoardIsCreatedWithZeroDieThenFails [

	| dice squareGenerator aShipList |
	dice := OrderedCollection new.
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	self
		should: [
			Game
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 10
				andLaps: 1
				andSquareGenerator: squareGenerator ]
		raise: Error
		withMessageText: 'At least one die is required'
]

{ #category : 'tests' }
GameTest >> testA09WhenBoardIsCreatedWithLessThanTwoSquaresThenFails [

	| dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	self
		should: [
			Game
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 0
				andLaps: 1
				andSquareGenerator: squareGenerator ]
		raise: Error
		withMessageText: 'Square count should be equal or higher than 2'
]

{ #category : 'tests' }
GameTest >> testA10WhenBoardGameWithValidMockDieIsRanAndFinishesThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: aBoard isGameFinished
]

{ #category : 'tests' }
GameTest >> testB01WhenLapsGoalReachedAndGameFinishedThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 30 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 3
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: aBoard winner equals: 'Player 1'
]

{ #category : 'tests' }
GameTest >> testB02WhenShipsLandsPastSquareCountAndLapsIncreasesThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: (aBoard shipLap: 'Player 1') equals: 1
]

{ #category : 'tests' }
GameTest >> testB03WhenShipsLapsIncreasesAndPositionCirclesBackThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: (aBoard shipPosition: 'Player 1') equals: 6
]

{ #category : 'tests' }
GameTest >> testB04WhenBoardIsCreatedWithInvalidLapCountThenFails [

	| dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).


	self should: [ Game
		gameWithShipList: aShipList
		andDice: dice
		andSquareCount: 10
		andLaps: 0
		andSquareGenerator: squareGenerator] raise: Error withMessageText: 'Lap count must be equal or higher than 1'
]

{ #category : 'tests' }
GameTest >> testB05WhenShipsArePlayingAndTheBoardReturnsRankingsRightThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 5 8 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' 'Player 2' ).

	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.

	self assert: (aBoard shipRankings: aShipList) asArray equals: #('Player 2' 'Player 1')
]

{ #category : 'tests' }
GameTest >> testB06WhenAShipLandsOnAnotherLapAndPositionGetsProperlyAdjustedThenValid [

	| aBoard dice squareGenerator aShipList aShip |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 12 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aShip := aShipList at: 1.

	aBoard := Game
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.

	self assert: (aBoard shipPosition: aShip) equals: 3
]
