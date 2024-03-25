<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Using data attr with Google Maps API v3 - example</title>
<script src="${pageContext.request.contextPath}/jquery-3.7.1.js"></script>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script>
<style>
.map{
		width: 700px;
    height: 400px;
    display: inline-block;
}
</style>
<script>
function initialize() {
    //get block using native js. we should write it into the variable to minimize memory
 //If we have few maps we should walk through the array of maps
  $(".map").each(function(){
    //get values of data attr.
     var data_lat = parseFloat($(this).data('lat')),
         data_lng= parseFloat($(this).data('lng')),
         data_title=$(this).data('title'),
         data_description=$(this).data('description'),
         data_zoom=$(this).data('zoom');
     var mapOptions = {
         //this centers the map on one point
         center: new google.maps.LatLng(data_lat, data_lng),
         //map zoom
       // 0 - minimum value - world map
       // 18 - max value - details
         zoom: data_zoom, 
         //type - 
       //1) ROADMAP - This is the default type. If you haven't chosen any of the types, this will be displayed. It shows the street view of the selected region.
       // 2) SATELLITE - This is the map type that shows the satellite images of the selected region.
       // 3) HYBRID -  This map type shows the major streets on satellite images.
       // 4) TERRAIN - This is the map type that shows the terrain and vegetation
         mapTypeId: google.maps.MapTypeId.ROADMAP
     };   
     //Initialize the map
     var map = new google.maps.Map(this,mapOptions);    
     var infoWindow = new google.maps.InfoWindow();      
     //variable for marker			  
			latLng = new google.maps.LatLng(data_lat, data_lng);
			// set markers for every value
			var marker = new google.maps.Marker({
				position: latLng,
				map: map,
				title: data_title
			});
			//Creating a closure to retain the correct data
			(function(marker, data) {
				// add click event
				google.maps.event.addListener(marker, "click", function(e){
					infoWindow.setContent(data_description);
					infoWindow.open(map, marker);
				});
			})(marker, this);
 });
}
google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body>
  <div id="container">	
	  <div class="map" data-lat="50.453242" data-lng="30.525513" data-title="Киев" data-description="столица Украины" data-zoom="5"></div>
    <div class="map" data-lat="49.990546" data-lng="36.231309" data-title="Харьков" data-description="первая столица Украины" data-zoom="7"></div>
  </div>
</body>
</html>