# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def google_map(lat, lng, opts = {})
    opts.reverse_merge!({
      :center => "#{lat},#{lng}",
      :zoom => "16",
      :markers => "size:small|color:black|#{lat},#{lng}",
      :size => "378x200",
      :sensor => "false"
    })
    (wd, ht) = opts[:size].split('x')
    image_tag("http://maps.google.com/maps/api/staticmap?" + opts.map{|k,v| k.to_s+"="+v}.join('&'),
      :width => wd, :height => ht)
  end

  def fifteen_minutes_of_fame
    [
      '<a href="http://fernando.blat.es/">Fernando Blat</a>',
      '<a href="http://samlown.com">Sam Lown</a>',
      '<a href="http://blog.duopixel.com/">Mark MacKay</a>',
      '<a href="http://42linesofcode.com/">Christos Zisopoulos</a>'
    ].sort_by{rand}.to_sentence(:last_word_connector => ' y ')
  end
end
