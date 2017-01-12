$(document).ready( function(){
  displayNotes();
  $("#create-note-button").on('click', prepareNoteCreate);
  $(".star").on("click", prepareStar);
  $(".unstar").on("click", prepareUnstar);
  $(".star-job").on("click", prepareJobStar);
  $(".unstar-job").on("click", prepareJobUnstar);
  $(".size-check-box").on("click", function(){
    $.get('/companies')
  });
  $(".btn-remove").on("click", removeCompany);
  $(".btn-remove-job").on("click", removeJob);
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
  $('.star-toggle').html('<span class="glyphicon glyphicon-star"></span> Star');
  $('.star-toggle').removeClass('unstar-job').addClass('star-job');
}

function renderJobUnstar() {
  $('.starred-message').html('<h4><i class="text-info"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> This job has been saved in your starred list.</i></h4>')
  $('.star-toggle').html('<span class="glyphicon glyphicon-star"></span> Unstar');
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



function clearFields() {
  $("#create-note-title").val("")
  $("#create-note-body").val("")
}

function prepareNoteCreate(){
    var newNoteTitle = $("#create-note-title");
    var newNoteBody = $("#create-note-body");
    var user_id = $('#create-note-button').data('userId')
    var company_id = $('#create-note-button').data('companyId')
    var author = $('#create-note-button').data('username')
    var note = { title: newNoteTitle.val(),
                         body: newNoteBody.val(),
                         user_id: user_id,
                         author: author,
                         company_id: company_id}
    return $.ajax({
      url: "/companies/" + company_id + "/notes",
      method: "POST",
      data: {note: note}
    })
    .done(renderNote)
    .done(clearFields)
}

function displayNotes(){
  var company_id = $('#create-note-button').data('companyId')
  $.ajax({
    url: "/api/v1/notes",
    method: "GET",
    data: {id: company_id},
    type: "json"
  })
  .then(function(rawNotes){
    rawNotes.forEach(renderNote);
  })
}

function renderNote(note){
  var author = note.author
  var userId = $('#create-note-button').data('userId')
  var company_id = $('#create-note-button').data('companyId')
  if (userId == note.user_id) {
  $('#notes').append(
      `<div class='note-block panel panel-default' id="note-${note.id}">
      <div class='panel-body small'>
      <div class='btn-group pull-right'>
      <a class="edit-button btn btn-default btn-sm">Edit</span></a>
       <a class="delete-button btn btn-default btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
       </div>
        <div class='pull-left'>
        <h6>Author:  ${author}</h6>
        <h6>Title:  <span class="note-title" style="background-color:#fff">${note.title}</span></h6>
        <h6>Note:  <span class="note-body" style="background-color:#fff">${note.body}</span></h6>
        </div>
      </div>
    </div> `);
    bindNoteEvents(note)
  } else {
      $('#notes').append(
        `<div class='note-block panel panel-default'>
          <div class='panel-body small'>
            <div class='pull-left'>
              <h6>Author:  ${author}</h6>
              <h6>Title:  ${note.title}</h6>
              <h6>Note:  ${note.body}</h6>
            </div>
          </div>
        </div> `
    )}
}

function editEvent(note){
  $(`#note-${note.id} .edit-button`).on('click', function(){

    $(`#note-${note.id}`).addClass('edit-box')
    $(`#note-${note.id}`).find('.note-title').attr('contenteditable', true)
    $(`#note-${note.id}`).find('.note-body').attr('contenteditable', true)
    $.when(
      $(`#note-${note.id} .edit-button`).text('Submit changes')
    ).then(
      $(`#note-${note.id} .edit-button`).off()
    ).then(
      $(`#note-${note.id} .edit-button`).on('click', function () {submitChanges(note)})
    )
  })
};

function submitChanges(note){
  var id = note.id
  var user_id = $('#create-note-button').data('userId')
  var title = $(`#note-${note.id}`).find('.note-title').text();
  var body = $(`#note-${note.id}`).find('.note-body').text();
  var company_id = $('#create-note-button').data('companyId')
  var noteUpdate = { title: title,
                       body: body,
                       user_id: user_id,
                       company_id: company_id}
  $.ajax({
    url: `/companies/${company_id}/notes/${id}`,
    type: "PUT",
    data: {note: noteUpdate}
  }).then(
    $(`#note-${id}`).removeClass('edit-box')
  ).then(
    $(`#note-${id} .edit-button`).off()
  ).then(
    $(`#note-${id} .edit-button`).text('Edit')
  ).then(
    $(`#note-${id} .edit-button`).on('click', editEvent(note))
  )
}

function bindNoteEvents(note){
  $(`#note-${note.id} .delete-button`).on('click', function(){deleteNote(note)})
  $(`#note-${note.id} .edit-button`).on('click', editEvent(note))
}

function deleteNote(note) {
  var company_id = $('#create-note-button').data('companyId')
  var id = note.id
    $.ajax ({
      url: `/companies/${company_id}/notes/${id}`,
      type: "DELETE"
    }).then(removeNoteHTML(note))
}

function removeNoteHTML(note) {
  $(`#note-${note.id}`).remove()

}
