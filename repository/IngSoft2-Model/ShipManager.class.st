"
A Game collaborator that handles all Ship movements, battles and Square effect applications.
"
Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'shipTurnSkips',
		'gameShips',
		'activeCards'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'initialization' }
ShipManager class >> withShips: aShipList andActiveCards: aActiveCardsList [

	^ self new
		  initializeWithShips: aShipList
		  andActiveCards: aActiveCardsList
]

{ #category : 'actions' }
ShipManager >> battle: aShipWithMercenaries with: anotherShipWithMercenaries on: aBoard [

	| rollA rollB loserShip |
	rollA := 0.
	aShipWithMercenaries do: [ :aShip |
		rollA := rollA + (aBoard rollDiceFor: aShip with: activeCards) ].
	rollB := 0.
	anotherShipWithMercenaries do: [ :aShip |
		rollB := rollB + (aBoard rollDiceFor: aShip with: activeCards) ].

	[ rollA = rollB ] whileTrue: [
		rollA := 0.
		aShipWithMercenaries do: [ :aShip |
			rollA := rollA + (aBoard rollDiceFor: aShip with: activeCards) ].
		rollB := 0.
		anotherShipWithMercenaries do: [ :aShip |
			rollB := rollB + (aBoard rollDiceFor: aShip with: activeCards) ] ].


	loserShip := aShipWithMercenaries at: 1.
	rollA > rollB ifTrue: [
		loserShip := anotherShipWithMercenaries at: 1 ].

	^ loserShip
]

{ #category : 'checking' }
ShipManager >> checkBattles: aShip on: aBoard [

	| otherShips loserShip aShipWithMercenaries anotherShipWithMercenaries loserShipWithMercenaries |
	aShipWithMercenaries := self getMercenariesOf: aShip.

	otherShips := gameShips reject: [ :ship | aShipWithMercenaries includes: ship ].

	otherShips do: [ :anotherShip |
		(self checkIfShouldFight: aShip with: anotherShip ) ifTrue: [
			anotherShipWithMercenaries := self getMercenariesOf: anotherShip.
			loserShip := self battle: aShipWithMercenaries with: anotherShipWithMercenaries on: aBoard.
			loserShipWithMercenaries := self getMercenariesOf: loserShip.
			loserShipWithMercenaries do: [ :ship | ship breakAShield ].
			loserShip goToFirstSquare.
			loserShip hasShields ifFalse: [ shipTurnSkips at: loserShip put: 2 ] ] ]

]

{ #category : 'checking' }
ShipManager >> checkIfShouldFight: aShip with: anotherShip [

	| anotherShipWithMercenaries |
	anotherShipWithMercenaries := self getMercenariesOf: anotherShip.
	^ (anotherShip isAtTheSameSquareAs: aShip) and:
		  (anotherShipWithMercenaries includes: aShip) not
]

{ #category : 'accessing' }
ShipManager >> getMercenariesOf: aShip [

	| shipWithMercenaries |
	shipWithMercenaries := OrderedCollection new.
	shipWithMercenaries add: aShip.
	activeCards do: [ :aCard |
		aCard applyMercenaryEffectFor: aShip in: shipWithMercenaries ].

	^ shipWithMercenaries
]

{ #category : 'testing' }
ShipManager >> hasTurnSkips: aShip [

	| currentTurnSkips |
	currentTurnSkips := shipTurnSkips at: aShip.

	currentTurnSkips = 1 ifTrue: [ aShip rechargeShields ].

	currentTurnSkips > 0 ifTrue: [
		shipTurnSkips at: aShip put: currentTurnSkips - 1.
		^ true ].

	^ false
]

{ #category : 'initialization' }
ShipManager >> initializeWithShips: aSetOfShips andActiveCards: aListOfActiveCards [

	gameShips := aSetOfShips copy.
	activeCards := aListOfActiveCards.
	shipTurnSkips := Dictionary new.
	gameShips do: [ :aShip | shipTurnSkips at: aShip put: 0 ]
]

{ #category : 'actions' }
ShipManager >> landShip: aShip atSquare: nextSquare on: aBoard [

	nextSquare
		applyEffectTo: gameShips
		forShip: aShip
		on: aBoard
		managedBy: self
]

{ #category : 'actions' }
ShipManager >> moveShip: aShip to: diceResult [

	aShip moveForwardBy: diceResult
]
