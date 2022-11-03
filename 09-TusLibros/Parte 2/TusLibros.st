!classDefinition: #CardTest category: 'TusLibros'!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'tests' stamp: 'MO 11/1/2022 16:16:06'!
test01CardNameCanNotBeEmpty

	| invalidCard |
	
	self 
		should: [ invalidCard := self createCardWithName: '' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card invalidNameErrorDescription.
			self assert: invalidCard isNil ]! !

!CardTest methodsFor: 'tests' stamp: 'MO 11/1/2022 16:21:05'!
test02CardNameCanNotBeLongerThan30Charactes

	| invalidCard |

	self 
		should: [ invalidCard := self createCardWithName: 'Supercalifrastiliscoespiralidoso' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card invalidNameErrorDescription.
			self assert: invalidCard isNil ]! !

!CardTest methodsFor: 'tests' stamp: 'MO 11/1/2022 16:22:51'!
test03CardNumberCanNotBeLongerThan16Numbers

	| invalidCard |

	self 
		should: [ invalidCard := self createCardWithNumber: 12341234123412345 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card invalidNumberErrorDescription.
			self assert: invalidCard isNil ]! !

!CardTest methodsFor: 'tests' stamp: 'MO 11/1/2022 16:30:51'!
test04CardNumberCanNotBeNegative

	| invalidCard |

	self 
		should: [ invalidCard := self createCardWithNumber: -1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card invalidNumberErrorDescription.
			self assert: invalidCard isNil ]! !


!CardTest methodsFor: 'support' stamp: 'MO 11/1/2022 16:14:46'!
createCardWithName: aName

	^ Card withName: aName withNumber: 0 withExpiration: (GregorianMonthOfYear octoberOf: 1998)! !

!CardTest methodsFor: 'support' stamp: 'MO 11/1/2022 16:27:37'!
createCardWithNumber: aNumber

	^ Card withName: 'Sancho Panza' withNumber: aNumber withExpiration: (GregorianMonthOfYear octoberOf: 1998)! !


!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'cde 10/31/2022 19:41:31'!
defaultCatalog
	
	^ Dictionary with: (self itemSellByTheStore) -> 1! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'SR 11/2/2022 00:33:39'!
anOtherItemSellByTheStore
	
	^ 'SmallTalk: from zero to hero (by Carla)'.! !

!CashierTest methodsFor: 'support' stamp: 'SR 11/3/2022 00:42:15'!
createAValidCard

	"tarjeta válida para el Merchant"
	^ Card withName: 'PEPE SANCHEZ' withNumber: 5400000000000001 withExpiration: (GregorianMonthOfYear julyOf: 2011)! !

!CashierTest methodsFor: 'support' stamp: 'SR 11/2/2022 00:20:19'!
createAnExpiredCard

	^ Card withName: 'Sancho Panza' withNumber: 1234123412341234 withExpiration: (GregorianMonthOfYear julyOf: 1998)! !

!CashierTest methodsFor: 'support' stamp: 'SR 11/3/2022 00:42:36'!
createAnInvalidCard

	"tarjeta inválida para el merchant"
	^ Card withName: 'LEO MESSI' withNumber: 1111111111111111 withExpiration: (GregorianMonthOfYear julyOf: 2011)! !

!CashierTest methodsFor: 'support' stamp: 'cde 10/31/2022 18:41:02'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'MO 11/1/2022 15:35:56'!
createCashierWithDefaultDate
	
	^ Cashier with: (GregorianMonthOfYear septemberOf: 1998) "cumple Carla"! !

!CashierTest methodsFor: 'support' stamp: 'SR 11/2/2022 23:59:43'!
defaultCatalog
	|catalogo|
	catalogo := Dictionary new.
	catalogo add: (self itemSellByTheStore) -> (10000 * dollar).
	catalogo add: (self otherItemSellByTheStore) -> (58 * dollar).
	catalogo add: (self anOtherItemSellByTheStore) -> (123.50 * dollar).
	catalogo add: (self expensiveItemSellByTheStore ) -> (1000000000000000.50 * dollar).
	^ catalogo.! !

!CashierTest methodsFor: 'support' stamp: 'cde 11/2/2022 21:40:57'!
expensiveItemSellByTheStore
	
	^ 'Como mantener a un alumno despierto en dos simples pasos'! !

!CashierTest methodsFor: 'support' stamp: 'cde 10/31/2022 18:39:26'!
itemSellByTheStore
	
	^ 'La Biografia Completa de Mariano El Capo Oca'! !

!CashierTest methodsFor: 'support' stamp: 'cde 10/31/2022 19:47:13'!
otherItemSellByTheStore
	
	^ 'Filosofia clasica por el Santi'! !


!CashierTest methodsFor: 'tests' stamp: 'MO 11/1/2022 15:16:07'!
test01CannotCheckoutWithEmptyCart
	|unChango unCashier|
	
	unChango :=  self createCart.
	unCashier := Cashier new.
	
	self 
		should: [unCashier checkOut: unChango ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckoutEmptyCartErrorDescription. ]
	
	
! !

!CashierTest methodsFor: 'tests' stamp: 'cde 10/31/2022 19:42:18'!
test02CanCheckOutWithSingleBook
	
	|unChango unCashier|
	
	unCashier := Cashier new.
	unChango := self createCart.
	
	unChango add: self itemSellByTheStore.
	
	self assert: (unCashier checkOut: unChango) equals: (10000 * dollar)
	
	
	
	
	
! !

!CashierTest methodsFor: 'tests' stamp: 'SR 11/2/2022 00:35:22'!
test03CanCheckOutWithManyBooks
	
	|unChango unCashier|
	
	unCashier := Cashier new.
	unChango := self createCart.
	
	unChango add: self itemSellByTheStore.
	unChango add: self otherItemSellByTheStore.
	
	self assert: (unCashier checkOut: unChango) equals: (10058 * dollar)
	
	
	
	
	
! !

!CashierTest methodsFor: 'tests' stamp: 'SR 11/3/2022 00:29:43'!
test04CanNotCheckOutWithExpiredCard
	
	| unChango unCashier unPlasticoViejo |
	
	unCashier := self createCashierWithDefaultDate.
	unChango := self createCart.
	unChango add: (self itemSellByTheStore).
	unPlasticoViejo := self createAnExpiredCard.

	self 
		should: [ unCashier checkOut: unChango withCard: unPlasticoViejo ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckOutWithExpiredCardErrorDescription.
			self assert: unCashier salesHistory isEmpty]
	
	
	
	
	
! !

!CashierTest methodsFor: 'tests' stamp: 'SR 11/3/2022 00:41:22'!
test05CheckoutWithValidCardIsRegistersSaleInSalesBook
	
	| unChango unCashier unPlasticoValido |
	
	unCashier := self createCashierWithDefaultDate.
	unChango := self createCart.
	unChango add: (self anOtherItemSellByTheStore).
	unPlasticoValido := self createAValidCard.

	unCashier checkOut: unChango withCard: unPlasticoValido.
	
	self assert: (unCashier salesHistory size) equals: 1.! !

!CashierTest methodsFor: 'tests' stamp: 'SR 11/3/2022 00:29:47'!
test06CannotCheckoutWithInvalidTransactionAmount
	
	| unChango unCashier unPlasticoValido |
	
	unCashier := self createCashierWithDefaultDate.
	unChango := self createCart.
	unChango add: (self expensiveItemSellByTheStore ).
	unPlasticoValido := self createAValidCard.
	
	self 
		should: [ unCashier checkOut: unChango withCard: unPlasticoValido ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckOutWithInvalidTransactionAmountErrorDescription.
			self assert: unCashier salesHistory isEmpty]
	! !

!CashierTest methodsFor: 'tests' stamp: 'SR 11/3/2022 00:41:34'!
test07CannotCheckoutWithAnInvalidCard
	
	| unChango unCashier unPlasticoValido |
	
	unCashier := self createCashierWithDefaultDate.
	unChango := self createCart.
	unChango add: (self anOtherItemSellByTheStore).
	unPlasticoValido := self createAnInvalidCard .

	unCashier checkOut: unChango withCard: unPlasticoValido.
	
	self assert: (unCashier salesHistory size) equals: 0.! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'name number expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'expiration' stamp: 'SR 11/2/2022 00:18:53'!
isExpierdOn: aMonthAndYear
	
	^ expiration < aMonthAndYear! !


!Card methodsFor: 'initialization' stamp: 'MO 11/1/2022 16:08:32'!
initializewithName: aName withNumber: aNumber withExpiration: aMonthAndYear
	
	name := aName.
	number := aNumber.
	expiration := aMonthAndYear! !


!Card methodsFor: 'information' stamp: 'SR 11/2/2022 00:25:35'!
expiration
	^expiration.! !

!Card methodsFor: 'information' stamp: 'SR 11/2/2022 00:25:24'!
number
	^number.! !

!Card methodsFor: 'information' stamp: 'SR 11/2/2022 00:25:16'!
owner
	^name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'cde 10/31/2022 21:46:47'!
withExpirationDate: anExpirationDate
	
	^ self new initializeWith: anExpirationDate! !

!Card class methodsFor: 'instance creation' stamp: 'MO 11/1/2022 16:25:15'!
withName: aName withNumber: aNumber withExpiration: aMonthAndYear
	
	self assertIsValidName: aName.
	self assertIsValidNumber: aNumber.
	
	^ self new initializewithName: aName withNumber: aNumber withExpiration: aMonthAndYear! !


!Card class methodsFor: 'error descriptions' stamp: 'MO 11/1/2022 16:12:47'!
invalidNameErrorDescription

	^ 'los nombres de la tarjeta no pueden ni estar vacios ni ser mayores de 30 caracteres, daaaaa'! !

!Card class methodsFor: 'error descriptions' stamp: 'MO 11/1/2022 16:24:23'!
invalidNumberErrorDescription

	^ 'mucho numero'! !


!Card class methodsFor: 'assertions' stamp: 'MO 11/1/2022 16:18:50'!
assertIsValidName: aName

	(aName isEmpty or: aName size > 30) ifTrue: [self error: self invalidNameErrorDescription]! !

!Card class methodsFor: 'assertions' stamp: 'SR 11/2/2022 00:11:59'!
assertIsValidNumber: aNumber

	(aNumber < 0 or: aNumber > ((10 ^ 16) - 1)) ifTrue: [self error: self invalidNumberErrorDescription]! !


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


!Cart methodsFor: 'assertions' stamp: 'cde 10/31/2022 19:39:07'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'cde 10/31/2022 19:17:01'!
itemsValue
	^ items sum: [:aBook | catalog at: aBook ifAbsent: [0]] ifEmpty: [0]! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


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

!Cart class methodsFor: 'instance creation' stamp: 'cde 10/31/2022 21:47:14'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'monthAndYearOfToday salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'cde 11/2/2022 21:46:28'!
checkOut: unChango
	
	self assertValidCart: unChango.
	self assertValidTransaction: (unChango itemsValue).
		
	^ unChango itemsValue! !

!Cashier methodsFor: 'operations' stamp: 'cde 11/2/2022 23:22:20'!
checkOut: unChango withCard: aCard
	
	| unMerchant response |
	
	self assertValidCart: unChango.
	self assertValidCard: aCard.
	self assertValidTransaction: (unChango itemsValue).
	
	unMerchant := MerchantSimulator new.
	response := unMerchant debit: (unChango itemsValue) fromCreditCardNumber: (aCard number) withOwner: (aCard owner) andExpireDate: (aCard expiration).
	
	"si merchant retorna ok se registra la venta"
	(response = 'HTTP 200') ifTrue: [ salesBook add: [ unChango ] ].
	
	^ unChango itemsValue! !

!Cashier methodsFor: 'operations' stamp: 'SR 11/2/2022 00:43:24'!
salesHistory

	^ salesBook copy! !


!Cashier methodsFor: 'initialization' stamp: 'MO 11/1/2022 15:40:42'!
initializeWith: aFuckingDate

	monthAndYearOfToday := aFuckingDate.
	salesBook := OrderedCollection new.! !


!Cashier methodsFor: 'assertions' stamp: 'SR 11/3/2022 00:08:07'!
assertValidCard: aCard

	(aCard isExpierdOn: monthAndYearOfToday) ifTrue: [ ^self error: self class canNotCheckOutWithExpiredCardErrorDescription]! !

!Cashier methodsFor: 'assertions' stamp: 'SR 11/3/2022 00:08:11'!
assertValidCart: unChango
	
	(unChango isEmpty) ifTrue: [ ^self error: self class canNotCheckoutEmptyCartErrorDescription]! !

!Cashier methodsFor: 'assertions' stamp: 'SR 11/3/2022 00:29:04'!
assertValidTransaction: aTransactionAmount

	| aTransactionAmountUnDolarized integerPart fractionPart menosQueCero masDeQuinceDigitos masDeDosDecimales |
	
	aTransactionAmountUnDolarized := aTransactionAmount amount.
	
	integerPart := aTransactionAmountUnDolarized integerPart.
	fractionPart := (aTransactionAmountUnDolarized * 100) fractionPart .
	
	menosQueCero := aTransactionAmountUnDolarized < 0.
	masDeQuinceDigitos := integerPart > ((10^15)-1).
	masDeDosDecimales := fractionPart ~= 0.
	
	(menosQueCero or: [		masDeQuinceDigitos or: [			masDeDosDecimales ] ]) ifTrue: [ ^self error: self class canNotCheckOutWithInvalidTransactionAmountErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'cde 10/31/2022 21:51:26'!
canNotCheckOutWithExpiredCardErrorDescription

	^ 'Que no se entere tu mama que andas por ahi con tarjetas vencidas'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'cde 11/2/2022 21:24:46'!
canNotCheckOutWithInvalidTransactionAmountErrorDescription

	^ 'Mm esa transaccion esta rara'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'MO 11/1/2022 15:14:32'!
canNotCheckoutEmptyCartErrorDescription

	^ 'No maquina, el carrito esta vacio. Compra cositas antes de hacer checkout.'! !


!Cashier class methodsFor: 'instance creation' stamp: 'cde 10/31/2022 21:53:09'!
with: monthAndYear
	
	^ self new initializeWith: monthAndYear! !


!classDefinition: #MerchantSimulator category: 'TusLibros'!
Object subclass: #MerchantSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantSimulator methodsFor: 'as yet unclassified' stamp: 'SR 11/3/2022 00:37:17'!
debit: anAmount fromCreditCardNumber: aCardNumber withOwner: aCardOwner andExpireDate: anExpireDate

	"si es una tarjeta válida"
	(aCardNumber = 5400000000000001 and: [
		aCardOwner = 'PEPE SANCHEZ' and: [
			anExpireDate = (GregorianMonthOfYear julyOf: 2011) and: [
				anAmount = (123.50 * dollar)
				].
			].
		]) ifTrue: [ ^'HTTP 200' ].
	
	"cualquier otra tarjeta es inválida"
	^'HTTP 400'.! !
