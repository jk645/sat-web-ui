<script setup lang="ts">
import { onMounted, ref } from "vue";
import type { Ref } from "vue";
import leaflet, { Map, Marker } from "leaflet";
import getAssets from "../helpers/get-assets";
import { Asset } from "../interfaces/asset";

let map: Map;

onMounted(() => {
  map = leaflet.map("map").setView({
    lng: -73.990200,
    lat: 40.706547
  }, 14);

  leaflet.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 19,
    attribution: "&copy; <a href=\"http://www.openstreetmap.org/copyright\">OpenStreetMap</a>"
  }).addTo(map);
});

const markerRefs: {[assetId: string]: Marker} = {};
const assetList: Ref<Asset[]> = ref([]);
getAssets()
  .then((result: Asset[]) => {
    assetList.value = result;

    // Init each to their opposite.
    let minLng = 180, maxLng = -180, minLat = 90, maxLat = -90;

    result.forEach((asset: Asset) => {
      // Figure out the bounds.
      minLng = Math.min(minLng, asset.location.lng);
      maxLng = Math.max(maxLng, asset.location.lng);
      minLat = Math.min(minLat, asset.location.lat);
      maxLat = Math.max(maxLat, asset.location.lat);

      // Add marker to the map.
      const marker = leaflet.marker(asset.location).addTo(map);
      marker.bindPopup(`
        <div class="h5">Asset #${asset.id}</div>
        <dl>
          <dt>Location (latitude, longitude)</dt>
          <dd>${asset.location.lat}, ${asset.location.lng}</dd>
          <dt>Heading</dt>
          <dd>${asset.heading}</dd>
          <dt>Speed</dt>
          <dd>${asset.speed}</dd>
        </dl>
      `);
      markerRefs[asset.id] = marker;
    });

    // Set view of map to encapsulate all assets.
    map.fitBounds([
      [minLat, minLng],
      [maxLat, maxLng]
    ]);
  })
  .catch();

  const showOnMap = (asset: Asset) => {
    const markerOfAsset = markerRefs[asset.id];
    map.setView({
      lng: asset.location.lng,
      lat: asset.location.lat
    });
    markerOfAsset.openPopup();
  };
</script>

<template>
  <div class="container mt-3">
    <div class="row">
      <div class="col-md-6 order-md-2">
        <div id="map" class="map"></div>
      </div>
      <div class="col-md-6 order-md-1 mt-4 mt-md-0">
        <div class="asset-list">
          <h1>All Assets</h1>
          <div class="card mt-2" v-for="asset in assetList">
            <div class="card-body">
              <h5 class="card-title">Asset #{{ asset.id }}</h5>
            </div>
            <ul class="list-group list-group-flush">
              <li class="list-group-item">Heading: {{ asset.heading }}</li>
              <li class="list-group-item">Speed: {{ asset.speed }}</li>
            </ul>
            <div class="card-body">
              <button type="button"
                class="btn btn-outline-dark"
                @click="showOnMap(asset)">
                Show on map
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
  .map, .asset-list {
    height: calc(100vh - 90px);
    max-height: 400px;
  }
  .asset-list {
    overflow-y: auto;
  }
</style>
