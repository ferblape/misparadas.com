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

end
