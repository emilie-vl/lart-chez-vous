import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
    });

    this.#addMarkerToMap();
    this.#fitMapToMarker();
  }

  #addMarkerToMap() {

      const popup = new mapboxgl.Popup({
        maxWidth: "400px",
        closeButton: true,
      });

      new mapboxgl.Marker()
        .setLngLat([this.markerValue.lng, this.markerValue.lat])
        .setPopup(
          popup.on("open", () => {
            fetch(`/users/${marker.user_id}/info_window`)
              .then((response) => response.text())
              .then((html) => popup.setHTML(html));
          })
        )
        .addTo(this.map);

  }

  #fitMapToMarker() {
    const bounds = new mapboxgl.LngLatBounds();

      bounds.extend([this.markerValue.lng, this.markerValue.lat]);

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
