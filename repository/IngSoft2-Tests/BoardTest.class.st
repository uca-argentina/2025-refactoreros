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

BoardTest >> testA01WhenBoardGameWithMockDieIsRanAndAShipWinsThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					    andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: aBoard getWinner = 'Player 1'
]

{ #category : 'tests' }

BoardTest >> testA02WhenBoardGameWithTwoShipsAndMockDieIsRanAndShip1WinsThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 11 1)).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll:
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					    andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: aBoard getWinner = 'Player 1'
]

{ #category : 'tests' }

BoardTest >> testA03WhenBoardGameWithTwoShipsAndMockDieIsRanAndShip2WinsThenInvalid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 12 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: 
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					    andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self deny: aBoard getWinner = 'Player 2'
]

{ #category : 'tests' }

BoardTest >> testA05WhenBoardGameFinishesAnd2ndShipIsPastFinalSquareThenInvalid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 1 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll:
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					    andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self deny: (aBoard getShipPosition: 'Player 2') >= 10
]

{ #category : 'tests' }
BoardTest >> testA06WhenBoardGameIsAskedForThePositionOfAnInexistingShipThenFails [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					    andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self
		should: [ aBoard getShipPosition: 'Player 2' ]
		raise: Error
		withMessageText: 'There is no ship with such name'
]

{ #category : 'tests' }
BoardTest >> testA07WhenBoardIsCreatedWithEmptyShipListItFails [

	| dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #(  ).
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 10
				andLaps: 1
				andSquareGenerator: squareGenerator ]
		raise: Error
		withMessageText: 'At least one ship is required'
]

{ #category : 'tests' }
BoardTest >> testA08WhenBoardIsCreatedWithZeroDieThenFails [

	| dice squareGenerator aShipList |
	dice := OrderedCollection new.
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 10
				andLaps: 1
				andSquareGenerator: squareGenerator ]
		raise: Error
		withMessageText: 'At least one die is required'
]

{ #category : 'tests' }
BoardTest >> testA09WhenBoardIsCreatedWithLessThanTwoSquaresThenFails [

	| dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
  
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 0
				andLaps: 1
				andSquareGenerator: squareGenerator ]
		raise: Error
		withMessageText: 'Square count should be equal or higher than 2'
]

{ #category : 'tests' }
BoardTest >> testA10WhenBoardGameWithValidMockDieIsRanAndFinishesThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	squareGenerator := EmptySquareGenerator new.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: aBoard isGameFinished
]

{ #category : 'tests' }
BoardTest >> testB01WhenLapsGoalReachedAndGameFinishedThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 30 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 3
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: aBoard getWinner = 'Player 1'
]

{ #category : 'tests' }
BoardTest >> testB02WhenShipsLandsPastSquareCountAndLapsIncreasesThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10)).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: ((aBoard getShipLap: 'Player 1' )= 1)
]

{ #category : 'tests' }
BoardTest >> testB03WhenShipsLapsIncreasesAndPositionCirclesBackThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15)).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).
  
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.
	self assert: ((aBoard getShipPosition: 'Player 1' )= 6)
]

{ #category : 'tests' }
BoardTest >> testB04WhenBoardIsCreatedWithInvalidLapCountThenFails [

	| dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	
	self should: [ Board
		gameWithShipList: aShipList
		andDice: dice
		andSquareCount: 10
		andLaps: 0
		andSquareGenerator: squareGenerator] raise: Error withMessageText: 'Lap count must be equal or higher than 1'
]

{ #category : 'tests' }
BoardTest >> testB05WhenShipsArePlayingAndTheBoardReturnsRankingsRightThenValid [

	| aBoard dice squareGenerator aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 5 8 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' 'Player 2' ).

	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	
	self assert: (aBoard getShipRankings: aShipList) asArray equals: #('Player 2' 'Player 1').

]

{ #category : 'tests' }
BoardTest >> testB06WhenAShipLandsOnAnotherLapAndPositionGetsProperlyAdjustedThenValid [

	| aBoard dice squareGenerator aShipList aShip |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 12 )).

	squareGenerator := EmptySquareGenerator new.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aShip := aShipList at: 1.

	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andSquareGenerator: squareGenerator.
	aBoard runGame.

	self assert: (aBoard getShipPosition: aShip) = 3
]
