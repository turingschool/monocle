function initCompanyMap() {

  var companyId = $('#company-id').data('companyId');

  var coordinates = getCoordinates();

  var map = new google.maps.Map(document.getElementById('company-map'), {
      center: new google.maps.LatLng(39.742043, -104.991531),
      zoom: 12
    });

  var bounds = new google.maps.LatLngBounds();

  coordinates.forEach(function(coordinate){
    if (coordinate !== undefined) {
      var latLng = new google.maps.LatLng(coordinate.lat, coordinate.lng),
          marker = new google.maps.Marker({
        position: latLng,
        map: map
      });
      bounds.extend(latLng);
    }

    if (bounds.getNorthEast().equals(bounds.getSouthWest())) {
       var extendPoint1 = new google.maps.LatLng(bounds.getNorthEast().lat() + 0.01, bounds.getNorthEast().lng() + 0.01);
       var extendPoint2 = new google.maps.LatLng(bounds.getNorthEast().lat() - 0.01, bounds.getNorthEast().lng() - 0.01);
       bounds.extend(extendPoint1);
       bounds.extend(extendPoint2);
    }

    map.fitBounds(bounds);
  });
}

function getCoordinates() {
  var companyId = $('#company-id').data('companyId');

  var locations = $.parseJSON($.ajax({
    url: `/api/v1/companies/${companyId}/locations`,
    method: "GET",
    data: {'company_id': companyId},
    type: "json",
    async: false
  }).responseText);
  return extractCoordinates(locations);
}

function extractCoordinates(locations) {
  var coordinates = locations.map(function(location){
    if (location.status === "approved") {
      return JSON.parse(location.coordinates)
    }
  })
  return coordinates;
}
