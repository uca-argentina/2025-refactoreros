"
Responsible for maintaining and managing ships shields as a dictionary.
"
Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#instVars : [
		'shields',
		'dice',
		'startingShields'
	],
	#category : 'IngSoft2-Model-game',
	#package : 'IngSoft2-Model',
	#tag : 'game'
}

{ #category : 'initialization' }
BattleManager class >> with: ships and: dice [

	^ self new initializeWithShips: ships andDice: dice
]

{ #category : 'actions' }
BattleManager >> applyShieldEffectOf: nextSquare forShip: aShip [
	| newShipShields |
	newShipShields := shields copy.
	nextSquare applyShieldEffectTo:newShipShields forShip: aShip.
	shields := newShipShields
]

{ #category : 'actions' }
BattleManager >> battle: aShipA with: aShipB [

	| rollA rollB loserShip |
	rollA := dice roll.
	rollB := dice roll.

	[ rollA = rollB ] whileTrue: [
		rollA := dice roll.
		rollB := dice roll ].

	loserShip := aShipA.
	rollA > rollB ifTrue: [ loserShip := aShipB ].


	(shields at: loserShip) > 0 ifTrue: [
		shields at: loserShip put: (shields at: loserShip) - 1 ].

	^ loserShip
]

{ #category : 'testing' }
BattleManager >> hasShields: aShip [
	^ (shields at: aShip) > 0
]

{ #category : 'initialization' }
BattleManager >> initializeWithShips: aShipList andDice: aDice [

	startingShields := 3.

	shields := Dictionary new.
	dice := aDice.

	1 to: (aShipList size) do: [ :i |
	 shields at: (aShipList at: i) put: startingShields ]
]

{ #category : 'accessing' }
BattleManager >> rechargeShields: aShip [

	shields at: aShip put: startingShields
]
