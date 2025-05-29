"
A square that resets all ships positions (a dictionary: 'shipName' -> position) to ""1"" (positions from current lap, since this object doesn't receive lap information)
"
Class {
	#name : 'BlackHoleSquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
BlackHoleSquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

	shipsPositions at: aShip put: (shipsPositions at: aShip) - 4
]

{ #category : 'actions' }
BlackHoleSquare >> applyShieldEffectTo:newShipShields forShip: aShip [
]
