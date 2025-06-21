"
A square that resets all ships positions (a dictionary: 'shipName' -> position) to ""1"" (positions from current lap, since this object doesn't receive lap information)
"
Class {
	#name : 'AtomicBombSquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model-SquareType',
	#package : 'IngSoft2-Model',
	#tag : 'SquareType'
}

{ #category : 'actions' }
AtomicBombSquare >> applyEffectTo: shipList forShip: aShip on: aBoard [

	shipList do: [ :ship |
		ship goToFirstSquare.
		ship breakAShield ]
]
