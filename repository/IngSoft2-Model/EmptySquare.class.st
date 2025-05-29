"
A square that doesn't affect ships positions (a dictionary: 'shipName' -> position; positions from current lap, since this object doesn't receive lap information)
"
Class {
	#name : 'EmptySquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
EmptySquare >> applyPositionEffectTo: shipsPositions forShip: aShip [

]

{ #category : 'actions' }
EmptySquare >> applyShieldEffectTo:newShipShields forShip: aShip [
]
