"
A worm hole with two ends. When it recives one end it return the other.
"
Class {
	#name : 'WormHole',
	#superclass : 'Object',
	#instVars : [
		'entrancePosition',
		'exitPosition'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
WormHole class >> checkAboveZeroForEntrance: anEntrancePosition andExit: anExitPosition [

	(anEntrancePosition > 0 and: anExitPosition > 0) ifFalse: [
		Error signal: 'Positions should be numbers above zero' ]
]

{ #category : 'accessing' }
WormHole >> getOppositeEnd: aPosition [

	aPosition = entrancePosition ifTrue: [ ^ exitPosition ].

]

{ #category : 'accessing' }
WormHole >> intializewithEntranceAt: anEntrancePosition andExitAt: anExitPosition [

	entrancePosition := anEntrancePosition.
	exitPosition := anExitPosition
]
