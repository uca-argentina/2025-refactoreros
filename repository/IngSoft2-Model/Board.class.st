"
Creates a game board.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'playerCount',
		'squareCount',
		'playersShips',
		'finalShipAndPosition',
		'dice',
		'gameFinished',
		'winner',
		'wormhole',
		'shipsPositions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'argument validation' }
Board class >> checkValidDiceCollection: aDiceCollection [

	aDiceCollection isNotEmpty ifFalse: [
		Error signal: 'At least one die is required' ]
]

{ #category : 'argument validation' }
Board class >> checkValidPlayerCount: aPlayerCount [

	aPlayerCount >= 1 ifFalse: [
		Error signal: 'Player count should be equal or higher than 1' ]
]

{ #category : 'argument validation' }
Board class >> checkValidSquareCount: aSquareCount [

	aSquareCount >= 2 ifFalse: [
		Error signal: 'Square count should be equal or higher than 2' ]
]

{ #category : 'intialization' }
Board class >> gameWithPlayerCount: aPlayerCount andDice: aDiceCollection andSquareCount: aSquareCount andWormhole: aWormhole [

	self checkValidPlayerCount: aPlayerCount.
	self checkValidDiceCollection: aDiceCollection.
	self checkValidSquareCount: aSquareCount.

	^ self new
		  newGameWithPlayerCount: aPlayerCount
		  andDice: aDiceCollection
		  andSquareCount: aSquareCount
		  andWormhole: aWormhole 
]

{ #category : 'as yet unclassified' }
Board >> checkIfPlayerWon2: aShipPosition [

	aShipPosition >= squareCount ifTrue:[ gameFinished := true] 
]

{ #category : 'action' }
Board >> checkIfPlayerWon: aPlayer [

	(aPlayer isLocatedAt: squareCount) ifTrue: [
		winner := aPlayer.
		gameFinished := true ]
]

{ #category : 'initialization' }
Board >> createShipCollection [

	1 to: playerCount do: [ :i |
		playersShips addLast:
			(Ship newPlayerWithName: 'Player ' , i asString).
		shipsPositions addLast: 1.
			
		]

]

{ #category : 'comparing' }
Board >> doesPlayerNameWon: aPlayerName [

	gameFinished
		ifFalse: [ Error signal: 'Game is not finishied' ]
		ifTrue: [ ^ winner getName = aPlayerName ]
]

{ #category : 'action' }
Board >> generateRandomNumberFromDiceCollection [

	^ (dice collect: [ :die | die roll ]) sum
]

{ #category : 'comparing' }
Board >> isFinishedGamePlayerName: aPlayerName atSquare: aSquare [

	| matchedPlayer |
	matchedPlayer := playersShips
		                 detect: [ :player | player getName = aPlayerName ]
		                 ifNone: [
		                 Error signal: 'There is no player with such name' ].
	^ matchedPlayer isLocatedAt: aSquare
]

{ #category : 'comparing' }
Board >> isGameFinished [

	^ gameFinished
]

{ #category : 'initialization' }
Board >> newGameWithPlayerCount: aPlayerCount andDice: aDiceCollection andSquareCount: aSquareCount andWormhole: aWormhole [

	playerCount := aPlayerCount.
	dice := aDiceCollection.
	squareCount := aSquareCount.
	playersShips := OrderedCollection new.
	self createShipCollection.
	finalShipAndPosition := Dictionary new.
	gameFinished := false.
	shipsPositions := OrderedCollection new.
	wormhole := aWormhole
]

{ #category : 'action' }
Board >> startGame [

	| randomForwardValue |
	[ gameFinished ] whileFalse: [
		playersShips do: [ :player |
			gameFinished ifFalse: [
				randomForwardValue := self generateRandomNumberFromDiceCollection.
				player moveForward: randomForwardValue withLimit: squareCount.
				player transformIfLandedAt: wormhole.
				self checkIfPlayerWon: player ] ] ]
]

{ #category : 'as yet unclassified' }
Board >> startNewGame2 [

	| randomForwardValue |
	
	
	[ gameFinished ] whileFalse: [
		1 to: shipsPositions size do: [ :i |
				randomForwardValue := self generateRandomNumberFromDiceCollection.
				shipsPositions at: i put: (shipsPositions at: i) + randomForwardValue.
				self checkIfPlayerWon2: (shipsPositions at: i).
				
			] ]
]
