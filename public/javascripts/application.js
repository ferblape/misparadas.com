$(document).ready(function() {

  $.Locations.bindings();
  
  Estimates.fetch();
  
});



$.Locations = {

  bindings: function() {
    // $('article.location form').hide();
    $('article.location').live('click', function() {
      $(this).find('form').submit(); 
      return false;
    });

  }

};

var Estimates = {
  fetch: function() {
    $('div.location').each(function() {
      var id = $(this).attr('id').replace('_','s/');
      $.get('/' + id + '/arrivals', function(data) {  
        for (var i in data) {
          $('#estimate_route_' + i).html(data[i]);  
        }
      }, 'json');
    });
  }
};