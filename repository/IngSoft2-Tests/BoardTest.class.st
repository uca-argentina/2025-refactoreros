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
BoardTest >> test01AWhenBoardGameWithMockDieIsRanAndAShipWinsThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					 andLaps: 1
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: aBoard getWinner = 'Player 1'
]

{ #category : 'tests' }
BoardTest >> test02AWhenBoardGameWithTwoShipsAndMockDieIsRanAndShip1WinsThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 11 1)).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll:
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					 andLaps: 1
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: aBoard getWinner = 'Player 1'
]

{ #category : 'tests' }
BoardTest >> test03AWhenBoardGameWithTwoShipsAndMockDieIsRanAndShip2WinsThenInvalid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 12 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll: 
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					 andLaps: 1
		          andWormhole: wormhole.
	aBoard runGame.
	self deny: aBoard getWinner = 'Player 2'
]

{ #category : 'tests' }
BoardTest >> test05AWhenBoardGameFinishesAnd2ndShipIsPastFinalSquareThenInvalid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 1 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll:
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					 andLaps: 1
		          andWormhole: wormhole.
	aBoard runGame.
	self deny: (aBoard getShipPosition: 'Player 2') >= 10
]

{ #category : 'tests' }
BoardTest >> test06AWhenBoardGameIsAskedForThePositionOfAnInexistingShipThenFails [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
					 andLaps: 1
		          andWormhole: wormhole.
	aBoard runGame.
	self
		should: [ aBoard getShipPosition: 'Player 2' ]
		raise: Error
		withMessageText: 'There is no ship with such name'
]

{ #category : 'tests' }
BoardTest >> test07AWhenBoardIsCreatedWithEmptyShipListItFails [

	| dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll: #(  ).
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 10
				andLaps: 1
				andWormhole: wormhole ]
		raise: Error
		withMessageText: 'At least one ship is required'
]

{ #category : 'tests' }
BoardTest >> test08AWhenBoardIsCreatedWithZeroDieThenFails [

	| dice wormhole aShipList |
	dice := OrderedCollection new.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 10
				andLaps: 1
				andWormhole: wormhole ]
		raise: Error
		withMessageText: 'At least one die is required'
]

{ #category : 'tests' }
BoardTest >> test09AWhenBoardIsCreatedWithLessThanTwoSquaresThenFails [

	| dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 0
				andLaps: 1
				andWormhole: wormhole ]
		raise: Error
		withMessageText: 'Square count should be equal or higher than 2'
]

{ #category : 'tests' }
BoardTest >> test10AWhenBoardGameWithValidMockDieIsRanAndFinishesThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: aBoard isGameFinished
]

{ #category : 'tests' }
BoardTest >> testB01WhenLapsGoalReachedAndGameFinishedThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 30 )).

	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 3
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: aBoard getWinner = 'Player 1'
]

{ #category : 'tests' }
BoardTest >> testB02WhenShipsLandsPastSquareCountAndLapsIncreasesThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10)).

	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: ((aBoard getShipLap: 'Player 1' )= 1)
]

{ #category : 'tests' }
BoardTest >> testB03WhenShipsLapsIncreasesAndPositionCirclesBackThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15)).

	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andLaps: 1
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: ((aBoard getShipPosition: 'Player 1' )= 6)
]

{ #category : 'tests' }
BoardTest >> testB04WhenSBoardIsCreatedWithInvalidLapCountThenFails [

	| dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).

	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.

	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	
	self should: [ Board
		gameWithShipList: aShipList
		andDice: dice
		andSquareCount: 10
		andLaps: 0
		andWormhole: wormhole ] raise: Error withMessageText: 'Lap count must be equal or higher than 1'
]
