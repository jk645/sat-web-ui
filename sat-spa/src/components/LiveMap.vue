<script setup lang="ts">
import { onMounted, ref } from "vue";
import type { Ref } from "vue";
import leaflet from "leaflet";
import getAssets from "../helpers/get-assets";

let map: any;

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

const assetList: Ref<any> = ref([{id: 123}]);
getAssets()
  .then((result) => {
    assetList.value = result;

    // Add markers to the map.
    result.forEach((asset: any) => {
      leaflet.marker(asset.location).addTo(map);
    });
  })
  .catch();
</script>

<template>
  <div class="container mt-3">
    <div class="row">
      <div class="col-md-6 order-md-2">
        <div id="map" class="map"></div>
      </div>
      <div class="col-md-6 order-md-1 mt-4 mt-md-0">
        <div class="asset-list">
          <h1>Assets 1 - 3 of 3</h1>
          <div class="card mt-2" v-for="asset in assetList">
            <div class="card-body">
              <h5 class="card-title">Asset #{{ asset.id }}</h5>
            </div>
            <ul class="list-group list-group-flush">
              <li class="list-group-item">Heading: {{ asset.heading }}</li>
              <li class="list-group-item">Speed: {{ asset.speed }}</li>
            </ul>
            <div class="card-body">
              <a href="#" class="card-link">Go to</a>
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
