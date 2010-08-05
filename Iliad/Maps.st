ILWidget subclass: StaticMapWidget [
    | map |
    contents [
        ^[:e | map isNil ifFalse: [e img: map staticMapUrl]]
    ]

    map [
        ^map
    ]

    map: aMap [
        map := aMap
    ]
]
