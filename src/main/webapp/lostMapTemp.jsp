<!DOCTYPE html>
<html>
  <head>
    <title>Reverse Geocoding</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <style>
    /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
  height: 400px;
}

/* Optional: Makes the sample page fill the window. */
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
}

#floating-panel {
  position: absolute;
  top: 10px;
  left: 25%;
  z-index: 5;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
  text-align: center;
  font-family: "Roboto", "sans-serif";
  line-height: 30px;
  padding-left: 10px;
}

#floating-panel {
  position: absolute;
  top: 5px;
  left: 50%;
  margin-left: -180px;
  width: 350px;
  z-index: 5;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
}

#latlng {
  width: 225px;
}
    </style>
  </head>
  <body>
    <div id="floating-panel">
      <input id="latlng" type="text" value="35.1,126.8" />
      <input id="submit" type="button" value="Reverse Geocode" />
    </div>
    <div id="map"></div>
    <div id = "slot"></div>

    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyACh8pWLz6hMAzNdtVVUXqnXvqmoHvx5zI&callback=initMap&language=ko&v=weekly"
      async
    ></script>
    
    <script>
    function initMap() {
    	  const map = new google.maps.Map(document.getElementById("map"), {
    	    zoom: 8,
    	    center: { lat: 35.1, lng: 126.8 },
    	  });
    	  const geocoder = new google.maps.Geocoder();
    	  function infowindow(formatted_address){
    		  alert(formatted_address);
    	  };

    	  document.getElementById("submit").addEventListener("click", () => {
    	    geocodeLatLng(geocoder, map, infowindow);
    	  });
    	}

    	function geocodeLatLng(geocoder, map, infowindow) {
    	  const input = document.getElementById("latlng").value;
    	  const latlngStr = input.split(",", 2);
    	  const latlng = {
    	    lat: parseFloat(latlngStr[0]),
    	    lng: parseFloat(latlngStr[1]),
    	  };

    	  geocoder
    	    .geocode({ location: latlng })
    	    .then((response) => {
    	      if (response.results[0]) {

    	        const marker = new google.maps.Marker({
    	          position: latlng,
    	          map: map,
    	        });

    	        infowindow(response.results[0].formatted_address);
    	      } else {
    	        window.alert("No results found");
    	      }
    	    })
    	    .catch((e) => window.alert("Geocoder failed due to: " + e));
    	}
    </script>
  </body>
</html>