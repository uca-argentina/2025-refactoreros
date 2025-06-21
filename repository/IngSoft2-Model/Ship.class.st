"
Represents a player of the Game. 
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'playerName',
		'position',
		'shields',
		'maxShields'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'accessing' }
Ship class >> for: aPlayerName startingAt: aPostion shieldedWith: aNumberOfShields [

	^ self new initializeFor: aPlayerName startingAt: aPostion shieldedWith: aNumberOfShields
]

{ #category : 'accessing' }
Ship class >> forMultiple: playerNames allStartingAt: aPosition andAllShieldedWith: aNumberOfShields [

	^ (playerNames collect: [ :aPlayerName |
		  self for: aPlayerName startingAt: aPosition shieldedWith: aNumberOfShields ]) asOrderedCollection
]

{ #category : 'actions' }
Ship >> battle: anotherShip with: aBoard [

	| rollA rollB loserShip |
	rollA := aBoard rollDice.
	rollB := aBoard rollDice.

	[ rollA = rollB ] whileTrue: [
		rollA := aBoard rollDice.
		rollB := aBoard rollDice ].

	loserShip := self.
	rollA > rollB ifTrue: [ loserShip := anotherShip ].

	^ loserShip
]

{ #category : 'accessing' }
Ship >> boardPosition [

	^ position square
]

{ #category : 'actions' }
Ship >> breakAShield [

	shields > 0 ifTrue: [ shields := shields - 1 ]
]

{ #category : 'actions' }
Ship >> goToFirstSquare [

	position := position goToStartOfLap
]

{ #category : 'testing' }
Ship >> hasReachedLap: lapsGoal [

	^ position lap = lapsGoal
]

{ #category : 'accessing' }
Ship >> hasShields [

	^ shields > 0
]

{ #category : 'accessing' }
Ship >> initializeFor: aPlayerName startingAt: aPostion shieldedWith: aNumberOfShields [

	playerName := aPlayerName.
	position := aPostion.
	shields := aNumberOfShields.
	maxShields := aNumberOfShields
]

{ #category : 'accessing' }
Ship >> isAtTheSameSquareAs: anotherShip [

	^ position hasEqualPosition: anotherShip position
]

{ #category : 'accessing' }
Ship >> lapCount [

	^ position lap
]

{ #category : 'actions' }
Ship >> moveBackwardsBy: aPosition [

	position := position decreaseBy: aPosition
]

{ #category : 'actions' }
Ship >> moveForwardBy: aSquareDistance [

	position := position increaseBy: aSquareDistance
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

	shields := maxShields
]

{ #category : 'accessing' }
Ship >> shields [

	^ shields
]
