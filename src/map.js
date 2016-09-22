var Map = (function(){
    var globeSource = new ol.source.XYZ({
        url: 'tiles/globe/{z}/{x}/{y}.jpg',
        wrapX: true, minZoom: 0, maxZoom: 4,
        attributions: [
            'Map courtesy <a href="mailto:rich.ul-map@richwareham.com">Rich Wareham</a>.'
        ],
    });

    var globeLayer = new ol.layer.Tile({ source: globeSource });

    var coastlineSource = new ol.source.Vector({
        url: 'coastline.geojson',
        attributions: [
            'Made with <a href="http://www.naturalearthdata.com/">Natural Earth</a>.'
        ],
        format: new ol.format.GeoJSON(),
    });

    var coastlineLayer = new ol.layer.Vector({
        name: 'Modern coastline',
        source: coastlineSource,
        style: new ol.style.Style({
            stroke: new ol.style.Stroke({
                color: '#33CC99', width: 2,
            }),
        }),
    });

    var map = new ol.Map({
        target: 'map',
        layers: [globeLayer, coastlineLayer],
        view: new ol.View({
            center: ol.proj.fromLonLat([0, 0]),
            zoom: 2, maxZoom: 4,
        }),
    });

    return {
        coastlineLayer: coastlineLayer,
    };
})();
