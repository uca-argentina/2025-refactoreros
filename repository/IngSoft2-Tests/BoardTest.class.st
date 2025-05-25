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
BoardTest >> test01AWhenBoardGameWithMockDieIsStartedAndAShipWinsThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: aBoard getWinner = 'Player 1'
]

{ #category : 'tests' }
BoardTest >> test02AWhenBoardGameWithMockDieIsStartedAndShip2WinsThenInvalid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 1 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray:
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andWormhole: wormhole.
	aBoard runGame.
	self deny: aBoard getWinner = 'Player 2'
]

{ #category : 'tests' }
BoardTest >> test03AWhenBoardGameFinishesAndWinnerIsPastFinalSquareThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: (aBoard getPositionOfShip: 'Player 1') >= 10
]

{ #category : 'tests' }
BoardTest >> test04AWhenBoardGameFinishesAnd2ndShipIsPastFinalSquareThenInvalid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 1 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray:
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andWormhole: wormhole.
	aBoard runGame.
	self deny: (aBoard getPositionOfShip: 'Player 2') >= 10
]

{ #category : 'tests' }
BoardTest >> test05AWhenBoardGameWithMockDieIsStartedAndShip1WinsThenValid [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 1 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray:
		             #( 'Player 1' 'Player 2' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andWormhole: wormhole.
	aBoard runGame.
	self assert: aBoard getWinner = 'Player 1'
]

{ #category : 'tests' }
BoardTest >> test08AWhenBoardGameIsAskedForThePositionOfAnInexistingShipThenFails [

	| aBoard dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray: #( 'Player 1' ).
	aBoard := Board
		          gameWithShipList: aShipList
		          andDice: dice
		          andSquareCount: 10
		          andWormhole: wormhole.
	aBoard runGame.
	self
		should: [ aBoard getPositionOfShip: 'Player 2' ]
		raise: Error
		withMessageText: 'key ''Player 2'' not found in Dictionary'
]

{ #category : 'tests' }
BoardTest >> test09AWhenBoardIsCreatedWithEmptyShipListItFails [

	| dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray: #(  ).
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 10
				andWormhole: wormhole ]
		raise: Error
		withMessageText: 'At least one ship is required'
]

{ #category : 'tests' }
BoardTest >> test10AWhenBoardIsCreatedWithZeroDieThenFails [

	| dice wormhole aShipList |
	dice := OrderedCollection new.
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray: #( 'Player 1' ).
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 10
				andWormhole: wormhole ]
		raise: Error
		withMessageText: 'At least one die is required'
]

{ #category : 'tests' }
BoardTest >> test11AWhenBoardIsCreatedWithLessThanTwoSquaresThenFails [

	| dice wormhole aShipList |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	wormhole := WormHole withEntranceAt: 2 andExitAt: 9.
	aShipList := OrderedCollection newFromArray: #( 'Player 1' ).
	self
		should: [
			Board
				gameWithShipList: aShipList
				andDice: dice
				andSquareCount: 0
				andWormhole: wormhole ]
		raise: Error
		withMessageText: 'Square count should be equal or higher than 2'
]
