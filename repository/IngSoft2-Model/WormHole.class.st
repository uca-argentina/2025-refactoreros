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
WormHole class >> checkEntrance: anEntrancePosition IsBeforeExit: anExitPosition [

	(anEntrancePosition < anExitPosition ) ifFalse: [ Error signal: 'Entrace should be located before exit']
]

{ #category : 'initialization' }
WormHole class >> withEntranceAt: anEntrancePosition andExitAt: anExitPosition [

	self checkAboveZeroForEntrance: anEntrancePosition andExit: anExitPosition.
	self checkEntrance: anEntrancePosition  IsBeforeExit: anExitPosition. 
	
	^ self new intializewithEntranceAt: anEntrancePosition andExitAt: anExitPosition
]

{ #category : 'accessing' }
WormHole >> getOppositeEnd: aPosition [

	aPosition = entrancePosition ifTrue: [ ^ exitPosition ].
	aPosition = exitPosition ifTrue: [ ^ entrancePosition ].
	^ aPosition
]

{ #category : 'accessing' }
WormHole >> intializewithEntranceAt: anEntrancePosition andExitAt: anExitPosition [

	entrancePosition := anEntrancePosition.
	exitPosition := anExitPosition
]
