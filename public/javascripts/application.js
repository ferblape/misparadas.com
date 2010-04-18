
$(document).ready(function() {

  $.Locations.bindings();
<<<<<<< HEAD:public/javascripts/application.js
  $('input.text.rounded').focus();

=======
  
  Estimates.fetch();
  
>>>>>>> e60b96e39b3e52cdf42af312c26e22988ea26442:public/javascripts/application.js
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
