$(document).ready( function(){
  $(".star").on("click", prepareStar);
  $(".unstar").on("click", prepareUnstar);
  $(".size-check-box").on("click", function(){
    $.get('/companies')
  });
  $(".btn-remove").on("click", removeCompany);
  $(":checkbox").change(filterCompanies);
  $.when()
  .then(initMap)
  .then(
    $.get('/api/v1/companies')
    .then(addCards)
  ).then(centerMap)
});

function renderStar() {
  $('.starred-message').html('');
  $('.star-toggle').html('<span class="glyphicon glyphicon-star"></span> Star');
  $('.star-toggle').removeClass('unstar').addClass('star');
}

function renderUnstar() {
  $('.starred-message').html('<h4><i class="text-info"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> This company has been saved in your starred list.</i></h4>')
  $('.star-toggle').html('<span class="glyphicon glyphicon-star"></span> Unstar');
  $('.star-toggle').removeClass('star').addClass('unstar');
}

function prepareStar() {
  var companyId = $(this).data('id');
  $.ajax({
    url: "/starred_companies",
    method: "POST",
    data: { 'company_id':companyId }
  })
  .done(function(){
    $('.star').off();
  })
  .then(function(){
    renderUnstar();
  })
  .then(function(){
    $(".unstar").on("click", prepareUnstar);
  })
}

function prepareUnstar() {
  var companyId = $(this).data('id');
  $.ajax({
    url: "/starred_companies/" + companyId,
    method: "DELETE"
  })
  .done(function(){
   $(".unstar").off();
  })
  .then(function(){
    renderStar();
  })
  .then(function(){
    $(".star").on("click", prepareStar);
  })
}

function removeCompany() {
  var company = this.closest('.card-holder')
  var id = $(company).data('id')

  $.ajax({
    url: '/starred_companies/' + id,
    type: 'DELETE',
    success: function(){ company.remove() }
  })
}

function addCards(companies) {
  companies.forEach(function (company, index){
    placeMapMarker(company, index);
    var location = ''
    company['location'].forEach(function(line) {
      location = location + line + '<br>'
    });

    $('#companies-body').append(
      `<div class='card-holder col-xs-12 col-sm-6 col-md-4 col-lg-3 col-xl-2'>
          <div class='card'>
            <div class='logo'>
              <a href='/companies/${company["id"]}'>
                <img src=${company['logo']}>
              </a>
            </div>
            <div>
              <h4 class='company_name'>
                <a href='/companies/${company["id"]}'>${company.name}</a><br />
              </h4>
              <p>
                ${location}
                <a href='http://${company["website"]}' target='_blank'>
                  ${company['website']}
                </a>
              </p>
            </div>
          </div>
        </div>`
    )
  });
}

function removeCards() {
  $('#companies-body').empty();
}

function filterCompanies() {
  var filters = getFilters();
  $.when()
  .then(removeCards)
  .then(removeMapMarkers)
  .then(
    $.get('/api/v1/companies', filters)
    .then(addCards)
    .then(centerMap)
  );
}

function getFilters() {
  var filters = {
    company_size: [],
    industry_ids: []
  }

  $('#size-options :checked').each(function(index, checkbox) {
    filters['company_size'].push($(checkbox).val());
  });

  $('#industry-options :checked').each(function(index, checkbox) {
    filters['industry_ids'].push($(checkbox).val());
  });

  return filters;
}

function placeMapMarker(company, index) {
  this['infowindow' + index] = new google.maps.InfoWindow({
    content: company['name']
  });
  this['marker' + index] = new google.maps.Marker({
    position: JSON.parse(company['coordinates']),
    map: map,
    url: '/companies/' + company['id']
  });

  $(this['marker' + index]).hover(
      function() {
        this['infowindow' + index].open(map, this['marker' + index]);
      }, function() {
        this['infowindow' + index].close();
      }
  );

  $(this['marker' + index]).click(function(){
    window.location.href = '/companies/' + company['id'];
  });

  markers.push(this['marker' + index]);
  bounds.extend(this['marker' + index].getPosition());
}

function initMap() {
  markers = [],
  bounds = new google.maps.LatLngBounds();
  map = new google.maps.Map(document.getElementById('map'), {
  });
}

function removeMapMarkers() {
  markers.forEach(function(marker) {
    marker.setMap(null);
  });
  markers = [];
  bounds = new google.maps.LatLngBounds();
}

function centerMap() {
  map.setCenter(bounds.getCenter());
  map.fitBounds(bounds);
}
