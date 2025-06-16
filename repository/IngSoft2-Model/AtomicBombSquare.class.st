"
A square that resets all ships positions (a dictionary: 'shipName' -> position) to ""1"" (positions from current lap, since this object doesn't receive lap information)
"
Class {
	#name : 'AtomicBombSquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model-No',
	#package : 'IngSoft2-Model',
	#tag : 'No'
}

{ #category : 'actions' }
AtomicBombSquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

	shipsPositions keysDo: [ :ship | shipsPositions at: ship put: 1 ]
]

{ #category : 'actions' }
AtomicBombSquare >> applyShieldEffectTo: newShipShields forShip: aShip [

	newShipShields keysAndValuesDo: [ :ship :shields |
		shields = 0 ifFalse: [ newShipShields at: ship put: shields - 1 ] ]
]
