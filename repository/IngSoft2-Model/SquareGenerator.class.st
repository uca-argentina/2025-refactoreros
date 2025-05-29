"
Returns a list of randomly distributed squares based on probabilities.
"
Class {
	#name : 'SquareGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
SquareGenerator >> addToList: aSquareList squareSample: aSquareSample times: aNumberOfTimes [

	aNumberOfTimes timesRepeat: [ aSquareList add: aSquareSample copy].
]

{ #category : 'actions' }
SquareGenerator >> createSquares: squareCount [

	| squareList blackHoleProbability hyperSpaceJumpProbability moonwalkProbability hyperJumpProbability atomicBombProbability |
	blackHoleProbability := 0.2.
	hyperSpaceJumpProbability := 0.2.
	moonwalkProbability := 0.1.
	hyperJumpProbability := 0.08.
	atomicBombProbability := 0.02.

	squareList := OrderedCollection new.

	self
		addToList: squareList
		squareSample: BlackHoleSquare new
		times: (squareCount * blackHoleProbability) asInteger.
	self
		addToList: squareList
		squareSample: HyperSpaceJumpSquare new
		times: (squareCount * hyperSpaceJumpProbability) asInteger.
	self
		addToList: squareList
		squareSample: (MoonWalkSquare withBackwardsPush: 2)
		times: (squareCount * moonwalkProbability) asInteger.
	self
		addToList: squareList
		squareSample: (HyperJumpSquare withParsecsPerSquare: 5 andParsecsRewards: #(20 15 12 8 5))
		times: (squareCount * hyperJumpProbability) asInteger.
	self
		addToList: squareList
		squareSample: AtomicBombSquare new
		times: (squareCount * atomicBombProbability) asInteger.
	self
		addToList: squareList
		squareSample: EmptySquare new
		times: squareCount - squareList size.

	^ squareList shuffle
]
