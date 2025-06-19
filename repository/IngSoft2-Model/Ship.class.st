Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'playerName',
		'position',
		'shields',
		'maxShields'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Ship class >> for: aPlayerName startingAt: aPostion with: aNumberOfShields [

	^ self new initializeFor: aPlayerName startingAt: aPostion with: aNumberOfShields
]

{ #category : 'accessing' }
Ship >> initializeFor: aPlayerName startingAt: aPostion with: aNumberOfShields [

	playerName := aPlayerName.
	position := aPostion.
	shields := aNumberOfShields.
	maxShields := aNumberOfShields
]

{ #category : 'actions' }
Ship >> obtainNextPosition: aPosition [

	^ position modifyBy: aPosition 
]
