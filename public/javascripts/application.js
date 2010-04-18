

$(document).ready(function() {

  $.Locations.bindings();

});



$.Locations = {

  bindings: function() {
    // $('article.location form').hide();
    $('article.location').live('click', function() {
      $(this).find('form').submit(); 
      return false;
    })

  }

};
