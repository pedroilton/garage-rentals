import mapboxgl from 'mapbox-gl';
// import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder'; -> insere pesquisa no mapa

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  // Fit map to markers
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((coord) => {
        const map = new mapboxgl.Map({
          container: 'map',
          style: 'mapbox://styles/mapbox/streets-v11',
          zoom: 11,
          center: [coord.coords.longitude, coord.coords.latitude]
        });
        // Adicionar marcadores:
        const markers = JSON.parse(mapElement.dataset.markers);
        markers.forEach((marker) => {
          new mapboxgl.Marker()
            .setLngLat([ marker.lng, marker.lat ])
            .addTo(map);
        });
      });
    }
    else {
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11'
      });
      // Adicionar marcadores:
      const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach((marker) => {
        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(map);
      });
      // Chama o fitMapToMarkers:
      fitMapToMarkers(map, markers);
    }
  }
};


  


export { initMapbox };