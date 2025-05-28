Class {
	#name : 'BattleManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleManagerTest >> test01BWhenTheGameStartsAndTheShipHas3ShieldsThenValid [

	| aBattleManager aShipList dice |
	
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	dice := LoadedDice withSetNumbers: #(5 2).
	aBattleManager := BattleManager withShips: aShipList andDice: dice.
	
	self assert: (aBattleManager getShieldsOf: (aShipList at: 1)) = 3
	
]

{ #category : 'tests' }
BattleManagerTest >> test02BWhenTwoShipsBattleAndLooserLose1ShieldThenValid [

	| aBattleManager aShipList dice |
	
	aShipList := OrderedCollection withAll: #( 'Player 1' 'Player 2' ).
	dice := LoadedDice withSetNumbers: #(5 2).
	aBattleManager := BattleManager withShips: aShipList andDice: dice.
	
	aBattleManager battle: (aShipList at: 1) with: (aShipList at: 2).
	
	self assert: (aBattleManager getShieldsOf: (aShipList at: 2)) = 2
]
