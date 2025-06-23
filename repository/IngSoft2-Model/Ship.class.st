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
		'maxShields',
		'cardsInHand'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'accessing' }
Ship class >> for: aPlayerName startingAt: aPostion shieldedWith: aNumberOfShields holding: cards [

	^ self new initializeFor: aPlayerName startingAt: aPostion shieldedWith: aNumberOfShields holding: cards
]

{ #category : 'accessing' }
Ship class >> forMultiple: playerNames allStartingAt: aPosition andAllShieldedWith: aNumberOfShields [

	|  cards |
	^ (playerNames collect: [ :aPlayerName |
		 	cards := OrderedCollection new.  
		   self
			   for: aPlayerName
			   startingAt: aPosition
			   shieldedWith: aNumberOfShields
			   holding: cards ]) asOrderedCollection
]

{ #category : 'actions' }
Ship >> battle: anotherShip on: aBoard [

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

{ #category : 'accessing' }
Ship >> cardsInHand [

	^ cardsInHand collect: [ :card | card name ]
]

{ #category : 'actions' }
Ship >> drawCard: aCard [
		
	cardsInHand add: aCard
]

{ #category : 'actions' }
Ship >> goToFirstSquare [

	position := position goToStartOfLap
]

{ #category : 'comparing' }
Ship >> hasGreaterPosition: anotherShip [

	^  position isGreaterThan: (anotherShip position)
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
Ship >> initializeFor: aPlayerName startingAt: aPostion shieldedWith: aNumberOfShields holding: cards [

	playerName := aPlayerName.
	position := aPostion.
	shields := aNumberOfShields.
	maxShields := aNumberOfShields.
	cardsInHand := cards

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

{ #category : 'actions' }
Ship >> throw: aCardName whenTurnOf: aShip [

	| card |
	(cardsInHand anySatisfy: [ :aCard | aCard name = aCardName ])
		ifFalse: [ Error signal: 'The ship does not have this card' ].
	card := cardsInHand detect: [ :aCard | aCard name = aCardName ].

	(card isPermanent and: self playerName ~= aShip playerName) ifTrue: [
		Error signal: 'The ship is trying to use a permanent card out of its turn' ].

	cardsInHand remove: card.

	^ card class ownedBy: self
]
