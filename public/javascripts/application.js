$(document).ready(function() {

  $('input.text.rounded').focus();
  
  setTimeout(function() {
    Estimates.fetch();    
  }, 500);
  
  $('#q').example("Número de parada o dirección...");
});

var Estimates = {
  fetch: function() {
    $('section.location').each(function() {
      $.get($(this).attr('data-expected-url'), function(data) {  
        for (var i in data) {
          $('.estimate_route_' + i).html(data[i]);  
        }
      }, 'json');
    });
  }
};
