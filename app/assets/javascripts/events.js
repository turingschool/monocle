$(document).ready(function(){
  $(".star").on("click", prepareStar);
  $(".unstar").on("click", prepareUnstar);
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
