MapVisitor subclass: StaticMapURLCreator [
    | url queryStringParts lastMarker markers visible |
    queryString [
        ^String streamContents: [:s|
            queryStringParts
                do: [ :each |
                    s nextPutAll: each key.
                    s nextPut: $=.
                    each value
                        do: [ :val | s nextPutAll: (NetClients.URL encode: val) ]
                        separatedBy: [ s nextPut: $| ]]
                separatedBy: [ s nextPut: $& ]]
    ]

    url [
        ^url ifNil: [
            url := self baseUrl copy
                query: self queryString;
                yourself ]
    ]

    baseUrl [
        ^NetClients.URL scheme: 'http'
            host: 'maps.google.com'
            path: '/maps/api/staticmap'
    ]

    addField: key [
        ^(queryStringParts add: key->OrderedCollection new) value
    ]

    addField: key value: anObject [
        ^(queryStringParts add: key->{anObject}) value
    ]

    addMarkerStyle: aMarker [
        aMarker color isNil ifFalse: [
            markers add: 'color:%1' %{aMarker color asString}].
        aMarker label isNil ifFalse: [
            markers add: '%<icon|label>1:%2' %{aMarker hasIcon. aMarker label asString}].
        aMarker shadow ifFalse: [
            markers add: 'shadow:false'].
        aMarker size = #default ifFalse: [
            markers add: 'size:%1' %{aMarker size asString}].
    ]

    visitMarker: aMarker [
        (lastMarker notNil and: [lastMarker hasSameStyleAs: aMarker])
            ifFalse: [lastMarker := aMarker. markers := nil].

        markers isNil ifTrue: [
            markers := self addField: 'markers'.
            self addMarkerStyle: aMarker ].

        markers add: aMarker position
    ]

    visitPath: aPath [
        | path |
        path := self addField: 'path'.
        aPath weight = 5 ifFalse: [
            path add: 'weight:%1' % {aPath weight}].
        aPath color isNil ifFalse: [
            path add: 'color:%1' % {aPath color}].
        aPath fillColor isNil ifFalse: [
            path add: 'fillcolor:%1' % {aPath fillColor}].
        aPath positionsDo: [ :each |
            path add: each displayString ]
    ]

    visitPosition: aMarker [
        visible isNil ifTrue: [visible := self addField: 'visible'].
        visible add: aMarker position
    ]

    visitMap: aMap [
        | size |
        queryStringParts := OrderedCollection new.
        aMap center isNil ifFalse: [
            self addField: 'center' value: aMap center displayString].
        (aMap center isNil and: [ aMap definesPosition not ]) ifTrue: [
            self addField: 'center' value: '0,0'].
        aMap zoom isNil ifFalse: [
            self addField: 'zoom' value: aMap zoom displayString].
        aMap mapType = #roadmap ifFalse: [
            self addField: 'maptype' value: aMap mapType asString].
        aMap format = #png ifFalse: [
            self addField: 'format' value: aMap format asString].
        aMap size isNil ifFalse: [
            size := aMap size asPoint.
            self addField: 'size' value: '%1x%2' % {size x. size y}].
        self addField: 'sensor' value: aMap sensor displayString.
        super visitMap: aMap
    ]
]

Map extend [
    staticMapUrl [
        "TODO: add caching?"
        ^StaticMapURLCreator new
            visit: self;
            url
    ]
]
