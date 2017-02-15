$(document).ready(function(){
  if (pathFinder()[1] == 'notes' || pathFinder()[1] == 'companies') {
    displayNotes();
    $("#create-note-button").on('click', prepareNoteCreate);
  }

  $(".star").on("click", prepareStar);
  $(".unstar").on("click", prepareUnstar);
  $(".star-job").on("click", prepareJobStar);
  $(".unstar-job").on("click", prepareJobUnstar);
  $(".size-check-box").on("click", function(){
    $.get('/companies')
  });
  $(".btn-remove").on("click", removeCompany);
  $(".btn-remove-job").on("click", removeJob);
  $("div#industry-options :checkbox").change(filterCompanies);
  $("div#size-options :checkbox").change(toggleSizeSelect);
  $("#size-options").on('change', 'select#sizes', filterCompanies);
  $('div#within-distance :checkbox').change(toggleCompaniesWithinDistance);
  $('#filter-by-zip').on('click', validateZipThenFilter);
  $('#create-company').on('click', checkCompanyFields)

  $.when()
  .then(initMap)
  .then(
    $.get('/api/v1/companies')
    .then(addCards)
    .then(centerMap)
  )
});

function pathFinder() {
  return document.location.pathname.split('/');
}

function renderStar() {
  $('.starred-message').html('');
  $('.star-toggle').html('<span class="glyphicon glyphicon-star"></span> Favorite');
  $('.star-toggle').removeClass('unstar').addClass('star');
}

function renderUnstar() {
  $('.starred-message').html('<h4><i class="text-info"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> This company has been saved in your favorites list.</i></h4>')
  $('.star-toggle').html('<span class="glyphicon glyphicon-star"></span> Unfavorite');
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

function removeJob() {
  var job = this.closest('.job')
  var id = $(job).data('id')

  $.ajax({
    url: '/starred_jobs/' + id,
    type: 'DELETE',
    success: function(){ job.remove() }
  })
}

function prepareJobStar() {
  var jobId = $(this).data('id');
  $.ajax({
    url: "/starred_jobs",
    method: "POST",
    data: JSON.parse($('.job-data').text())
  })
  .done(function(){
    $('.star-job').off();
  })
  .then(function(){
    renderJobUnstar();
  })
  .then(function(){
    $(".unstar-job").on("click", prepareJobUnstar);
  })
}

function prepareJobUnstar() {
  var jobId = $(this).data('id');
  $.ajax({
    url: "/starred_jobs/" + jobId,
    method: "DELETE"
  })
  .done(function(){
   $(".unstar-job").off();
  })
  .then(function(){
    renderJobStar();
  })
  .then(function(){
    $(".star-job").on("click", prepareJobStar);
  })
}

function renderJobStar() {
  $('.starred-message').html('');
  $('.star-toggle').html('<span class="glyphicon glyphicon-star"></span> Favorite');
  $('.star-toggle').removeClass('unstar-job').addClass('star-job');
}

function renderJobUnstar() {
  $('.starred-message').html('<h4><i class="text-info"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> This job has been saved in your favorites list.</i></h4>')
  $('.star-toggle').html('<span class="glyphicon glyphicon-star"></span> Unfavorite');
  $('.star-toggle').removeClass('star-job').addClass('unstar-job');
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
  if (companies.length === 0) {
    appendNoCompaniesNotice();
  }
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

function appendNoCompaniesNotice() {
  $('#companies-body').prepend(`<h1 class='bg-danger text-center'>Looks like you've filtered yourself out of companies!</h1>`)
}

function toggleSizeSelect() {
  $('#sizes').toggle()
  if(!$(this).is(':checked')) {
    $('#sizes').val('All');
    filterCompanies();
  }
}

function removeCards() {
  $('#companies-body').empty();
}

function clearFields() {
  $("#create-note-title").val("")
  $("#create-note-body").val("")
}

function prepareNoteCreate(){
  var note = { title: $("#create-note-title").val(),
                body: $("#create-note-body").val(),
                status: $(':radio:checked').val()
              }

  return $.ajax({
    url: "/api/v1/notes",
    method: "POST",
    data: {note: note, company_ids: $("#create-note-company").val()}
  })
  .done(clearFields)
  .done(window.location.replace("/notes"))
}

function displayNotes(){
  var params = { company_id: pathFinder()[2] }
  $.ajax({
    url: "/api/v1/notes",
    method: "GET",
    type: "json",
    data: params
  })
  .then(createNotes)
}

function createNotes(raw) {
  for (var i = 0; i < raw.length; i++) {
    var note = new Note(
      raw[i].id,
      raw[i].author,
      raw[i].title,
      raw[i].body,
      raw[i].company_names,
      raw[i].status,
      raw[i].created_at
    );
    note.showNote($('#notes'));
    note.addNoteButtons($('.buttons'));
    note.bindNoteEvents();
  }
}

function toggleCompaniesWithinDistance() {
  $('#zip').toggle()
  if(!$(this).is(':checked')) {
    $('#zip_input').val('')
    filterCompanies();
  }
}

function validateZipThenFilter() {
  $('#zip-error').remove();
  var zip = getSearchZip();

  if (/^\d{5}(-\d{4})?$/.test(zip)) {
    filterCompanies();
  } else {
    $('#zip').append('<p id="zip-error" class="bg-danger">Please enter a valid zipcode</p>');
  }
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
    industry_ids: [],
    with_locations_near: []
  }
  var convertedSizes = convertCompanySize($('#sizes').val())
  var searchZip      = getSearchZip();
  var searchDistance = getSearchDistance();

  if (searchZip) {
    filters['with_locations_near'].push(searchZip);
    filters['with_locations_near'].push(searchDistance);
  }

  for (var i = 0; i < convertedSizes.length; i++) {
    filters['company_size'].push(convertedSizes[i]);
  }

  $('#industry-options :checked').each(function(index, checkbox) {
    filters['industry_ids'].push($(checkbox).val());
  });

  return filters;
}

function getSearchZip() {
  var zip = $('#zip_input').val();
  return zip;
}

function getSearchDistance() {
  var distance = $('#distance_select').val();
  return distance;
}

function convertCompanySize(dropdownValue) {
  var conversion = {
    "10"  : ["2-10"],
    "50"  : ["2-10","11-50"],
    "100" : ["11-50", "51-200"],
    "200" : ["11-50", "51-200"],
    "500" : ["11-50", "51-200", "201-500"],
    "All" : []
  }
  return conversion[dropdownValue];
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
  markers = [];
  bounds = new google.maps.LatLngBounds();
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 8,
    center: {lat: -39.8282, lng: 98.5795}
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
  if (markers.length === 0) {
    map.setCenter({lat: 39.8282, lng: -98.5795})
    map.setZoom(4)
  } else {
    map.setCenter(bounds.getCenter());
    map.fitBounds(bounds);
  }
}
