Class {
	#name : 'AtomicBombSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
AtomicBombSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
AtomicBombSquareTest >> test01BWhenAShipLandsInAnAtomicBombSquareThenAllShipsReturnsToFirstSquare [

	| anAtomicBombSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 5.
	shipsPositions at: 'Player 2' put: 3.
	shipsPositions at: 'Player 3' put: 9.

	anAtomicBombSquare := AtomicBombSquare withPositionAt: 5.

	anAtomicBombSquare
		applyEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions values) = #(1 1 1).
]

{ #category : 'tests' }
AtomicBombSquareTest >> test02BWhenAShipLandsInAnAtomicBombSquareThenAllShipsKeepTheirLap [

	| anAtomicBombSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: (5 -> 2).
	shipsPositions at: 'Player 2' put: (3 -> 1).
	shipsPositions at: 'Player 3' put: (9 -> 3).

	anAtomicBombSquare := AtomicBombSquare withPositionAt: 5.

	anAtomicBombSquare
		applyEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions values collect: [:assoc | assoc value]) = #(2 1 3).
]

{ #category : 'tests' }
AtomicBombSquareTest >> test03BWhenAnAtomicBombSquareIsCreatedWithInvalidPositionThenFails [

	| anEmptySquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ anEmptySquare := EmptySquare withPositionAt: -1 ]
		raise: Error
		withMessageText: 'A square must be initialized with a position integer equal or higher than 1'
]
