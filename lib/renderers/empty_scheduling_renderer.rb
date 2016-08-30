class EmptySchedulingRenderer
  include ActionView::Helpers::TagHelper
  def initialize(day, hour)
    @day = day
    @hour = hour
  end

  def render
    button_html = content_tag(:button, 'Agendar', class: 'btn btn-sucess')
    div_html = content_tag(:div, button_html, 'data-day':@day,
                            'data-hour': @hour, id:"#{@day}-#{@hour}",
                            class:'available scheduling')
    content_tag(:td, div_html)
  end
end
