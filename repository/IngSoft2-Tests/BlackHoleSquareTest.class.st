Class {
	#name : 'BlackHoleSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'tests' }
BlackHoleSquareTest >> testB01WhenAShipLandsOnABlackHoleSquareAndItsPositionDecreasesBy4ThenValid [

	| aBlackHoleSquare ships|
	
	ships := OrderedCollection new.
	ships add: (Ship for: 'Player 1' startingAt: (Position at: 6 and: 0 and: 10)  shieldedWith: 3).

	aBlackHoleSquare := BlackHoleSquare new.

	aBlackHoleSquare
		applyEffectTo: ships
		forShip: (ships at: 1).
		
	self assert: (ships at: 1) position square equals: 2
]
