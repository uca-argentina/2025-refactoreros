Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'shipsPositions',
		'shipsLaps',
		'shipCount',
		'shipList'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShipManager class >> withShips: aShipList [

	^ self new initializeWithShips: aShipList 
]

{ #category : 'initialization' }
ShipManager >> createShipsLaps [
	
	(1 to: shipCount) do:[ :i | shipsLaps at:(shipList at: i) put: 0 ]
]

{ #category : 'initialization' }
ShipManager >> createShipsPositions [

	1 to: shipCount do: [ :i | shipsPositions at: (shipList at: i) put: 1 ]
]

{ #category : 'intialization' }
ShipManager >> initializeWithShips: aShipList [ 
	shipCount := aShipList size.
	shipList := aShipList .
	shipsPositions := Dictionary new.
	self createShipsPositions.
	shipsLaps := Dictionary new.
	self createShipsLaps.
]

{ #category : 'accessing' }
ShipManager >> manageNextPositionFor: aShip with: diceResult [

	^ (shipsPositions at: aShip) + diceResult
]

{ #category : 'as yet unclassified' }
ShipManager >> manageShip: aShip landedAtSquare: aSquare [

	| result |

	result := aSquare transform: (shipsPositions , aShip ).
	
	shipsPositions at: aShip put: result.
]
