Class {
	#name : 'AtomicBombSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
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

	| anAtomicBombSquare ships |
	
	ships := OrderedCollection new.
	ships add:( Ship for: 'Player 1' startingAt: (Position at: 5 and: 0 and: 10)  with: 3).
	ships add:( Ship for: 'Player 2' startingAt: (Position at: 3 and: 0 and: 10)  with: 3).
	ships add:( Ship for: 'Player 3' startingAt: (Position at: 9 and: 0 and: 10)  with: 3).

	anAtomicBombSquare := AtomicBombSquare new.

	anAtomicBombSquare
		applyEffectTo: ships
		forShip: (ships at: 1).
		
	self assert: (ships allSatisfy: [ :ship | ship position square = 1 ])

]

{ #category : 'tests' }
AtomicBombSquareTest >> testB02WhenAShipLandsOnAnAtomicBombSquareAndAllShipsLoseOneShieldThenValid [

	| anAtomicBombSquare ships|
	
	ships := OrderedCollection new.
	ships add:( Ship for: 'Player 1' startingAt: (Position atStartWith: 10)  with: 3).
	ships add:( Ship for: 'Player 2' startingAt: (Position atStartWith: 10)  with: 3).
	ships add:( Ship for: 'Player 3' startingAt: (Position atStartWith: 10)  with: 3).

	anAtomicBombSquare := AtomicBombSquare new.

	anAtomicBombSquare
		applyEffectTo: ships
		forShip: (ships at: 1).
		
	self assert: (ships allSatisfy: [ :ship | ship shields = 2 ])
]
