!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'SR 11/6/2022 17:39:43'!
test01CannotCreateCardWithInvalidNumber

	| aCard |
	
	self 
		should: [ aCard := CreditCard expiringOn: (Month month: 4 year: 2050) withNumber: 1 withOwner: 'Jorge Drexler' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidCardNumberErrorDescription ]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'SR 11/6/2022 17:02:59'!
test02CannotCreateCardWithEmptyOwner

	| aCard |
	
	self 
		should: [ aCard := CreditCard expiringOn: (Month month: 4 year: 2050) withNumber: 1234123412341234 withOwner: '' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidCardOwnerErrorDescription ]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'SR 11/6/2022 17:10:02'!
test03CardCreatedWithValidNumberAndOwnerStoresCorrectInfo

	| aCard |
	
	aCard := CreditCard expiringOn: (Month month: 4 year: 2050) withNumber: 1234123412341234 withOwner: 'John Doe'.
	
	self assert: aCard creditCardOwner equals: 'John Doe'.
	self assert: aCard creditCardNumber equals: 1234123412341234.
	self assert: aCard creditCardExpiration equals: (Month month: 4 year: 2050).! !


!classDefinition: #InterfazTest category: 'TusLibros'!
TestCase subclass: #InterfazTest
	instanceVariableNames: 'testObjectsFactory authenticatorBehavior laInterfaz'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfazTest methodsFor: 'setUp' stamp: 'MO 11/3/2022 21:18:40'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	authenticatorBehavior := [ :aUser :aPassword | true ].
	
	laInterfaz := testObjectsFactory createInterfaz: self.! !


!InterfazTest methodsFor: 'test' stamp: 'MO 11/3/2022 21:18:29'!
test01createCartDaErrorConUsuarioInvalido
	
	| aUser aPassword |
	
	aUser := 'La invalida'.
	aPassword := 'contraseña valida'.
	authenticatorBehavior := [ :anUser :anPassword | false ].
	
	self 
		should: [ laInterfaz createCartForUser: aUser withPassword: aPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interfaz invalidLogInErrorDescription ]
	! !

!InterfazTest methodsFor: 'test' stamp: 'MO 11/3/2022 21:18:20'!
test02createCartDaErrorConContraseniaInvalida
	
	| aUser aPassword |
	
	aUser := 'Carla la valida'.
	aPassword := 'contraseña invalida'.
	authenticatorBehavior := [ :anUser :anPassword | false ].
	
	self 
		should: [ laInterfaz createCartForUser: aUser withPassword: aPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interfaz invalidLogInErrorDescription ]
	! !

!InterfazTest methodsFor: 'test' stamp: 'MO 11/3/2022 21:19:49'!
test03createCartFuncionaConUnUsuarioYContraseniaValidos

	| aUser aPassword changoID |

	aUser := 'Carla la valida'.
	aPassword := 'contraseña valida'.

	changoID := laInterfaz createCartForUser: aUser withPassword: aPassword.

	self assert: (laInterfaz listCart: changoID) isEmpty
	! !

!InterfazTest methodsFor: 'test' stamp: 'MO 11/3/2022 21:35:53'!
test04addCartNoFuncionaConUnIDInvalido

	self 
		should: [ laInterfaz addToCart: 0 book: 'Libro valido' quantity: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interfaz invalidCartIDErrorDescription ]! !

!InterfazTest methodsFor: 'test' stamp: 'MO 11/3/2022 21:48:56'!
test05addCartNoFuncionaConUnLibroInvalido

	| changoID |
	
	changoID := laInterfaz createCartForUser: 'user' withPassword: 'pass'.
	
	self 
		should: [ laInterfaz addToCart: changoID book:  'Don Quejas' quantity: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interfaz invalidBookISBNIDErrorDescription.
			self assert: (laInterfaz listCart: changoID) isEmpty ]! !

!InterfazTest methodsFor: 'test' stamp: 'MO 11/3/2022 21:53:00'!
test06addCartNoFuncionaConUnaCantidadInvalida

	| changoID |
	
	changoID := laInterfaz createCartForUser: 'user' withPassword: 'pass'.
	
	self 
		should: [ laInterfaz addToCart: changoID book: (testObjectsFactory itemSellByTheStore) quantity: -69 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interfaz invalidQuantityErrorDescription.
			self assert: (laInterfaz listCart: changoID) isEmpty ]! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/5/2022 16:28:10'!
test07AddToCartAgregaUnLibroCorrectamente

	| changoID |
	
	changoID := laInterfaz createCartForUser: 'user' withPassword: 'pass'.
	
	laInterfaz addToCart: changoID book: (testObjectsFactory itemSellByTheStore) quantity: 1.
	
	self assert: (laInterfaz listCart: changoID) size equals: 1.
	self assert: (laInterfaz listCart: changoID) first equals: (testObjectsFactory itemSellByTheStore).! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/5/2022 16:28:56'!
test08ListCartNoFuncionaConCartIDInvalida

	self 
		should: [ laInterfaz listCart: 0 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interfaz invalidCartIDErrorDescription ]! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/5/2022 16:30:37'!
test09ListCartACartConUnLibroRetornaColeccionConEseLibro

	| changoID |
	
	changoID := laInterfaz createCartForUser: 'user' withPassword: 'pass'.
	
	laInterfaz addToCart: changoID book: (testObjectsFactory itemSellByTheStore) quantity: 1.
	
	self assert: (laInterfaz listCart: changoID) size equals: 1.
	self assert: (laInterfaz listCart: changoID) first equals: (testObjectsFactory itemSellByTheStore).! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/5/2022 16:37:56'!
test10ListCartACartConMultiplesLibrosRetornaColeccionConEsosLibros

	| changoID |
	
	changoID := laInterfaz createCartForUser: 'user' withPassword: 'pass'.
	
	laInterfaz addToCart: changoID book: (testObjectsFactory itemSellByTheStore) quantity: 2.
	laInterfaz addToCart: changoID book: (testObjectsFactory otherItemSellByTheStore) quantity: 3.
	
	self assert: (laInterfaz listCart: changoID) size equals: 5.
	self assert: ((laInterfaz listCart: changoID) occurrencesOf: (testObjectsFactory itemSellByTheStore)) equals: 2.
	self assert: ((laInterfaz listCart: changoID) occurrencesOf: (testObjectsFactory otherItemSellByTheStore)) equals: 3.! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/6/2022 17:53:30'!
test11CheckOutACartWithInvalidIDRaisesException

	|aDate aSalesBook |
	
	aDate  := Month month: 4 year: 2023 .
	aSalesBook := OrderedCollection new.
	
	self 
		should: [laInterfaz checkOutCart: 0 withCard: 1234567812345678 expiringOn: aDate withOwner: 'Mariano Oca' registeringOn: aSalesBook ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interfaz invalidCartIDErrorDescription.
			self assert: aSalesBook isEmpty ]! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/6/2022 17:54:38'!
test12CheckOutACartWithExpiredCardRaisesException

	|aDate changoID aSalesBook |
	
	aDate  := Month month: 4 year: 1998.
	changoID := laInterfaz createCartForUser: 'user' withPassword: 'pass'.
	laInterfaz addToCart: changoID book: (testObjectsFactory itemSellByTheStore) quantity: 2.
	aSalesBook := OrderedCollection new.
	
	self 
		should: [laInterfaz checkOutCart: changoID withCard: 1234567812345678 expiringOn: aDate withOwner: 'user' registeringOn: aSalesBook ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: aSalesBook isEmpty. ]! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/6/2022 17:54:49'!
test13CheckOutACartWithInvalidNumberedCardRaisesException
	| aDate changoID aSalesBook |
	
	aDate  := Month month: 4 year: 2050.
	changoID := laInterfaz createCartForUser: 'user' withPassword: 'pass'.
	laInterfaz addToCart: changoID book: (testObjectsFactory itemSellByTheStore) quantity: 2.
	aSalesBook := OrderedCollection new.
	
	self 
		should: [ laInterfaz checkOutCart: changoID withCard: 1 expiringOn: aDate withOwner: 'user' registeringOn: aSalesBook ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidCardNumberErrorDescription.
			self assert: aSalesBook isEmpty. ]! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/6/2022 17:59:27'!
test14CheckOutACartWithOneBookRegistersSaleCorrectly

	| aDate changoID aSalesBook |
	
	aDate  := Month month: 4 year: 2050.
	changoID := laInterfaz createCartForUser: 'user' withPassword: 'pass'.
	aSalesBook := OrderedCollection new.
	
	laInterfaz addToCart: changoID book: (testObjectsFactory itemSellByTheStore) quantity: 1.
	laInterfaz checkOutCart: changoID withCard: 1234123412341234 expiringOn: aDate withOwner: 'user' registeringOn: aSalesBook.
	
	self assert: aSalesBook size equals: 1.
	self assert: (aSalesBook first) total equals: (testObjectsFactory itemSellByTheStorePrice).

	! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/6/2022 18:04:23'!
test15CannotListPurchasesIfAuthenticationFails

	| aUser aPassword |
	
	aUser := 'La invalida'.
	aPassword := 'contraseña valida'.
	authenticatorBehavior := [ :anUser :anPassword | false ].
	
	self 
		should: [ laInterfaz listPurchasesOf: aUser withPassword: aPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interfaz invalidLogInErrorDescription ]! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/6/2022 22:26:04'!
test16ListPurchasesWithoutSalesReturnsEmptyCollection

	| aUser aPassword purchases |
	
	aUser := 'La invalida'.
	aPassword := 'contraseña valida'.
	
	purchases := laInterfaz listPurchasesOf: aUser withPassword: aPassword.
	
	self assert: purchases isEmpty.! !

!InterfazTest methodsFor: 'test' stamp: 'SR 11/6/2022 23:50:06'!
test17ListPurchasesWithoutOneSaleReturnsACollectionWithThatSale

	| aUser aPassword purchases aDate changoID aSalesBook aSaleTotal |
	
	aUser := 'user'.
	aPassword := 'pass'.
	
	aDate  := Month month: 4 year: 2050.
	aSalesBook := OrderedCollection new.
	
	changoID := laInterfaz createCartForUser: aUser withPassword: aPassword.
	laInterfaz addToCart: changoID book: (testObjectsFactory itemSellByTheStore) quantity: 1.
	aSaleTotal := laInterfaz checkOutCart: changoID withCard: 1234123412341234 expiringOn: aDate withOwner: 'Owner' registeringOn: aSalesBook.
	
	purchases := laInterfaz listPurchasesOf: aUser withPassword: aPassword.
	
	self assert: purchases size > 0.
	self assert: purchases first = testObjectsFactory otherItemSellByTheStore.
	self assert: purchases second = 0.
	self assert: purchases third = testObjectsFactory itemSellByTheStore.
	self assert: purchases fourth = 1.
	self assert: purchases last = testObjectsFactory itemSellByTheStorePrice.! !


!InterfazTest methodsFor: 'authenticator protocol' stamp: 'MO 11/3/2022 19:53:14'!
authenticateUser: aUser with: aPassword
	
	^ authenticatorBehavior value: aUser value: aPassword! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'SR 11/6/2022 23:27:05'!
catalog

	^catalog! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'MO 11/3/2022 21:13:41'!
items
	
	^ items copy! !

!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'SR 11/6/2022 17:37:02'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !

!Cashier methodsFor: 'checkout' stamp: 'SR 11/6/2022 23:47:05'!
saleSummary

	| saleSummary |
	
	saleSummary := OrderedCollection new.
	cart catalog keysDo: [ :book |
		saleSummary add: book.
		saleSummary add: (cart items occurrencesOf: book).
		].
	saleSummary add: cart total.
	^saleSummary.! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'cde 11/6/2022 14:54:22'!
canNotChargeAnInvalidCreditCardNumberErrorMessage
	
	^'Ese numero de tarjeta es invalido'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner cardNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'cde 11/6/2022 15:15:49'!
initializeExpiringOn: aMonth withNumber: aNumber withOwner: aName

	expiration := aMonth.
	cardNumber := aNumber.
	owner := aName.
	! !


!CreditCard methodsFor: 'cardNumber' stamp: 'SR 11/6/2022 17:08:52'!
creditCardExpiration
	^ expiration! !

!CreditCard methodsFor: 'cardNumber' stamp: 'cde 11/6/2022 15:07:45'!
creditCardNumber
	^ cardNumber! !

!CreditCard methodsFor: 'cardNumber' stamp: 'SR 11/6/2022 17:00:59'!
creditCardOwner
	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'SR 11/6/2022 17:04:14'!
assertCreditCardNumberIsValid: aCardNumber
	
	(aCardNumber > ((10 ^ 16) -1) or: [aCardNumber <= ((10 ^ 15) -1)]) ifTrue: [self error: self invalidCardNumberErrorDescription].! !

!CreditCard class methodsFor: 'instance creation' stamp: 'SR 11/6/2022 17:04:08'!
assertCreditCardOwnerIsValid: aCardOwner
	
	(aCardOwner = '') ifTrue: [self error: self invalidCardOwnerErrorDescription ].! !

!CreditCard class methodsFor: 'instance creation' stamp: 'SR 11/6/2022 17:04:27'!
expiringOn: aMonth withNumber: aCardNumber withOwner: aName

	self assertCreditCardNumberIsValid: aCardNumber.
	self assertCreditCardOwnerIsValid: aName.
	
	^self new initializeExpiringOn: aMonth withNumber: aCardNumber withOwner: aName.! !

!CreditCard class methodsFor: 'instance creation' stamp: 'cde 11/6/2022 15:00:20'!
invalidCardNumberErrorDescription
	
	^'El numero de tarjeta es invalido'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'SR 11/6/2022 17:03:31'!
invalidCardOwnerErrorDescription
	
	^'El owner de la tarjeta es invalido'! !


!classDefinition: #Interfaz category: 'TusLibros'!
Object subclass: #Interfaz
	instanceVariableNames: 'authenticator catalog cartIDtoCart cartIDManager merchantProcessor saleSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interfaz methodsFor: 'assertions' stamp: 'MO 11/3/2022 21:28:44'!
assertValid: aUserID with: aPassword

	(authenticator authenticateUser: aUserID with: aPassword) ifFalse: [self error: self class invalidLogInErrorDescription]! !

!Interfaz methodsFor: 'assertions' stamp: 'MO 11/3/2022 21:53:49'!
assertValidBook: aBookISBN

	(catalog includesKey: aBookISBN) ifFalse: [ self error: self class invalidBookISBNIDErrorDescription ]! !

!Interfaz methodsFor: 'assertions' stamp: 'MO 11/3/2022 21:42:24'!
assertValidCart: aChangoID

	(cartIDtoCart includesKey: aChangoID) ifFalse: [ self error: self class invalidCartIDErrorDescription ]! !

!Interfaz methodsFor: 'assertions' stamp: 'MO 11/3/2022 21:47:29'!
assertValidQuantity: aQuantity

	(aQuantity > 0) ifFalse: [ self error: self class invalidQuantityErrorDescription ]! !


!Interfaz methodsFor: 'initialization' stamp: 'SR 11/6/2022 23:39:04'!
initializeWith: anAuthenticator with: aCatalog 

	authenticator := anAuthenticator.
	catalog  := aCatalog.
	cartIDtoCart := Dictionary new.
	cartIDManager := 0.
	saleSummary := OrderedCollection new.! !


!Interfaz methodsFor: 'operations' stamp: 'MO 11/3/2022 21:44:26'!
addToCart: aChangoID book: aBookISBN quantity: aQuantity
	
	self assertValidCart: aChangoID.
	self assertValidBook: aBookISBN.
	self assertValidQuantity: aQuantity.
	
	(cartIDtoCart at: aChangoID) add: aQuantity of: aBookISBN! !

!Interfaz methodsFor: 'operations' stamp: 'SR 11/6/2022 23:32:00'!
checkOutCart: cartID withCard: cardNumber expiringOn: aDate withOwner: aName registeringOn: aSalesRegister

	| aCard aCashier |
	
	self assertValidCart: cartID.
	
	aCard := CreditCard expiringOn: aDate withNumber: cardNumber withOwner: aName.
	aCashier := Cashier toCheckout: (cartIDtoCart at: cartID) charging: aCard throught: (MerchantProcessorSimulator new) on: (DateAndTime now) registeringOn: aSalesRegister.
	saleSummary := aCashier saleSummary.
	
	^aCashier checkOut.! !

!Interfaz methodsFor: 'operations' stamp: 'SR 11/7/2022 00:33:44'!
createCartForUser: aUserID withPassword: aPassword
	
	self assertValid: aUserID with: aPassword.
	
	cartIDtoCart at: cartIDManager put: (Cart acceptingItemsOf: catalog).
	
	cartIDManager := cartIDManager + 1.
	
	^ cartIDManager - 1! !

!Interfaz methodsFor: 'operations' stamp: 'SR 11/5/2022 16:29:19'!
listCart: aChangoID

	self assertValidCart: aChangoID.
	^ (cartIDtoCart at: aChangoID) items! !

!Interfaz methodsFor: 'operations' stamp: 'SR 11/6/2022 23:33:07'!
listPurchasesOf: aUserID withPassword: aPassword
	
	self assertValid: aUserID with: aPassword.
	
	^saleSummary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interfaz class' category: 'TusLibros'!
Interfaz class
	instanceVariableNames: ''!

!Interfaz class methodsFor: 'instance creation' stamp: 'MO 11/3/2022 21:07:03'!
withAuthenticator: anAuthenticator withCatalog: aCatalog 
	
	^ self new initializeWith: anAuthenticator with: aCatalog
	! !


!Interfaz class methodsFor: 'error descriptions' stamp: 'MO 11/3/2022 21:46:33'!
invalidBookISBNIDErrorDescription

	^ 'no conocemos ese broli, proba escribirlo y capa lo publicamo'! !

!Interfaz class methodsFor: 'error descriptions' stamp: 'MO 11/3/2022 21:25:15'!
invalidCartIDErrorDescription

	^ 'ese chango no existe man'! !

!Interfaz class methodsFor: 'error descriptions' stamp: 'MO 11/3/2022 20:00:19'!
invalidLogInErrorDescription

	^ 'usuario o contrasenia invalido'! !

!Interfaz class methodsFor: 'error descriptions' stamp: 'MO 11/3/2022 21:47:51'!
invalidQuantityErrorDescription

	^ 'claramente no sabes contar'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'cde 11/5/2022 17:50:06'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'cde 11/5/2022 17:51:18'!
initialize
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'MO 11/3/2022 21:51:04'!
itemNotSellByTheStore
	
	^'Las marivollas aventuras de Marian y Santi en la calse de Inge'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'MO 11/3/2022 21:50:35'!
itemSellByTheStore
	
	^ 'La vida y obra de grandes personas como Carla'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'SR 11/5/2022 16:35:14'!
otherItemSellByTheStore
	
	^ 'Otro libro a la venta'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'SR 11/5/2022 16:35:31'!
otherItemSellByTheStorePrice
	
	^50! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'SR 11/5/2022 16:35:55'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self otherItemSellByTheStore put: self otherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'cde 11/5/2022 17:37:19'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withNumber: 1234123412341234 withOwner: 'Santi '! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'cde 11/5/2022 17:37:44'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withNumber: 1234123412341234 withOwner: 'Marianito'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'interfaz' stamp: 'MO 11/3/2022 21:02:42'!
createInterfaz: anAuthenticator
	
	^ Interfaz withAuthenticator: anAuthenticator withCatalog: self defaultCatalog! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
