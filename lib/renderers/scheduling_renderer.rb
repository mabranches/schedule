class SchedulingRenderer
  def initialize(scheduling, user)
    @scheduling = scheduling
    @user = user
  end

  def render
    %Q[
      <td class="busy">
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
