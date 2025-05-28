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
BattleManager >> battle: aShipA with: aShipB [

	| rollA rollB |
	rollA := dice roll.
	rollB := dice roll.

	rollA > rollB ifTrue: [
		(shields at: aShipB) > 0 ifTrue: [
			shields at: aShipB put: (shields at: aShipB) - 1 ] ]
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
