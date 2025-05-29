Class {
	#name : 'SquareGeneratorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SquareGeneratorTest >> testB01WhenASquareGeneratorCreatesSquareAndSquareListSizeMatchesSquareCountThenValid [

	| squareCount squareGenerator squareList |
	
	squareCount := 100.
	
	squareGenerator := SquareGenerator new.
	
	squareList := squareGenerator createSquares: squareCount.
	
	
	self assert:((squareList size) = squareCount) 
	

]
