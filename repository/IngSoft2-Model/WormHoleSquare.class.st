"
A wormhole has an entry and an exit that both trasnform a player's ship position if lands on either entry or exit. 
"
Class {
	#name : 'WormHoleSquare',
	#superclass : 'Object',
	#instVars : [
		'entrancePosition',
		'exitPosition'
	],
	#category : 'IngSoft2-Model-SquareType',
	#package : 'IngSoft2-Model',
	#tag : 'SquareType'
}

{ #category : 'argument validation' }
WormHoleSquare class >> checkAboveZeroForEntrance: anEntrancePosition andExit: anExitPosition [

	(anEntrancePosition > 0 and: anExitPosition > 0) ifFalse: [
		Error signal: 'Positions should be numbers above zero' ]
]

{ #category : 'argument validation' }
WormHoleSquare class >> checkEntrance: anEntrancePosition isBeforeExit: anExitPosition [

	(anEntrancePosition < anExitPosition ) ifFalse: [ Error signal: 'Entrace should be located before exit']
]

{ #category : 'initialization' }
WormHoleSquare class >> withEntranceAt: anEntrancePosition andExitAt: anExitPosition [

	self checkAboveZeroForEntrance: anEntrancePosition andExit: anExitPosition.
	self checkEntrance: anEntrancePosition  isBeforeExit: anExitPosition.

	^ self new intializewithEntranceAt: anEntrancePosition andExitAt: anExitPosition
]

{ #category : 'actions' }
WormHoleSquare >> applyEffectTo: shipList forShip: aShip on: aBoard [

	| currentPosition |
	currentPosition := aShip boardPosition.

	currentPosition = entrancePosition
		ifTrue: [ aShip moveForwardBy: exitPosition - entrancePosition ]
		ifFalse: [ aShip moveBackwardsBy: exitPosition - entrancePosition ]


]

{ #category : 'accessing' }
WormHoleSquare >> intializewithEntranceAt: anEntrancePosition andExitAt: anExitPosition [

	entrancePosition := anEntrancePosition.
	exitPosition := anExitPosition
]

{ #category : 'accessing' }
WormHoleSquare >> oppositeEnd: aPosition [

	aPosition = entrancePosition ifTrue: [ ^ exitPosition ].
	aPosition = exitPosition ifTrue: [ ^ entrancePosition ]
]
