$(document).ready(function() {

  $('input.text.rounded').focus();

  Estimates.fetch();
  
  $('#q').example("Paradas de autobús cerca de...");
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
