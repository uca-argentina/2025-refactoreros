Class {
	#name : 'HyperJumpSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
HyperJumpSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
HyperJumpSquareTest >> testB01WhenAShipLandsOnHyperJumpSquareAndMovesAccordingToParsecsThenValid [

	| aHyperJumpSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.

	aHyperJumpSquare := HyperJumpSquare withParsecsPerSquare: 5 andParsecsRewards: #(10 5 2).

	aHyperJumpSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 4
]

{ #category : 'tests' }
HyperJumpSquareTest >> testB02WhenShipsLandSequentiallyOnHyperJumpSquareAndMoveAccordingToParsecsThenValid [

	| aHyperJumpSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.
	shipsPositions at: 'Player 2' put: 2.
	shipsPositions at: 'Player 3' put: 2.
	shipsPositions at: 'Player 4' put: 2.
	
	aHyperJumpSquare := HyperJumpSquare withParsecsPerSquare: 5 andParsecsRewards: #(32 25 18 9).

	aHyperJumpSquare applyPositionEffectTo: shipsPositions forShip: 'Player 1'.
	aHyperJumpSquare applyPositionEffectTo: shipsPositions forShip: 'Player 2'.
	aHyperJumpSquare applyPositionEffectTo: shipsPositions forShip: 'Player 3'.
	aHyperJumpSquare applyPositionEffectTo: shipsPositions forShip: 'Player 4'.

	self assert: (shipsPositions values) = #(8 7 5 3).
]

{ #category : 'tests' }
HyperJumpSquareTest >> testB03WhenAHyperJumpSquareIsCreatedWithInvalidParsecsPerSquareThenFails [

	| anEmptySquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ anEmptySquare := HyperJumpSquare withParsecsPerSquare: -1 andParsecsRewards: #(10 5 2)]
		raise: Error
		withMessageText: 'Parsecs per square must be equal or higher than 1'
]
