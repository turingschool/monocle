$(document).ready(function(){
  displayNotes();

  $("#create-note-button").on('click', function(){
    var newNoteTitle = $("#create-note-title");
    var newNoteBody = $("#create-note-body");
    var user_id = $('#create-note-button').data('userId')
    var company_id = $('#create-note-button').data('companyId')
    var note = { title: newNoteTitle.val(),
                         body: newNoteBody.val(),
                         user_id: user_id,
                         company_id: company_id}
    return $.ajax({
      url: "/companies/" + company_id + "/notes",
      method: "POST",
      data: {note: note}
    })
    .done(renderNote(note))/// dont call function
    .done(clearFields)
  });
});

function clearFields() {
  $("#create-note-title").val("")
  $("#create-note-body").val("")
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
  var username = $('#create-note-button').data('username')
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
        <h6>Author:  ${username}</h6>
        <h6>Title:  <span class="note-title" background-color:'white'>${note.title}</span></h6>
        <h6>Note:  <span class="note-body">${note.body}</span></h6>
        </div>
      </div>
    </div> `);
    bindNoteEvents(note)
  } else {
      $('#notes').append(
        `<div class='note-block panel panel-default'>
          <div class='panel-body small'>
            <div class='pull-left'>
              <h6>Author:  ${username}</h6>
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
