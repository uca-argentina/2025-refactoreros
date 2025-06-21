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

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := #( 'Player 1' ).
	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.
	aGame play.
	self assert: aGame winner equals: 'Player 1'
]

{ #category : 'tests' }
GameTest >> testA02WhenAShipReachesTheGoalButTheOtherShipIsTheWinnerThenInvalid [

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 12 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := #( 'Player 1' 'Player 2' ).
	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.
	aGame play.
	
	self deny: aGame winner equals: 'Player 2'
]

{ #category : 'tests' }
GameTest >> testA03WhenAShipSurpassesTheGoalAndItsPositionGetsCorrectedToGoalOneThenValid [

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 1 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := #( 'Player 1' 'Player 2' ).
	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.
	aGame play.
	
	self deny: (aGame positionOf: (shipNames at: 1)) >= 10
]

{ #category : 'tests' }
GameTest >> testA04WhenAGameIsAskedForPositionOfInexistingShipThenFails [

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := #( 'Player 1' ).
	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.
	aGame play.

	self
		should: [ aGame positionOf: 'Player 2' ]
		raise: Error
		withMessageText: 'No ship by that name exists in the game'
]

{ #category : 'tests' }
GameTest >> testA05WhenBoardGameIsCreatedWithDuplicatedShipNamesThenFails [

	| dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := #( 'Player 1' 'Player 1' 'Player 2' ).

	self
		should: [
			Game
				gamePlayedBy: shipNames
				rolling: dice
				with: 10
				and: 1
				withABoardGeneratedBy: squareGenerator ]
		raise: Error
		withMessageText: 'Player 1 listed more than once'
]

{ #category : 'tests' }
GameTest >> testA06WhenAGameIsCreatedWithNoShipsThenFails [

	| dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := #(  ).
	self
		should: [
			Game
				gamePlayedBy: shipNames
				rolling: dice
				with: 10
				and: 1
				withABoardGeneratedBy: squareGenerator ]
		raise: Error
		withMessageText: 'At least one ship is required'
]

{ #category : 'tests' }
GameTest >> testA07WhenAGameIsCreatedWithZeroDieThenFails [

	| dice squareGenerator shipNames |
	dice := OrderedCollection new.
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := #( 'Player 1' ).
	self
		should: [
			Game
				gamePlayedBy: shipNames
				rolling: dice
				with: 10
				and: 1
				withABoardGeneratedBy: squareGenerator ]
		raise: Error
		withMessageText: 'At least one die is required'
]

{ #category : 'tests' }
GameTest >> testA08WhenGameIsCreatedWithLessThanTwoSquaresThenFails [

	| dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := OrderedCollection withAll: #( 'Player 1' ).
	self
		should: [
			Game
				gamePlayedBy: shipNames
				rolling: dice
				with: 0
				and: 1
				withABoardGeneratedBy: squareGenerator ]
		raise: Error
		withMessageText: 'Square count should be equal or higher than 2'
]

{ #category : 'tests' }
GameTest >> testA09WhenAShipWinsAndGameFinishesThenValid [

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).
	squareGenerator := SquareGenerator withOnlyEmptySquares.
	shipNames := #( 'Player 1' ).
	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.
	aGame play.

	self assert: aGame isGameFinished
]

{ #category : 'tests' }
GameTest >> testB01WhenLapsGoalReachedAndGameFinishedThenValid [

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 30 )).

	squareGenerator := SquareGenerator withOnlyEmptySquares.

	shipNames := #( 'Player 1' ).

	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 3
		         withABoardGeneratedBy: squareGenerator.
	aGame play.

	self assert: aGame winner equals: 'Player 1'
]

{ #category : 'tests' }
GameTest >> testB02WhenShipsLandsPastSquareCountAndLapsIncreasesThenValid [

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 10 )).

	squareGenerator := SquareGenerator withOnlyEmptySquares.

	shipNames := #( 'Player 1' ).

	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.
	aGame play.

	self assert: (aGame lapCountOf: (shipNames at: 1)) equals: 1
]

{ #category : 'tests' }
GameTest >> testB03WhenAShipLandsPastLapLimitAndItsPositionCirclesBackThenValid [

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).

	squareGenerator := SquareGenerator withOnlyEmptySquares.

	shipNames := #( 'Player 1' ).

	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.
	aGame play.

	self assert: (aGame positionOf: (shipNames at: 1)) equals: 6
]

{ #category : 'tests' }
GameTest >> testB04WhenBoardIsCreatedWithInvalidLapCountThenFails [

	| dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 15 )).

	squareGenerator := SquareGenerator withOnlyEmptySquares.

	shipNames := #( 'Player 1' ).

	self
		should: [
			Game
				gamePlayedBy: shipNames
				rolling: dice
				with: 10
				and: 0
				withABoardGeneratedBy: squareGenerator ]
		raise: Error
		withMessageText: 'Lap count must be equal or higher than 1'
]

{ #category : 'tests' }
GameTest >> testB05WhenShipsArePlayingAndTheBoardReturnsRankingsRightThenValid [

	| aGame dice squareGenerator shipNames |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 5 8 )).

	squareGenerator := SquareGenerator withOnlyEmptySquares.

	shipNames := #( 'Player 1' 'Player 2' ).

	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.

	self assert: (aGame rankingOf: (shipNames at: 1)) equals: 2.
	self assert: (aGame rankingOf: (shipNames at: 2)) equals: 1
]

{ #category : 'tests' }
GameTest >> testB06WhenAShipLandsOnAnotherLapAndPositionGetsProperlyAdjustedThenValid [

	| aGame dice squareGenerator shipNames aShip |
	dice := OrderedCollection new.
	dice add: (LoadedDice withSetNumbers: #( 12 )).

	squareGenerator := SquareGenerator withOnlyEmptySquares.

	shipNames := #( 'Player 1' ).
	aShip := shipNames at: 1.

	aGame := Game
		         gamePlayedBy: shipNames
		         rolling: dice
		         with: 10
		         and: 1
		         withABoardGeneratedBy: squareGenerator.
	aGame play.

	self assert: (aGame positionOf: aShip) equals: 3
]
