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
	
	self addToList: squareList aSquareClass: BlackHoleSquare  times:((squareCount * blackHoleProbability ) asInteger).
	self addToList: squareList aSquareClass: HyperSpaceJumpSquare  times:((squareCount * hyperSpaceJumpProbability ) asInteger).
	self addToList: squareList aSquareClass: MoonWalkSquare  times:((squareCount * moonwalkProbability ) asInteger).
	self addToList: squareList aSquareClass: HyperJumpSquare  times:((squareCount * hyperJumpProbability ) asInteger).
	self addToList: squareList aSquareClass: AtomicBombSquare  times:((squareCount * atomicBombProbability ) asInteger).
	self addToList: squareList aSquareClass: EmptySquare  times:(squareCount - squareList size).
	
	^ squareList shuffle
]
