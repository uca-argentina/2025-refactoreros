Class {
	#name : 'BattleManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleManagerTest >> testB01WhenTheGameStartsAndTheShipHasShieldsThenValid [

	| aBattleManager aShipList dice |
	
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	dice := LoadedDice withSetNumbers: #(5 2).
	aBattleManager := BattleManager with: aShipList and: dice.
	
	self assert: (aBattleManager hasShields: (aShipList at: 1))
	
]

{ #category : 'tests' }
BattleManagerTest >> testB02WhenAShipLooses3TimesAndHasNoShieldsThenValid [

	| aBattleManager aShipList dice |
	
	aShipList := OrderedCollection withAll: #( 'Player 1' 'Player 2' ).
	dice := LoadedDice withSetNumbers: #(5 2 5 2 5 2).
	aBattleManager := BattleManager with: aShipList and: dice.
	
	aBattleManager battle: (aShipList at: 1) with: (aShipList at: 2).
	aBattleManager battle: (aShipList at: 1) with: (aShipList at: 2).
	aBattleManager battle: (aShipList at: 1) with: (aShipList at: 2).
	
	self deny: (aBattleManager hasShields: (aShipList at: 2))
]

{ #category : 'tests' }
BattleManagerTest >> testB03WhenTwoShipsBattleAndTieAndTheyRollUntilOneWinsThenValid [

	| aBattleManager aShipList dice loser |
	
	aShipList := OrderedCollection withAll: #( 'Player 1' 'Player 2' ).
	dice := LoadedDice withSetNumbers: #(2 2 3 3 6 1).
	aBattleManager := BattleManager with: aShipList and: dice.
	
	loser := aBattleManager battle: (aShipList at: 1) with: (aShipList at: 2).
	
	self assert: loser = (aShipList at: 2)
]

{ #category : 'tests' }
BattleManagerTest >> testB04WhenTwoShipsBattleAndLoserReturnsToFirstPositionThenValid [

	| aShipList dice aShipManager |
	
	aShipList := OrderedCollection withAll: #( 'Player 1' 'Player 2' ).
	dice := LoadedDice withSetNumbers: #(6 4).
	
	aShipManager := ShipManager withShips: aShipList andLapLenght: 10 andDice: dice. 
	
	aShipManager moveShip: (aShipList at: 1) to: 5. 
	aShipManager moveShip: (aShipList at: 2) to: 5. 
	aShipManager checkBattles: (aShipList at: 2).
	
	self assert: (aShipManager shipPosition: (aShipList at: 2)) = 1
]

{ #category : 'tests' }
BattleManagerTest >> testB05WhenBattleManagerRechargesAShipWithoutShieldsAndShipHasShieldsThenValid [

	| aShipList dice aBattleManager anAtomicBombsquare |
	
	aShipList := OrderedCollection withAll: #( 'Player 1').
	dice := LoadedDice withSetNumbers: #(1).
	aBattleManager := BattleManager with: aShipList and: dice.
	anAtomicBombsquare := AtomicBombSquare new.
	
	"Use atomicBomb Squares to set shields to 0"
	aBattleManager applyShieldEffectOf: anAtomicBombsquare forShip: (aShipList at:1).
	aBattleManager applyShieldEffectOf: anAtomicBombsquare forShip: (aShipList at:1).
	aBattleManager applyShieldEffectOf: anAtomicBombsquare forShip: (aShipList at:1).
	
	aBattleManager rechargeShields: (aShipList at:1).
	self assert: ( aBattleManager hasShields:(aShipList at:1)).
]
