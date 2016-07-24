class Map {
  static LONDON_COORDINATES = [51.505, -0.11];

  static MAPBOX_LINK = '<a href="https://www.mapbox.com/">Mapbox</a>';
  static OSM_LINK = '<a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>';

  static ICON_WORKED = { id: 'icon-lived', size: [20, 32] };
  static ICON_LIVED = { id: 'icon-worked', size: [25, 32] };

  constructor(mapID, token) {
    this._map = L.map(mapID, { zoomControl: false });
    this._token = token;
  }

  setup(markers, zoom = 2) {
    this._setupZoom(zoom);
    this._setupTiles();
    this._setupMarkers(markers);
  }

  _setupZoom(zoom) {
    L.control.zoom({ position: 'bottomright' }).addTo(this._map);
    this._map.setView(Map.LONDON_COORDINATES, zoom);
    this._map.scrollWheelZoom.disable();
  }

  _setupTiles() {
    let templateURL = 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={token}';

    let options = {
      id: 'mapbox/streets-v11',
      token: this._token,

      tileSize: 512,
      zoomOffset: -1,
      attribution: `Map data &copy; ${Map.OSM_LINK} contributors, Imagery &copy; ${Map.MAPBOX_LINK}`
    };

    L.tileLayer(templateURL, options).addTo(this._map);
  }

  _setupMarkers(markers) {
    markers.forEach(marker => {
      let placedMarker = L.marker(marker.coordinates, { icon: this._icon(marker.type) });
      placedMarker.bindPopup(marker.legend);
      placedMarker.addTo(this._map);
    });
  }

  _icon(markerType) {
    let icon = (markerType === 0) ? Map.ICON_WORKED : Map.ICON_LIVED;

    return L.divIcon({
      html: `<svg aria-hidden="true" class="${icon.id}"><use href="/images/symbol-defs.svg#${icon.id}"></use></svg>`,
      className: 'NOCLASS',
      iconSize: icon.size,
      iconAnchor: [5 + icon.size[0] / 2, icon.size[1]]
    });
  }
}
