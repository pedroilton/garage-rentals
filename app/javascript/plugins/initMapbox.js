import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

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
          // Adiciona infoWindow
          const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
          // Altera o estilo do marker
          const element = document.createElement('div');
          element.className = 'marker';
          element.style.backgroundColor = '#ffc304';
          element.textContent = marker.content
          element.style.fontWeight = 'bold'
          element.style.borderRadius = '5px'
          element.style.borderWidth = '1px'
          element.style.borderColor = 'black'
          element.style.borderStyle = 'solid'
          element.style.padding = '1px 4px'
          new mapboxgl.Marker(element)
            .setLngLat([ marker.lng, marker.lat ])
            .setPopup(popup)
            .addTo(map);
        });
        map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
          mapboxgl: mapboxgl }));
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
        // Adiciona infoWindow
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
        // Altera o estilo do marker
        const element = document.createElement('div');
        element.className = 'marker';
        element.style.backgroundColor = '#ffc304';
        element.textContent = marker.content
        element.style.fontWeight = 'bold'
        element.style.borderRadius = '5px'
        element.style.borderWidth = '1px'
        element.style.borderColor = 'black'
        element.style.borderStyle = 'solid'
        element.style.padding = '1px 4px'
        new mapboxgl.Marker(element)
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup)
          .addTo(map);
      });
      map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl }));
      // Chama o fitMapToMarkers:
      fitMapToMarkers(map, markers);
    }
  }
};


  


export { initMapbox };