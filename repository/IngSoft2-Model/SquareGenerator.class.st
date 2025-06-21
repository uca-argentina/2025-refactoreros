"
Returns a list of randomly distributed squares based on probabilities.
"
Class {
	#name : 'SquareGenerator',
	#superclass : 'Object',
	#instVars : [
		'squaresWithProbability'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'validation' }
SquareGenerator class >> checkProbabilitiesAddToOne: squaresAndProbability [

	| probabilitySum probabilities aFlag |
	probabilities := squaresAndProbability values.
	probabilitySum := probabilities sum.
	aFlag := true.

	probabilitySum < 1 ifTrue: [
			squaresAndProbability at: EmptySquare new put: (1 - probabilitySum)	
		]
]

{ #category : 'instance creation' }
SquareGenerator class >> with: squaresAndProbability [

	self checkProbabilitiesAddToOne: squaresAndProbability.
	
	^ self new initializeWith: squaresAndProbability
]

{ #category : 'instance creation' }
SquareGenerator class >> withOnlyEmptySquares [

	| squaresAndProbability |
	squaresAndProbability := Dictionary new.
	squaresAndProbability at: EmptySquare new put: 1.

	^ self new initializeWith: squaresAndProbability
]

{ #category : 'actions' }
SquareGenerator >> createSquares: squareCount [

	| squareList |
	squareList := OrderedCollection new.

	squareCount timesRepeat: [ squareList add: self squareType deepCopy ].

	^ squareList
]

{ #category : 'initialization' }
SquareGenerator >> initializeWith: squaresAndProbability [

	squaresWithProbability := squaresAndProbability
]

{ #category : 'actions' }
SquareGenerator >> squareType [

	| sampleList randomNumberGenerator sumResult randomNumber probabilityList squareList |

	randomNumberGenerator := Random new.
	squareList := OrderedCollection new.

	sumResult := 0.
	randomNumber := randomNumberGenerator next.
	
	sampleList := squaresWithProbability keys.
	probabilityList := squaresWithProbability values.

	1 to: probabilityList size do: [ :i |
		sumResult := sumResult + (probabilityList at: i).
		randomNumber <= sumResult ifTrue: [ ^ sampleList at: i ] ]
]
