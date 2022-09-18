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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MO 9/18/2022 17:09:35'!
test01PrefixShouldNotBeEmpty

	| stack |
	
	stack := OOStackPrefixSearch new.
	
	self
		should: [ stack searchByPrefix: '' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStackPrefixSearch emptyPrefixErrorDescription ]! !


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


!classDefinition: #OOStackPrefixSearch category: 'Stack-Exercise'!
OOStack subclass: #OOStackPrefixSearch
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackPrefixSearch methodsFor: 'private methods' stamp: 'MO 9/18/2022 16:59:31'!
isPrefix: aPrefix! !


!OOStackPrefixSearch methodsFor: 'methods' stamp: 'MO 9/18/2022 16:57:43'!
searchByPrefix: aPrefix! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackPrefixSearch class' category: 'Stack-Exercise'!
OOStackPrefixSearch class
	instanceVariableNames: ''!

!OOStackPrefixSearch class methodsFor: 'error descriptions' stamp: 'MO 9/18/2022 17:08:43'!
emptyPrefixErrorDescription
	
	^ 'prefix cant be empty!!!!'! !


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
