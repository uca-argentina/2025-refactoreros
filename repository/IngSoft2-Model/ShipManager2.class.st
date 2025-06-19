Class {
	#name : 'ShipManager2',
	#superclass : 'Object',
	#instVars : [
		'lapLength',
		'shipList',
		'shipTurnSkips',
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShipManager2 class >> withShips: aShipList andLapLenght: aLapLength andDice: aDice [

	^ self new initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice
]

{ #category : 'actions' }
ShipManager2 >> checkBattles: aShip [

	| otherShips loserShip |
	otherShips := shipList reject: [ :ship | ship = aShip ].

	otherShips do: [ :ship |
		(ship position hasEqualPosition: aShip position) ifTrue: [
			loserShip := aShip battle: ship with: dice.
			loserShip loseAShield.
			loserShip goToFirstSquare.
			loserShip hasShields ifFalse: [ shipTurnSkips at: loserShip put: 2 ] ] ]

]

{ #category : 'testing' }
ShipManager2 >> hasAnyShipReachedLaps: lapsGoal [

	^ shipList anySatisfy: [ :ship | ship hasReachedLap: lapsGoal ]
]

{ #category : 'testing' }
ShipManager2 >> hasTurnSkips: aShip [

	| currentTurnSkips |
	currentTurnSkips := shipTurnSkips at: aShip.

	(currentTurnSkips = 1 ) ifTrue: [
			aShip rechargeShields].

	(currentTurnSkips > 0) ifTrue: [
		shipTurnSkips at: aShip put: (currentTurnSkips - 1).
		^ true ].

	^ false
]

{ #category : 'initialization' }
ShipManager2 >> initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice [

	shipList := aShipList.
	lapLength := aLapLength.
	dice := aDice.
	
	shipTurnSkips := Dictionary new.
	shipList do: [ :aShip | shipTurnSkips at: aShip put: 0 ].
]

{ #category : 'actions' }
ShipManager2 >> landShip: aShip atSquare: nextSquare [

	nextSquare applyEffectTo: shipList forShip: aShip.
]

{ #category : 'actions' }
ShipManager2 >> moveShip: aShip to: diceResult [
	| aPosition |

	aPosition := Position at: diceResult and: 0 and: lapLength.

	aShip moveForwardBy: aPosition
]

{ #category : 'accessing' }
ShipManager2 >> obtainNextPositionFor: aShip with: diceResult [

	| aPosition |

	aPosition := Position at: diceResult and: 0 and: lapLength.

	^ aShip obtainNextPosition: aPosition
]
