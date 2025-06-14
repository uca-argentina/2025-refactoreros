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
AtomicBombSquareTest >> testB01WhenAShipLandsOnAnAtomicBombSquareThenAllShipsReturnsToFirstSquare [

	| anAtomicBombSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 5.
	shipsPositions at: 'Player 2' put: 3.
	shipsPositions at: 'Player 3' put: 9.

	anAtomicBombSquare := AtomicBombSquare new.

	anAtomicBombSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions values) = #(1 1 1).
]

{ #category : 'tests' }
AtomicBombSquareTest >> testB02WhenAShipLandsOnAnAtomicBombSquareAndAllShipsLoseOneShieldThenValid [

	| anAtomicBombSquare shipsShields  |
	shipsShields := Dictionary new.
	shipsShields at: 'Player 1' put: 3.
	shipsShields at: 'Player 2' put: 3.
	shipsShields at: 'Player 3' put: 3.

	anAtomicBombSquare := AtomicBombSquare new.

	anAtomicBombSquare
		applyShieldEffectTo: shipsShields 
		forShip: 'Player 1'.

	self assert: (shipsShields values) = #(2 2 2).
]
