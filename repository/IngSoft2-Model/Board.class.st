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
		'winner'
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
Board class >> gameWithPlayerCount: aPlayerCount andDice: aDiceCollection andSquareCount: aSquareCount [

	self checkValidPlayerCount: aPlayerCount.
	self checkValidDiceCollection: aDiceCollection.
	self checkValidSquareCount: aSquareCount.

	^ self new
		  newGameWithPlayerCount: aPlayerCount
		  andDice: aDiceCollection
		  andSquareCount: aSquareCount
]

{ #category : 'action' }
Board >> checkIfPlayerWon: aPlayer [
	(aPlayer isLocatedAt: squareCount) ifTrue: [ 
		winner := aPlayer .
		gameFinished := true .
		]
]

{ #category : 'initialization' }
Board >> createShipCollection [

	1 to: playerCount do: [ :i |
	playersShips addLast: (Ship newPlayerWithName: ('Player ', i asString )) ]
]

{ #category : 'comparing' }
Board >> doesPlayerNameWon: aPlayerName [

	gameFinished
		ifFalse: [ Error signal: 'Game is not finishied' ]
		ifTrue: [ ^ (winner getName) = aPlayerName ]
]

{ #category : 'action' }
Board >> generateRandomNumberFromDiceCollection [
	^ (dice collect: [ :die | die roll ]) sum.
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
Board >> newGameWithPlayerCount: aPlayerCount andDice: aDiceCollection andSquareCount: aSquareCount [

	playerCount := aPlayerCount.
	dice := aDiceCollection.
	squareCount := aSquareCount.
	playersShips := OrderedCollection new.
	self createShipCollection.
	finalShipAndPosition := Dictionary new.
	gameFinished := false.
]

{ #category : 'action' }
Board >> startGame [

	| randomForwardValue |
	[ gameFinished ] whileFalse: [
		playersShips do: [ :player |
			gameFinished ifFalse: [
				randomForwardValue := self generateRandomNumberFromDiceCollection.
				"Agregar método para chequear si está o no en agujero negro, y en base a eso, transformar posición o mover 1 adelante"
				player moveForward: randomForwardValue withLimit: squareCount .
				self checkIfPlayerWon: player].
				 ] ]
]
