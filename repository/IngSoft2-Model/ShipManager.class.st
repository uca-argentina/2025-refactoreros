Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'lapLength',
		'shipList',
		'shipTurnSkips',
		'dice'
	],
	#category : 'IngSoft2-Model-game',
	#package : 'IngSoft2-Model',
	#tag : 'game'
}

{ #category : 'initialization' }
ShipManager class >> withShips: aShipList andLapLenght: aLapLength andDice: aDice [

	^ self new initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice
]

{ #category : 'actions' }
ShipManager >> checkBattles: aShip [

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
ShipManager >> hasAnyShipReachedLaps: lapsGoal [

	^ shipList anySatisfy: [ :ship | ship hasReachedLap: lapsGoal ]
]

{ #category : 'testing' }
ShipManager >> hasTurnSkips: aShip [

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
ShipManager >> initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice [

	shipList := aShipList copy.
	lapLength := aLapLength.
	dice := aDice.

	shipTurnSkips := Dictionary new.
	shipList do: [ :aShip | shipTurnSkips at: aShip put: 0 ]
]

{ #category : 'actions' }
ShipManager >> landShip: aShip atSquare: nextSquare [

	nextSquare applyEffectTo: shipList forShip: aShip.
	self checkBattles: aShip
]

{ #category : 'actions' }
ShipManager >> moveShip: aShip to: diceResult [

	aShip moveForwardBy: diceResult
	
]

{ #category : 'accessing' }
ShipManager >> shipLap: anotherShip [

	| aShip |
	aShip := shipList detect: [ :ship | ship = anotherShip ] ifNone: [ Error signal: 'There is no such ship at current game' ].

	^ aShip position lap
]

{ #category : 'accessing' }
ShipManager >> shipPosition: anotherShip [

	| aShip |
	aShip := shipList detect: [ :ship | ship = anotherShip ] ifNone: [ Error signal: 'There is no such ship at current game' ].

	^ aShip position square
]

{ #category : 'accessing' }
ShipManager >> winner [

	| rankedShips |
	rankedShips := shipList asSortedCollection: [ :aShip :anotherShip |
		               aShip position square > anotherShip position square ].
	^ (rankedShips at: 1) playerName
]
