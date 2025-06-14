"
A wormhole has an entry and an exit that both trasnform a player's ship position if lands on either entry or exit. 
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

{ #category : 'argument validation' }
WormHole class >> checkEntrance: anEntrancePosition isBeforeExit: anExitPosition [

	(anEntrancePosition < anExitPosition ) ifFalse: [ Error signal: 'Entrace should be located before exit']
]

{ #category : 'initialization' }
WormHole class >> withEntranceAt: anEntrancePosition andExitAt: anExitPosition [

	self checkAboveZeroForEntrance: anEntrancePosition andExit: anExitPosition.
	self checkEntrance: anEntrancePosition  isBeforeExit: anExitPosition. 
	
	^ self new intializewithEntranceAt: anEntrancePosition andExitAt: anExitPosition
]

{ #category : 'accessing' }
WormHole >> intializewithEntranceAt: anEntrancePosition andExitAt: anExitPosition [

	entrancePosition := anEntrancePosition.
	exitPosition := anExitPosition
]

{ #category : 'accessing' }
WormHole >> oppositeEnd: aPosition [

	aPosition = entrancePosition ifTrue: [ ^ exitPosition ].
	aPosition = exitPosition ifTrue: [ ^ entrancePosition ].
]
