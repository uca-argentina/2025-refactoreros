Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#instVars : [
		'shields',
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
BattleManager class >> withShips: aShipList andDice: aDice [
	
	^ self new initializeWithShips: aShipList andDice: aDice

]

{ #category : 'actions' }
BattleManager >> applyShieldEffectOf: nextSquare forShip: aShip [
	| newShipShields |
	newShipShields := shields copy.
	nextSquare applyShieldEffectTo:newShipShields forShip: aShip.
	shields := newShipShields.
]

{ #category : 'actions' }
BattleManager >> battle: aShipA with: aShipB [

	| rollA rollB loserShip |
	rollA := dice roll.
	rollB := dice roll.

	[rollA = rollB] whileTrue: [
		rollA := dice roll.
		rollB := dice roll ].

	loserShip := aShipA.
	rollA > rollB ifTrue: [
		loserShip := aShipB.
	 ].


		(shields at: loserShip ) > 0 ifTrue: [
			shields at: loserShip put: (shields at: loserShip) - 1 ].
		^ loserShip 
]

{ #category : 'actions' }
BattleManager >> getShieldsOf: aShip [

	^ shields at: aShip
]

{ #category : 'initialization' }
BattleManager >> initializeWithShips: aShipList andDice: aDice [

	| shieldsAtStart |
	shieldsAtStart := 3.

	shields := Dictionary new.
	dice := aDice.
	
	1 to: (aShipList size) do: [ :i |
	 shields at: (aShipList at: i) put: shieldsAtStart ]
]
