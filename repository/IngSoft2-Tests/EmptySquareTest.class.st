Class {
	#name : 'EmptySquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'tests' }
EmptySquareTest >> testB01WhenAShipLandsOnAnEmptySquareAndItsPositionRemainsTheSameThenValid [

	| anEmptySquare ships|
	
	ships := OrderedCollection new.
	ships add: (Ship for: 'Player 1' startingAt: (Position atStartOfLapWithSquareNumbers: 10)  shieldedWith: 3).

	anEmptySquare := EmptySquare new.
	anEmptySquare
		applyEffectTo: ships
		forShip: (ships at: 1).
		
	self assert: (ships at: 1) position square equals: 1
]
