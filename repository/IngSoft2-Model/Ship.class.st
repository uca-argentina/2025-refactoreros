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

{ #category : 'actions' }
Ship >> goToFirstSquare [
	position := position goToStartOfLap.
]

{ #category : 'testing' }
Ship >> hasReachedLap: lapsGoal [
	^ (position lap) = lapsGoal
]

{ #category : 'accessing' }
Ship >> hasShields [
	^ shields > 0
]

{ #category : 'accessing' }
Ship >> initializeFor: aPlayerName startingAt: aPostion with: aNumberOfShields [

	playerName := aPlayerName.
	position := aPostion.
	shields := aNumberOfShields.
	maxShields := aNumberOfShields
]

{ #category : 'actions' }
Ship >> loseAShield [

	shields > 0 ifTrue: [
		shields := shields - 1.
		].
]

{ #category : 'actions' }
Ship >> moveBackwardsBy: aPosition [

	position := position decreaseBy: aPosition.
]

{ #category : 'actions' }
Ship >> moveForwardBy: aPosition [

	position := position incrementBy: aPosition.
]

{ #category : 'actions' }
Ship >> obtainNextPosition: aPosition [

	^ position incrementBy: aPosition 
]

{ #category : 'accessing' }
Ship >> playerName [

	^ playerName
]

{ #category : 'accessing' }
Ship >> position [
	^ position 
]

{ #category : 'actions' }
Ship >> rechargeShields [
	shields := maxShields.
]
