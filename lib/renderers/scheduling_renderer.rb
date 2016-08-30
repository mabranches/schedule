class SchedulingRenderer
  include ActionView::Helpers::TagHelper
  def initialize(scheduling, user, day, hour)
    @scheduling = scheduling
    @user = user
    @day = day
    @hour = hour
  end

  def render
    name_html = content_tag(:span, @scheduling.user.name, class:'userName')
    icon_html = ( @user.id == @scheduling.user_id ) ? close_button : ''
    content_html = content_tag(
                                 :div, icon_html + name_html,
                                 'data-scheduling-id': @scheduling.id,
                                 'data-day': @day, 'data-hour': @hour,
                                 id: "#{@day}-#{@hour}",
                                 class: 'busy scheduling'
                              )

    content_tag(:td, content_html)
  end

  private
    def close_button
      icon_html = content_tag(:span, 'x', class:'badge')
      cancel_html = content_tag(:div, icon_html, class: 'cancel')
    end
end
