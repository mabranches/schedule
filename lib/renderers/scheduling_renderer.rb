class SchedulingRenderer
  def initialize(scheduling, user, day, hour)
    @scheduling = scheduling
    @user = user
    @day = day
    @hour = hour
  end

  def render
    %Q[
      <td>
        <div data-scheduling-id="#{@scheduling.id}" data-day="#{@day}"
          data-hour="#{@hour}" id="#{@day}-#{@hour}" class="busy scheduling">
          #{close_button if @user.id == @scheduling.user_id}
          <span class="userName">#{@scheduling.user.name}</span>
        </div>
      </td>
    ]
  end

  private
    def close_button
      '<div class="cancel">
        <span  class="badge">x</span>
       </div>'
    end
end
