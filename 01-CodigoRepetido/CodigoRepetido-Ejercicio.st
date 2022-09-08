!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'MO 9/8/2022 14:54:20'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook|
	
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'] lastLessThan: 50*millisecond.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MO 9/8/2022 14:54:20'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.

	self assertThat: [customerBook removeCustomerNamed: paulMcCartney.] lastLessThan: 100*millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MO 9/8/2022 14:55:24'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assertErrorAddingCustomer: '' onBook: customerBook! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MO 9/8/2022 14:55:39'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	
	self assertNotFoundRemovingCustomer: 'Paul McCartney' fromBook: customerBook
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MO 9/8/2022 14:53:30'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspend: paulMcCartney fromBook: customerBook.
	
	self assertFromBook: customerBook numberOfCustomers: 1 active: 0 andSuspended: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MO 9/8/2022 14:53:30'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspend: paulMcCartney fromBook: customerBook.
	customerBook removeCustomerNamed: paulMcCartney.

	self assertFromBook: customerBook numberOfCustomers: 0 active: 0 andSuspended: 0.

	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MO 9/8/2022 14:55:06'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	
	self assertCantSuspendCustomer: 'George Harrison' fromBook: customerBook
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MO 9/8/2022 14:55:06'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	
	self addAndSuspend: johnLennon fromBook: customerBook.
	
	self assertCantSuspendCustomer: johnLennon fromBook: customerBook
! !


!CustomerBookTest methodsFor: 'private methods' stamp: 'MO 9/7/2022 16:37:21'!
addAndSuspend: aCustomer fromBook: aBook 
	
	aBook addCustomerNamed: aCustomer.
	aBook suspendCustomerNamed: aCustomer.
	
	
	

	
! !

!CustomerBookTest methodsFor: 'private methods' stamp: 'MO 9/8/2022 14:56:13'!
assertCantSuspendCustomer: aCustomer fromBook: aBook
	
	self evaluate: [aBook suspendCustomerNamed: aCustomer] withErrorMessage: CantSuspend 
		toAssert: [
			self assert: aBook numberOfCustomers = 1.
			self assert: (aBook includesCustomerNamed: 'John Lennon')]
! !

!CustomerBookTest methodsFor: 'private methods' stamp: 'MO 9/8/2022 14:56:13'!
assertErrorAddingCustomer: aCustomer onBook: aBook
	
	self evaluate: [aBook addCustomerNamed: aCustomer] withErrorMessage: Error 
		toAssert: [ :anError |
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: aBook isEmpty ]
		! !

!CustomerBookTest methodsFor: 'private methods' stamp: 'MO 9/8/2022 14:53:30'!
assertFromBook: aBook numberOfCustomers: totalCustomers active: activeCustomers andSuspended: suspendedCustomers

	self assert: activeCustomers equals: aBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: aBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: aBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'private methods' stamp: 'MO 9/8/2022 14:56:13'!
assertNotFoundRemovingCustomer: aCustomer fromBook: aBook
	
	self evaluate: [aBook removeCustomerNamed: aCustomer] withErrorMessage: NotFound
		toAssert: [
			self assert: aBook numberOfCustomers = 1.
			self assert: (aBook includesCustomerNamed: 'John Lennon')]
! !

!CustomerBookTest methodsFor: 'private methods' stamp: 'MO 9/8/2022 14:54:20'!
assertThat: aBlock lastLessThan: timeLimit 

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (timeLimit)
	
! !

!CustomerBookTest methodsFor: 'private methods' stamp: 'MO 9/8/2022 14:56:13'!
evaluate: aBlock withErrorMessage: aMessage toAssert: aAssertBlock 
	
	[aBlock value.
	self fail ]
		on: aMessage 
		do: aAssertBlock! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'private methods' stamp: 'MO 9/8/2022 15:28:41'!
checkNameDoesNotAlreadyExist: aName

	^ ((active includes: aName) or: (suspended includes: aName)) ifTrue: [ self signalCustomerAlreadyExists ]! !

!CustomerBook methodsFor: 'private methods' stamp: 'MO 9/7/2022 17:12:33'!
checkNameIsNotEmpty: aName

	^ aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ]! !

!CustomerBook methodsFor: 'private methods' stamp: 'SR 9/7/2022 21:46:37'!
in: aCollection find: anElement andDo: aBlock

	1 to: aCollection size do: 
	[ :index |
		(anElement = (aCollection at: index)) ifTrue: [ aBlock  value: index ].
	].! !

!CustomerBook methodsFor: 'private methods' stamp: 'MO 9/8/2022 15:29:45'!
removeCustomerNamed: aName in: aCollection
	
	self in: aCollection find: aName andDo: [:index |
			aCollection removeAt: index.
			^aName.
		]
! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MO 9/7/2022 17:14:01'!
addCustomerNamed: aName

	self checkNameIsNotEmpty: aName.
	
	self checkNameDoesNotAlreadyExist: aName.
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MO 9/8/2022 15:29:45'!
removeCustomerNamed: aName 
	|customer|
	
	((self removeCustomerNamed: aName in: active) = aName) ifTrue:[^aName].
	
	customer := self removeCustomerNamed: aName in: suspended.
	(customer = aName) ifTrue:[^aName].
	
	"consulta para el docente: cómo podemos hacer esto de forma más linda?
	es mejor la primera forma o la segunda?
	cómo podemos hacer para que removeCustomerNamed:onCollection: le diga a
	removeCustomerNamed: que envíe un mensaje o haga un return?"

	^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
