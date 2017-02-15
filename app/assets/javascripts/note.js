class Note {
  constructor(id, author, title, body, company_names, status, createdDate) {
    this.id = id;
    this.author = author;
    this.title = title;
    this.body = body;
    this.company_names = company_names;
    this.status = status;
    this.createdDate = new FormattedDate(createdDate).date;
  }

  showNote(htmlElement) {
    htmlElement.append(this.noteHTML());
  }

  noteHTML() {
    var html = `<tr id='note-${this.id}'> \'
                  <td><p>${this.company_names}</p></td> \
                  <td><p>${this.createdDate}</p></td> \
                  <td><p>${this.title}</p></td> \
                  <td><p>${this.body}</p></td> \
                  <td><p>${this.status}</p></td> \
                  <td class='buttons'></td>
                </tr>`;
    return html;
  }

  addNoteButtons(htmlElement) {
    htmlElement.html(this.noteButtons());
  }

  noteButtons() {
    var html = `<a class="edit-button btn btn-default btn-sm">Edit</span></a> \
                <a class="delete-button btn btn-default btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>`
    return html;
  }

  bindNoteEvents(){
    var self = this;
    $('#notes').on('click', `#note-${this.id} .buttons .delete-button`, function() {
        self.deleteNote();
      });
    $('#notes').on('click', `#note-${this.id} .buttons .edit-button`, function() {
      self.editEvent();
    });
  }

  editEvent(){
    var self = this;
    var $title = $(`#note-${this.id} td:nth-child(3) p`);
    var $body = $(`#note-${this.id} td:nth-child(4) p`);
    var $editButton = $(`#note-${this.id} .buttons .edit-button`);

    $editButton.html("Save");
    $(`#note-${this.id}`).addClass('edit-box');
    $title.attr('contenteditable', true).addClass('element-being-edited');
    $body.attr('contenteditable', true).addClass('element-being-edited');

    $('#notes').on('click', `#note-${this.id} .buttons .edit-button`, function() {
      self.updateNote($title, $body);
    });
  }

  updateNote($title, $body) {
    $.ajax ({
      url: `/api/v1/notes/${this.id}`,
      type: "PUT",
      data: { note: { title: $title.html(), body: $body.html() } }
    }).then(this.changeOnEdit())
  }

  changeOnEdit() {
    var $title = $(`#note-${this.id} td:nth-child(3) p`);
    var $body = $(`#note-${this.id} td:nth-child(4) p`);
    var $editButton = $(`#note-${this.id} .buttons .edit-button`);

    $editButton.html("Edit");
    $(`#note-${this.id}`).removeClass('edit-box');
    $title.attr('contenteditable', false).removeClass('element-being-edited');
    $body.attr('contenteditable', false).removeClass('element-being-edited');
  }

  deleteNote() {
      $.ajax ({
        url: `api/v1/notes/${this.id}`,
        type: "DELETE"
      }).then(this.removeNoteHTML())
  }

  removeNoteHTML() {
    $(`#note-${this.id}`).remove()
  }
}
