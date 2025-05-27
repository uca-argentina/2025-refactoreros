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
HyperJumpSquareTest >> test01BWhenAShipLandsOnHyperJumpSquareAndMovesAccordingToParsecsThenValid [

	| aHyperJumpSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.

	aHyperJumpSquare := HyperJumpSquare withPositionAt: 2.

	aHyperJumpSquare
		applyEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 12
]

{ #category : 'tests' }
HyperJumpSquareTest >> test02BWhenMultipleShipsLandsOnHyperJumpSquareAndMovesAccordingToParsecsThenValid [

	| aHyperJumpSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.
	shipsPositions at: 'Player 2' put: 2.
	shipsPositions at: 'Player 3' put: 2.
	shipsPositions at: 'Player 4' put: 2.
	
	aHyperJumpSquare := HyperJumpSquare withPositionAt: 2.

	aHyperJumpSquare applyEffectTo: shipsPositions forShip: 'Player 1'.
	aHyperJumpSquare applyEffectTo: shipsPositions forShip: 'Player 2'.
	aHyperJumpSquare applyEffectTo: shipsPositions forShip: 'Player 3'.
	aHyperJumpSquare applyEffectTo: shipsPositions forShip: 'Player 4'.

	self assert: (shipsPositions values) = #(12 10 8 6).
]

{ #category : 'tests' }
HyperJumpSquareTest >> test03BWhenAHyperJumpSquareIsCreatedWithInvalidPositionThenFails [

	| anEmptySquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ anEmptySquare := EmptySquare withPositionAt: -1 ]
		raise: Error
		withMessageText: 'A square must be initialized with a position integer equal or higher than 1'
]
