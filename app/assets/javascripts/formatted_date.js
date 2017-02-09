class FormattedDate {
  constructor(date) {
    this.date = this.formatDate(date)
  }

  formatDate(date){
    var date = new Date(date)
    var dd = date.getDate();
    var mm = date.getMonth()+1;
    var yyyy = date.getFullYear();

    if(dd < 10) {
      dd = '0' + dd;
    }

    if(mm < 10) {
      mm = '0' + mm;
    }

    var today = mm + '/' + dd + '/' + yyyy;
    return today;
  }
}
