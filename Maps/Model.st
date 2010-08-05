Object subclass: MapObject [
    acceptVisitor: aVisitor [
        self subclassResponsibility
    ]
]

MapObject subclass: Map [
    | center mapType format size sensor zoom overlays |

    acceptVisitor: aVisitor [
        aVisitor visitMap: self.
    ]

    add: anObject [
        overlays isNil ifTrue: [overlays := OrderedCollection new].
        overlays add: anObject
    ]

    center [
        ^center
    ]

    center: aLocation [
        center := aLocation
    ]

    mapType [
        ^mapType ifNil: [mapType := #roadmap]
    ]

    mapType: aSymbol [
        mapType := aSymbol
    ]

    definesPosition [
        ^self numberOfOverlays > 0
    ]

    numberOfOverlays [
        ^overlays size
    ]

    overlays [
        ^overlays isNil ifTrue: [{}] ifFalse: [overlays asArray]
    ]

    overlaysDo: aBlock [
        overlays isNil ifTrue: [^self].
        overlays do: aBlock
    ]

    defaultFormat [
        mapType = #satellite ifTrue: [^#jpg].
        mapType = #hyprid ifTrue: [^#png32].
        ^#png
    ]

    format [
        ^format ifNil: [self defaultFormat]
    ]

    format: aSymbol [
        format := aSymbol
    ]

    size [
        ^size ifNil: [size := 400@400].
    ]

    size: anInteger [
        size := anInteger
    ]

    sensor [
        ^sensor ifNil: [sensor := false]
    ]

    sensor: aBoolean [
        sensor := aBoolean
    ]

    zoom [
        ^zoom
    ]

    zoom: anInteger [
        zoom := anInteger
    ]
]

MapObject subclass: MapPath [
    | weight color fillColor positions |

    acceptVisitor: aVisitor [
        aVisitor visitPath: self
    ]

    weight [
        ^weight ifNil: [weight := 5]
    ]

    weight: aString [
        weight := aString
    ]

    color [
        ^color
    ]

    color: aString [
        color := aString
    ]

    fillColor [
        ^fillColor
    ]

    fillColor: aString [
        fillColor := aString
    ]

    positions [
        ^positions isNil ifTrue: [{}] ifFalse: [positions asArray]
    ]

    positionsDo: aBlock [
        positions isNil ifTrue: [^self].
        positions do: aBlock
    ]

    add: aString [
        positions isNil ifTrue: [positions := OrderedCollection new].
        positions add: aString
    ]
]

MapObject subclass: MapPosition [
    | position |

    acceptVisitor: aVisitor [
        aVisitor visitPosition: self
    ]

    position [
        ^position
    ]

    position: aString [
        position := aString
    ]
]

MapPosition subclass: MapMarker [
    | color label shadow size |

    acceptVisitor: aVisitor [
        aVisitor visitMarker: self
    ]

    color [
        ^color
    ]

    color: aString [
        color := aString
    ]

    hasIcon [
        ^label isString not or: [label size > 1]
    ]

    label [
        ^label
    ]

    label: aString [
        label := aString
    ]

    shadow [
        ^shadow ifNil: [shadow := true ]
    ]

    shadow: aString [
        shadow := aString
    ]

    size [
        ^size ifNil: [size := #default]
    ]

    size: aSymbol [
        size := aSymbol
    ]

    hasSameStyleAs: aMarker [
        ^self size = aMarker size and: [
            self color = aMarker color and: [
            self shadow = aMarker shadow and: [
            self label = aMarker label]]]
    ]
]

Object subclass: MapVisitor [
    visitMarker: aMarker [
    ]

    visitPath: aPath [
    ]

    visitPosition: aPosition [
    ]

    visitMap: aMap [
        aMap overlaysDo: [ :each | self visit: each ]
    ]

    visit: aMapObject [
        aMapObject acceptVisitor: self
    ]
]
