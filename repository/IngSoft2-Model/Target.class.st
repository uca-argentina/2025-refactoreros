"
A target object that links a specific ship and the card it played

"
Class {
	#name : 'Target',
	#superclass : 'Object',
	#instVars : [
		'ship',
		'card'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'initialization' }
Target class >> ship: aShipName [

	^ self new initializeShip: aShipName whoPlayed: ''
]

{ #category : 'initialization' }
Target class >> ship: aShipName whoPlayed: aCardName [

	^ self new initializeShip: aShipName whoPlayed: aCardName
]

{ #category : 'accessing' }
Target >> cardName [

	^ card ifEmpty: [ Error signal: 'Missing targeted card' ]
]

{ #category : 'initialization' }
Target >> initializeShip: aShipName whoPlayed: aCardName [

	ship := aShipName.
	card := aCardName
]

{ #category : 'accessing' }
Target >> shipName [

	^ ship
]
