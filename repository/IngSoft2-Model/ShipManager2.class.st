Class {
	#name : 'ShipManager2',
	#superclass : 'Object',
	#instVars : [
		'lapLength',
		'shipList',
		'shipTurnSkips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShipManager2 class >> withShips: aShipList andLapLenght: aLapLength andDice: aDice [

	^ self new initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice
]

{ #category : 'initialization' }
ShipManager2 >> initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice [

	shipList := aShipList.
	lapLength := aLapLength.
	
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
