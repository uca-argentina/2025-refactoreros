Class {
	#name : 'ShipManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'tests' }
ShipManagerTest >> testB01WhenAShipDecidesToSkipTurnAndItsNextTurnIsSkippedThenValid [

	| aShipList dice aShipManager |
	aShipList := OrderedCollection withAll: #( 'Player 1' ).

	dice := LoadedDice withSetNumbers: #( 1 ).

	aShipManager := ShipManager
		                withShips: aShipList
		                andLapLenght: 10
		                andDice: dice.

	aShipManager skipTurnAndRechargeShields: (aShipList at: 1).

	self assert: (aShipManager hasTurnSkips: (aShipList at: 1))
]
