

$(document).ready(function() {

  $.Locations.bindings();
  $('input.text.rounded').focus();

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
