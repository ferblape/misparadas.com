
$(document).ready(function() {

  $.Locations.bindings();
  $('input.text.rounded').focus();
  Estimates.fetch();
});



$.Locations = {

  bindings: function() {
    // $('article.location form').hide();
    $('.locations.index article.location').live('click', function() {
      $(this).find('form').submit(); 
      return false;
    });
  }

};

var Estimates = {
  fetch: function() {
    $('article.location').each(function() {
      $.get($(this).attr('data-expected-url'), function(data) {  
        for (var i in data) {
          $('#estimate_route_' + i).html(data[i]);  
        }
      }, 'json');
    });
  }
};
