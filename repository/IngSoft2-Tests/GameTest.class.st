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
GameTest >> testA01WhenAShipReachesTheGoalAndWinsThenValid [

	| aGame dice squareGenerator shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 10 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #( 'Player 1' ).

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 1.
	
	aGame play.
	
	self assert: aGame winner equals: 'Player 1'
]

{ #category : 'tests' }
GameTest >> testA02WhenAShipReachesTheGoalButTheOtherShipIsTheWinnerThenInvalid [

	| aGame dice squareGenerator shipNames aBoard|
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 4 10 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.
		
	shipNames := #( 'Player 2' 'Player 1').

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 1.
		
	aGame play.
	aGame play.
	
	self deny: aGame winner equals: 'Player 2'
]

{ #category : 'tests' }
GameTest >> testA03WhenAShipSurpassesTheGoalYetItsPositionIsNotGreaterThanBoardLimitThenValid [

	| aGame dice squareGenerator shipNames aBoard aBoardSize|
	aBoardSize := 10.
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 15 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: aBoardSize
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.
		
	shipNames := #( 'Player 1').

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 1.
		
	aGame play.
	
	self assert: (aGame positionOf: 'Player 1') < aBoardSize 
]

{ #category : 'tests' }
GameTest >> testA04WhenAGameIsAskedForPositionOfInexistingShipThenFails [

	| aGame dice squareGenerator shipNames aBoard|
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 3 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.
		
	shipNames := #( 'Player 1').

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 1.
		
	aGame play.

	self
		should: [ aGame positionOf: 'Player 2' ]
		raise: Error
		withMessageText: 'No ship by that name exists in the game'
]

{ #category : 'tests' }
GameTest >> testA05WhenBoardGameIsCreatedWithDuplicatedShipNamesThenFails [

	| dice squareGenerator shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 3 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #( 'Player 1' 'Player 1' ).

	self
		should: [ Game gamePlayedBy: shipNames on: aBoard toPlayFor: 1 ]
		raise: Error
		withMessageText: 'Player 1 listed more than once'
]

{ #category : 'tests' }
GameTest >> testA06WhenAGameIsCreatedWithNoShipsThenFails [

	| dice squareGenerator shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 3 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #(  ).

	self
		should: [ Game gamePlayedBy: shipNames on: aBoard toPlayFor: 1 ]
		raise: Error
		withMessageText: 'At least one ship is required'
]

{ #category : 'tests' }
GameTest >> testA07WhenABoardIsCreatedWithZeroDieThenFails [

	| dice squareGenerator aBoard |
	dice := OrderedCollection new.
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	

	self
		should: [ aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.]
		raise: Error
		withMessageText: 'At least one die is required'
]

{ #category : 'tests' }
GameTest >> testA08WhenBoardIsCreatedWithLessThanTwoSquaresThenFails [

	| dice squareGenerator |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 15 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.

	self
		should: [
			Board
				populatedBy: squareGenerator
				anAmountOf: 1
				withTotalDistanceOf: 50
				toBePlayedOnRolling: dice ]
		raise: Error
		withMessageText: 'Square count should be equal or higher than 2'
]

{ #category : 'tests' }
GameTest >> testA09WhenAShipWinsAndGameFinishesThenValid [

	| aGame dice squareGenerator shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 10 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #( 'Player 1' ).

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 1.
	
	aGame play.

	self assert: aGame isGameFinished
]

{ #category : 'tests' }
GameTest >> testB01WhenLapsGoalIsNotReachedAndGameIsFinishedThenInvalid [

	| aGame dice squareGenerator shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 10 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #( 'Player 1' ).

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 3.
	
	aGame play.

	self deny: aGame isGameFinished 
]

{ #category : 'tests' }
GameTest >> testB02WhenShipsLandsPastSquareCountAndLapsIncreasesThenValid [

	| aGame dice squareGenerator shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 10 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #( 'Player 1' ).

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 3.
	
	aGame play.

	self assert: (aGame lapCountOf: (shipNames at: 1)) equals: 1
]

{ #category : 'tests' }
GameTest >> testB03WhenAShipLandsPastLapLimitAndItsPositionCirclesBackThenValid [

	| aGame dice squareGenerator shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 15 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #( 'Player 1' ).

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 3.
	
	aGame play.

	self assert: (aGame positionOf: (shipNames at: 1)) equals: 6
]

{ #category : 'tests' }
GameTest >> testB04WhenBoardIsCreatedWithInvalidLapCountThenFails [

	| dice squareGenerator shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 3 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #( 'Player 1' ).

	self
		should: [ Game gamePlayedBy: shipNames on: aBoard toPlayFor: 0 ]
		raise: Error
		withMessageText: 'Lap count must be equal or higher than 1'
]

{ #category : 'tests' }
GameTest >> testB05WhenAShipIsBehindAnotherOneAndItIsRankedAsSecondThenValid [

	| aGame dice squareGenerator shipNames aBoard|
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 4 2 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	aBoard := Board
		          populatedBy: squareGenerator
		          anAmountOf: 10
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.
		
	shipNames := #( 'Player 1' 'Player 2').

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 1.
		
	aGame play.
	aGame play.

	self assert: (aGame rankingOf: 'Player 1') equals: 2
]

{ #category : 'tests' }
GameTest >> testB06WhenAShipLandsOnAtomicBombAndAllShipsGoBackToFirstSquareThenValid [

	| aGame dice aSetOfSquares shipNames aBoard |
	dice := OrderedCollection new.
	dice add: (LoadedDie withSetNumbers: #( 2 4 3 2 1 2 1)).
	aSetOfSquares := {
		                 EmptySquare new.
		                 EmptySquare new.
		                 EmptySquare new.
		                 AtomicBombSquare new.
		                 EmptySquare new } asOrderedCollection.

	aBoard := Board
		          populatedOf: aSetOfSquares
		          withTotalDistanceOf: 50
		          toBePlayedOnRolling: dice.

	shipNames := #( 'Player 1' 'Player 2' 'Player 3' ).

	aGame := Game gamePlayedBy: shipNames on: aBoard toPlayFor: 2.

	aGame play.
	aGame play.
	aGame play.

	self assert: (aGame positionOf: 'Player 1') equals: 1
]
