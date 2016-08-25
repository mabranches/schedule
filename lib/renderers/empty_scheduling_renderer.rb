class EmptySchedulingRenderer
  def initialize(day, hour)
    @day = day
    @hour = hour
  end

  def render
    %Q[
      <td>
        <div data-day="#{@day}" data-hour="#{@hour}" id="#{@day}-#{@hour}" class="available scheduling">
          <button type="button" class="btn btn-success">
            Agendar
          </button>
        </div>
    </td>]
  end
end
