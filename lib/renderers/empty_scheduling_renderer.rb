class EmptySchedulingRenderer
  def initialize(day, hour)
    @day = day
    @hour = hour
  end

  def render
    %Q[<td data-day="#{@day}" data-hour="#{@hour}" id="#{@day}-#{@hour}" class="available">
      <button type="button" class="btn btn-success">
        Agendar
      </button>
    </td>]
  end
end
