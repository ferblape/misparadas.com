# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def button_tag(text, options = { })
    content_tag(:div, 
      content_tag(:button,
        content_tag(:span, 
          content_tag(:span,
            text,
          :class => 'inside'),
        :class => 'outside'),
      options),
      :class => 'buttonWrap'
    )
  end

end
