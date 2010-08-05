Iliad.ILWidget subclass: ILIncrementalWidget [
    | updater |

    initialize [
        super initialize.
        self addDependentWidget: (updater := ILClientUpdater new).
        self append: updater
    ]

    pushScript: aString [
        updater addScript: aString
    ]

    beDirty [
        "Since the updater takes care of pushing the changes via Javascript,
         we do not need (and do not want) to rebuild the widget unless the
         page is being fetched completely.

         The updater is marked as dirty via the dependent widget mechanism."
        self request isTypeOfRequestForJson ifFalse: [ super beDirty ].
    ]

    forceRebuild [
        "Force a complete rebuild of the widget."
        super beDirty.
    ]

    build [
        "If we need to rebuild the entire widget, this is usually
         because another tab has been created for the same session.
         Force creation of a new state so that the state of the old tab
         is remembered separately."
        self forceRebuild.
        ^super build
    ]
]

Iliad.ILWidget subclass: ILClientUpdater [
    | pendingScripts updates stateMap |

    initialize [
        super initialize.
        pendingScripts := OrderedCollection new.
        updates := OrderedCollection new.
        stateMap := LookupTable new.
    ]

    addScript: aString [
        pendingScripts add: aString
    ]

    beDirty [
        "Small, probably useless optimization.  The widget is
         not really dirty if there are no new scripts."
        pendingScripts isNil ifTrue: [^self].
        super beDirty.

        "A new state is going to be created.  Consolidate all pending
         updates so that a single <script> tag will be pushed."
        updates addLast: (pendingScripts join: ';').
        pendingScripts := OrderedCollection new
    ]

    pushUpdates: e [
        | start state registry |
        start := 1.
        registry := self context previousStateRegistry.
        registry isNil ifFalse: [
            state := registry stateAt: self owner.
            state isNil ifFalse: [
                start := stateMap at: state ifAbsent: [start]]].

        stateMap at: self owner state put: updates size + 1.
        updates from: start to: updates size
            do: [ :each | e script: each ]
    ]

    contents [
        ^[:e | self pushUpdates: e]
    ]
]
