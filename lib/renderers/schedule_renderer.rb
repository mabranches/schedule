class ScheduleRenderer
  def initialize(schedulings, user)
    @user = user
    @days = {}

    schedulings.each do |s|
      @days[s.day.to_time.to_i] ||= {}
      @days[s.day.to_time.to_i][s.hour] = s
    end
  end


  def render
    monday = DateUtils.this_monday
    friday = DateUtils.this_friday
    schedule_r = ''
    (CONFIG['hour']['start']..CONFIG['hour']['end']).each do |hour|
      schedule_r << '<tr>'
      schedule_r << "<td>#{hour.to_s.rjust(2,'0')}:00</td>"
      (monday..friday).each do |day|
        schedule_r << render_scheduling(@days.dig(day.to_time.to_i, hour), day, hour)
      end
      schedule_r << '</tr>'
    end
    schedule_r.html_safe
  end

  private
    def render_scheduling(scheduling, day, hour)
      if scheduling
        SchedulingRenderer.new(scheduling, @user, day, hour).render
      else
        EmptySchedulingRenderer.new(day, hour).render
      end
    end
end
