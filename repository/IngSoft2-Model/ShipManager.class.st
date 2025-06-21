"
A Game collaborator that handles all Ship movements, battles and Square effect applications.
"
Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'shipTurnSkips',
		'dice',
		'gameShips'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'initialization' }
ShipManager class >> withShips: aShipList andDice: aDice [

	^ self new initializeWithShips: aShipList andDice: aDice
]

{ #category : 'actions' }
ShipManager >> checkBattles: aShip [

	| otherShips loserShip |
	otherShips := gameShips reject: [ :ship | ship = aShip ].

	otherShips do: [ :anotherShip |
		(anotherShip isAtTheSameSquareAs: aShip) ifTrue: [
			loserShip := aShip battle: anotherShip with: dice.
			loserShip breakAShield.
			loserShip goToFirstSquare.
			loserShip hasShields ifFalse: [ shipTurnSkips at: loserShip put: 2 ] ] ]
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
ShipManager >> initializeWithShips: aSetOfShips andDice: aDice [

	gameShips := aSetOfShips copy.
	dice := aDice.
	shipTurnSkips := Dictionary new.
	gameShips do: [ :aShip | shipTurnSkips at: aShip put: 0 ]
]

{ #category : 'actions' }
ShipManager >> landShip: aShip atSquare: nextSquare [

	nextSquare applyEffectTo: gameShips forShip: aShip.
	self checkBattles: aShip
]

{ #category : 'actions' }
ShipManager >> moveShip: aShip to: diceResult [

	aShip moveForwardBy: diceResult
	
]
