!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:57'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:57'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack := stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:57'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:58'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:58'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:57'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:57'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:57'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:58'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'MO 9/17/2022 21:20:57'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'aStack aSenteceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'MO 9/19/2022 15:38:41'!
setUp

	aStack := OOStack new.
	
	aSenteceFinder := SentenceFinderByPrefix new.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/18/2022 20:54:53'!
test01PrefixShouldNotBeEmpty

	self
		should: [ aSenteceFinder searchByPrefix: '' inStack: aStack ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/18/2022 21:37:02'!
test02PrefixShouldNotHaveSpaces

	self
		should: [ aSenteceFinder searchByPrefix: 'space spaces' inStack: aStack ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpacesErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SR 9/18/2022 22:38:24'!
test03OneSentenceShouldBeFoundByPrefix
	
	|sentecesFoundReal sentecesFoundExpected|
	
	aStack push: 'la vaca lola'.
	
	sentecesFoundReal := (aSenteceFinder searchByPrefix: 'la' inStack: aStack).
	
	sentecesFoundExpected := OrderedCollection with: 'la vaca lola'.
	
	self assert: (sentecesFoundReal = sentecesFoundExpected).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/19/2022 15:25:26'!
test04NoneSentenceShouldBeFoundByPrefix
	
	| sentecesFoundReal |
	
	aStack push: 'la vaca lola'.
	
	sentecesFoundReal := (aSenteceFinder searchByPrefix: 'La' inStack: aStack).
	
	self assert: (sentecesFoundReal size = 0).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/19/2022 15:25:58'!
test04SentenceFinderIsCaseSensitive
	
	| sentecesFoundReal |
	
	aStack push: 'la vaca lola'.
	
	sentecesFoundReal := (aSenteceFinder searchByPrefix: 'La' inStack: aStack).
	
	self assert: (sentecesFoundReal size = 0).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/19/2022 15:13:20'!
test05MultipleSentencesShouldBeFoundByPrefix
	
	| sentecesFoundReal sentecesFoundExpected |
	
	aStack push: 'winter is coming'; push: 'winning is everything'; push: 'Winter is here'; push: 'The winds of Winter'.
	
	sentecesFoundReal := (aSenteceFinder searchByPrefix: 'win' inStack: aStack).
	
	sentecesFoundExpected := OrderedCollection new.
	sentecesFoundExpected add: 'winning is everything'; add: 'winter is coming'.
	
	self assert: (sentecesFoundReal = sentecesFoundExpected).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SR 9/18/2022 23:30:55'!
test06AllSentencesShouldBeFoundByPrefix
	
	| sentecesFoundReal sentecesFoundExpected |
	
	aStack push: 'winter is coming'; push: 'winning is everything'; push: 'winter is here'; push: 'winds of Winter'.
	
	sentecesFoundReal := (aSenteceFinder searchByPrefix: 'wi' inStack: aStack).
	
	sentecesFoundExpected := OrderedCollection new.
	sentecesFoundExpected addLast: 'winds of Winter'.
	sentecesFoundExpected addLast: 'winter is here'.
	sentecesFoundExpected addLast: 'winning is everything'.
	sentecesFoundExpected addLast: 'winter is coming'.
	
	self assert: (sentecesFoundReal = sentecesFoundExpected).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/19/2022 15:28:32'!
test07NoneSentencesShouldBeFoundByPrefix
	
	| sentecesFoundReal |
	
	aStack push: 'winter is coming'; push: 'winning is everything'; push: 'winter is here'; push: 'winds of Winter'.
	
	sentecesFoundReal := (aSenteceFinder searchByPrefix: 'is' inStack: aStack).
	
	self assert: (sentecesFoundReal size = 0).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/19/2022 15:30:46'!
test08StackRemainsTheSameAfterFindingNothing
	
	| anotherStack |
	
	anotherStack := aStack.
	
	aStack push: 'winter is coming'; push: 'winning is everything'; push: 'winter is here'; push: 'winds of Winter'.
	
	aSenteceFinder searchByPrefix: 'is' inStack: aStack.
	
	self assert: (aStack = anotherStack).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/19/2022 15:35:44'!
test09StackRemainsTheSameAfterFindingMatches
	
	| anotherStack sentecesFoundReal sentecesFoundExpected|
	
	anotherStack := aStack.
	
	aStack push: 'la vaca lola'; push: 'no tiene cabeza'; push: 'no tiene cola'; push: 'inge1 la mejor materia'.
	
	sentecesFoundReal := (aSenteceFinder searchByPrefix: 'no' inStack: aStack).
	
	sentecesFoundExpected := OrderedCollection new.
	sentecesFoundExpected add: 'no tiene cola'; add: 'no tiene cabeza'.
	
	self assert: (sentecesFoundReal = sentecesFoundExpected).
	self assert: (aStack = anotherStack).! !


!SentenceFinderByPrefixTest methodsFor: 'private test' stamp: 'MO 9/19/2022 14:56:17'!
test01PruebasSobreIsPrefix
	
	self assert: (aSenteceFinder isPrefix: 'la' of: 'la vaca lola').
	
	self deny: (aSenteceFinder isPrefix: 'La' of: 'la vaca lola').! !

!SentenceFinderByPrefixTest methodsFor: 'private test' stamp: 'MO 9/19/2022 15:10:29'!
test02PruebasSobreHasNoSpaces
	
	self assert: (aSenteceFinder hasNoSpaces: 'NoHayEspacioAcá').
	
	self deny: (aSenteceFinder hasNoSpaces: 'AcáHayUnEspacio Ahí').! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'last size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'methods' stamp: 'MO 9/17/2022 21:20:32'!
isEmpty

	^ last isEmpty! !

!OOStack methodsFor: 'methods' stamp: 'MO 9/18/2022 16:16:05'!
pop

	|aSentence|
	
	aSentence := self top.
	
	last := last previous.
	
	size := size - 1.
	
	^ aSentence! !

!OOStack methodsFor: 'methods' stamp: 'MO 9/18/2022 16:16:12'!
push: aSentence
	
	last := OOStackElement new initializeWithPrevious: last withContent: aSentence.
	
	size := size + 1! !

!OOStack methodsFor: 'methods' stamp: 'MO 9/17/2022 21:51:15'!
size

	^ size! !

!OOStack methodsFor: 'methods' stamp: 'MO 9/17/2022 21:46:48'!
top

	^ last content! !


!OOStack methodsFor: 'instace creation' stamp: 'MO 9/17/2022 22:03:00'!
initialize

	last := OOStackBase new.
	size := 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'MO 9/15/2022 21:29:10'!
stackEmptyErrorDescription
	
	^ 'cant do that stack is empty!!!!!!'! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
Object subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'methods' stamp: 'MO 9/17/2022 21:54:24'!
content

	self error: OOStack stackEmptyErrorDescription! !

!OOStackBase methodsFor: 'methods' stamp: 'MO 9/17/2022 21:54:32'!
isEmpty

	^ true! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'previous content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'instace creation' stamp: 'MO 9/18/2022 16:19:04'!
initializeWithPrevious: previousOOStackElement withContent: aSentence

	previous := previousOOStackElement.
	content  := aSentence.! !


!OOStackElement methodsFor: 'methods' stamp: 'MO 9/17/2022 21:37:45'!
content

	^ content! !

!OOStackElement methodsFor: 'methods' stamp: 'MO 9/17/2022 20:59:41'!
isEmpty

	^ false! !

!OOStackElement methodsFor: 'methods' stamp: 'MO 9/17/2022 21:30:21'!
previous

	^ previous! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private methods' stamp: 'MO 9/19/2022 15:15:28'!
checkPrefixIsNotEmptyOrHasSpaces: aPrefix.
	
	aPrefix = '' ifTrue: [self error: SentenceFinderByPrefix emptyPrefixErrorDescription ].
	
	(self hasNoSpaces: aPrefix) ifFalse: [self error: SentenceFinderByPrefix prefixWithSpacesErrorDescription ].! !

!SentenceFinderByPrefix methodsFor: 'private methods' stamp: 'MO 9/19/2022 15:23:12'!
exploreStack: aStackToExplore pushingToSrack: aStackToPush usingPrefix: aPrefix
	
	| sentecesFound aSentence|
	
	sentecesFound := OrderedCollection new.
	
	aStackToExplore size timesRepeat: [
		aSentence := aStackToExplore pop.
		
		(self isPrefix: aPrefix of: aSentence) ifTrue: [ sentecesFound add: aSentence ].
		
		aStackToPush push: aSentence
		].
	
	^ sentecesFound! !

!SentenceFinderByPrefix methodsFor: 'private methods' stamp: 'MO 9/19/2022 15:08:29'!
hasNoSpaces: aPrefix

	"aPrefix do: [ :aCharacter | (aCharacter = ' ') ifTrue: [^ true] ]."
	
	^ aPrefix allSatisfy: [:a | a ~= $ ].! !

!SentenceFinderByPrefix methodsFor: 'private methods' stamp: 'MO 9/18/2022 21:15:58'!
isPrefix: aPrefix of: aString

	|aCroppedString|
	
	aCroppedString := aString copyFrom: 1 to: aPrefix size. 
	
	^ aCroppedString = aPrefix! !

!SentenceFinderByPrefix methodsFor: 'private methods' stamp: 'MO 9/19/2022 15:17:37'!
restoreStack: aStackToRestore fromSrack: aStackToTearDown. 

	aStackToTearDown size timesRepeat: [ aStackToRestore push: aStackToTearDown pop ].! !


!SentenceFinderByPrefix methodsFor: 'methods' stamp: 'MO 9/19/2022 15:24:22'!
searchByPrefix: aPrefix inStack: aOOStack

	|inverseStack sentecesFound|
	
	self checkPrefixIsNotEmptyOrHasSpaces: aPrefix.
	
	inverseStack := OOStack new.
	
	sentecesFound := self exploreStack: aOOStack pushingToSrack: inverseStack usingPrefix: aPrefix.
	
	self restoreStack: aOOStack fromSrack: inverseStack.
	
	^ sentecesFound.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'MO 9/18/2022 20:06:13'!
emptyPrefixErrorDescription
	
	^ 'prefix cant be empty!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'MO 9/18/2022 21:34:05'!
prefixWithSpacesErrorDescription
	
	^ 'prefix cant have spaces in it!!!!'! !
