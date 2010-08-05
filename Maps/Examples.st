Map extend [

    Map class >> example1 [
        ^self new
            center: 'Brooklyn Bridge New York NY';
            zoom: 14;
            size: 512;
            add: (MapMarker new label: 'S'; color: #blue; position: '40.702147,-74.015794');
            add: (MapMarker new label: 'G'; color: #green; position: '40.711614,-74.012318');
            add: (MapMarker new label: 'C'; color: #red; position: '40.718217,-73.998284');
            yourself
    ]

    Map class >> example2 [
        ^self new
            center: '51.477222,0';
            zoom: 14;
            size: 400;
            yourself
    ]

    Map class >> example3 [
        ^self new
            center: 'Berkeley,CA';
            zoom: 14;
            size: 400;
            yourself
    ]

    Map class >> example4 [
        ^self new
            center: '40.714728,-73.998672';
            zoom: 12;
            size: 400;
            yourself
    ]

    Map class >> example5 [
        ^self new
            center: '40.714728,-73.998672';
            zoom: 14;
            size: 400;
            yourself
    ]

    Map class >> example6 [
        ^self new
            center: '40.714728,-73.998672';
            zoom: 14;
            size: 400;
            yourself
    ]

    Map class >> example7 [
        ^self new
            zoom: 1;
            size: 400@50;
            yourself
    ]

    Map class >> example8 [
        ^self new
            zoom: 1;
            size: 100;
            yourself
    ]

    Map class >> example10 [
        ^self new
            center: '40.714728,-73.998672';
            mapType: #terrain;
            zoom: 12;
            size: 400;
            yourself
    ]

    Map class >> example11 [
        ^self new
            center: '40.714728,-73.998672';
            mapType: #satellite;
            zoom: 12;
            size: 400;
            yourself
    ]

    Map class >> example12 [
        ^self new
            center: '40.714728,-73.998672';
            mapType: #hybrid;
            zoom: 12;
            size: 400;
            yourself
    ]

    Map class >> example13 [
        | style |
        style := MapMarker new label: 'S'; color: #blue; yourself.
        ^self new
            center: 'Williamsburg,Brooklyn,NY';
            zoom: 13;
            size: 400;
            add: (style copy position: '11211');
            add: (style copy position: '11206');
            add: (style copy position: '11222');
            yourself
    ]

    Map class >> example14 [
        ^self new
            center: '63.259591,-144.667969';
            zoom: 6;
            size: 400;
            add: (MapMarker new color: #blue; label: 'S'; position: '62.107733,-145.541936');
            add: (MapMarker new color: #green; size: #tiny; position: 'Delta Junktion,AK');
            add: (MapMarker new color: '0xFFFF00'; size: #mid; label: 'C'; position: 'Tok,AK');
            yourself
    ]

    Map class >> example15 [
        | style |
        "### TODO: double encode automatically?"
        style := MapMarker new label: 'http://chart.apis.google.com/chart?chst=d_map_pin_icon&chld=cafe%7C996600'; yourself.
        ^self new
            size: 480;
            add: (style copy position: '224 West 20th Street');
            add: (style copy position: '75 9th Ave');
            add: (style copy position: '700 E 9th St');
            yourself
    ]

    Map class >> example16 [
        | path |
        path := MapPath new
            color: '0x0000ff';
            add: '40.737102,-73.990318';
            add: '40.749825,-73.987963';
            add: '40.752946,-73.987384';
            add: '40.755823,-73.986397';
            yourself.

        ^self new
            size: 512;
            add: path;
            yourself
    ]

    Map class >> example17 [
        | path |
        path := MapPath new
            color: '0xff0000ff';
            add: '40.737102,-73.990318';
            add: '40.749825,-73.987963';
            add: '40.752946,-73.987384';
            add: '40.755823,-73.986397';
            yourself.

        ^self new
            size: 512;
            add: path;
            yourself
    ]

    Map class >> example18 [
        | path |
        path := MapPath new
            color: '0x00000000';
            fillColor: '0xFFFF0033';
            add: '8th Avenue & 34th St,New York,NY';
            add: '8th Avenue & 42th St,New York,NY';
            add: 'Park Ave & 42th St,New York,NY';
            add: 'Park Ave & 32th St,New York,NY';
            yourself.

        ^self new
            size: 512;
            add: path;
            yourself
    ]

    Map class >> example21 [
        ^self new
            size: 512;
            center: 'Boston, MA';
            add: (MapPosition new position: '77 Massachusetts Ave,Cambridge,MA');
            add: (MapPosition new position: 'Harvard Square,Cambridge,MA');
            yourself
    ]

    Map class >> example22 [
        | style |
        style := MapMarker new size: #mid; color: #red; yourself.
        ^self new
            size: 512;
            add: (style copy position: 'San Francisco,CA');
            add: (style copy position: 'Oakland,CA');
            add: (style copy position: 'San Jose,CA');
            yourself
    ]
]
