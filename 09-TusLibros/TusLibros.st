!classDefinition: #ChangoTest category: 'TusLibros'!
TestCase subclass: #ChangoTest
	instanceVariableNames: 'catalogo libroEnElCatalogo libroProhibido'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ChangoTest methodsFor: 'setUp' stamp: 'MO 10/28/2022 00:05:34'!
setUp
	
	"por ahora, modelamos los libros como su id"
	libroEnElCatalogo := '001'.
	libroProhibido := '002'.
	
	"por ahora, modelamos un catálogo como un set de libros"
	catalogo := Set with: libroEnElCatalogo.! !


!ChangoTest methodsFor: 'tests' stamp: 'MO 10/27/2022 20:35:23'!
test01CuandoSeCreaUnChangoEstaVacio

	self assert: Chango new estaVacio! !

!ChangoTest methodsFor: 'tests' stamp: 'MO 10/27/2022 21:47:36'!
test02CuandoSeAgregaUnLibroAUnChangoVacioEsteDejaDeEstarVacio

	self deny: (Chango conCatalogo: catalogo conLibro: libroEnElCatalogo) estaVacio! !

!ChangoTest methodsFor: 'tests' stamp: 'MO 10/27/2022 21:49:18'!
test03NoSePuedenAgregarProductosFueraDelCatalogoAlChango

	| unChango |
	
	unChango := Chango conCatalogo: catalogo.
	
	self 
		should: [ unChango agregarLibro: libroProhibido ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Chango libroFueraDelCatalogoDescripcionDeError.
			self assert: unChango estaVacio]! !

!ChangoTest methodsFor: 'tests' stamp: 'MO 10/27/2022 21:49:59'!
test04NoSePuedeAgregarMenosDeUnaUnidadDelProductoAlChango

	| unChango |
	
	unChango := Chango conCatalogo: catalogo.
	
	self 
		should: [ unChango agregar: 0 libros: libroEnElCatalogo ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Chango seDebenAgregarUnLibroOMasDescripcionDeError.
			self assert: unChango estaVacio]
	! !

!ChangoTest methodsFor: 'tests' stamp: 'MO 10/28/2022 00:19:26'!
test05SePuedenAgregarProductosDentroDelCatalogoAlChango

	| unChango |
	
	unChango := Chango conCatalogo: catalogo.
	
	unChango agregarLibro: libroEnElCatalogo.
	unChango agregar: 2 libros: libroEnElCatalogo.
	
	self assert: (unChango contenido occurrencesOf: libroEnElCatalogo) equals: 3! !

!ChangoTest methodsFor: 'tests' stamp: 'MO 10/28/2022 00:20:39'!
test06UnChangoPuedeMostrarSuContenido

	| unChango libro1 libro2 libro3 |
	
	unChango := Chango conCatalogo: catalogo.
	libro1 := '01'. libro2 := '02'. libro3 := '03'.	
	catalogo add: libro1; add: libro2; add: libro3.
	
	unChango agregarLibro: libro1.
	unChango agregar: 2 libros: libro2.
	unChango agregarLibro: libro3.
	
	self assert: unChango contenido includes: libro1.
	self assert: (unChango contenido occurrencesOf: libro2) equals: 2.
	self assert: unChango contenido includes: libro3.
	self assert: (unChango contenido size) equals: 4! !


!classDefinition: #Catalogo category: 'TusLibros'!
Object subclass: #Catalogo
	instanceVariableNames: 'librosRegistrados'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogo methodsFor: 'inicialiacion' stamp: 'MO 10/27/2022 21:22:18'!
initialize
	
	librosRegistrados := Set new! !


!Catalogo methodsFor: 'xxxxxx' stamp: 'MO 10/27/2022 21:24:42'!
estaVacio
	
	^ librosRegistrados isEmpty! !

!Catalogo methodsFor: 'xxxxxx' stamp: 'MO 10/27/2022 21:32:06'!
registrarLibro: unLibro
	
	^ librosRegistrados add: unLibro! !


!classDefinition: #Chango category: 'TusLibros'!
Object subclass: #Chango
	instanceVariableNames: 'catalogo contenido'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Chango methodsFor: 'inicializacion' stamp: 'MO 10/27/2022 20:43:15'!
initialize

	contenido := Bag new! !

!Chango methodsFor: 'inicializacion' stamp: 'MO 10/27/2022 21:39:03'!
initializeConCatalogo: unCatalogo

	catalogo := unCatalogo.
	contenido := Bag new.! !

!Chango methodsFor: 'inicializacion' stamp: 'MO 10/27/2022 21:42:56'!
initializeConCatalogo: unCatalogo with: unLibro

	catalogo := unCatalogo.
	contenido := Bag new.
	
	self agregarLibro: unLibro! !


!Chango methodsFor: 'as yet unclassified' stamp: 'MO 10/27/2022 21:53:30'!
agregar: cantidadDelLibro libros: elLibro

	(cantidadDelLibro < 1) ifTrue: [self error: self class seDebenAgregarUnLibroOMasDescripcionDeError].
	
	contenido add: elLibro withOccurrences: cantidadDelLibro! !

!Chango methodsFor: 'as yet unclassified' stamp: 'MO 10/27/2022 21:42:30'!
agregarLibro: unLibro

	(catalogo includes: unLibro) ifFalse: [ self error: self class libroFueraDelCatalogoDescripcionDeError].
	
	contenido add: unLibro! !

!Chango methodsFor: 'as yet unclassified' stamp: 'MO 10/27/2022 21:56:17'!
contenido

	^ contenido copy! !

!Chango methodsFor: 'as yet unclassified' stamp: 'MO 10/27/2022 20:37:08'!
estaVacio

	^ contenido isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Chango class' category: 'TusLibros'!
Chango class
	instanceVariableNames: ''!

!Chango class methodsFor: 'creacion de instancias' stamp: 'MO 10/27/2022 21:44:19'!
conCatalogo: unCatalogo

	^ self new initializeConCatalogo: unCatalogo! !

!Chango class methodsFor: 'creacion de instancias' stamp: 'MO 10/27/2022 21:44:11'!
conCatalogo: unCatalogo conLibro: unLibro

	^ self new initializeConCatalogo: unCatalogo with: unLibro! !


!Chango class methodsFor: 'descripcion de errores' stamp: 'MO 10/27/2022 21:09:12'!
libroFueraDelCatalogoDescripcionDeError
	
	^ 'no la verdad que no juno ese librito, sori maquina'! !

!Chango class methodsFor: 'descripcion de errores' stamp: 'MO 10/27/2022 21:15:21'!
seDebenAgregarUnLibroOMasDescripcionDeError
	
	^ 'y no maquina, no se pueden agregar 0 libros o libros negativos, no es jowartz esto'! !


!classDefinition: #Libro category: 'TusLibros'!
Object subclass: #Libro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
