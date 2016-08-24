class SchedulingRenderer
  def initialize(scheduling, user, day, hour)
    @scheduling = scheduling
    @user = user
    @day = day
    @hour = hour
  end

  def render
    %Q[
      <td data-scheduling-id="#{@scheduling.id}" data-day="#{@day}"
        data-hour="#{@hour}" id="#{@day}-#{@hour}" class="busy">
        #{close_button if @user.id = @scheduling.user_id}
        <span class="userName">#{@scheduling.user.name}</span>
      </td>
    ]
  end

  private
    def close_button
      '<div class="unselect">
        <span  class="badge">x</span>
       </div>'
    end
end
