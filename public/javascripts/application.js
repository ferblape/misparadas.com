
$(document).ready(function() {

  $.Locations.bindings();
  
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
      var loc = $(this);
      $.get($(this).attr('data-expected-url'), function(data) {  
        for (var i in data) {
          loc.find('.expected').html(data[i]);  
        }
      }, 'json');
    });
  }
};
