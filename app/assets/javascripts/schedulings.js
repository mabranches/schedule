$(window).load(function(e) {
  function cancelchedulingClick(ev){
    var scheduling_cell = $(this).closest('.scheduling')
    var scheduling_id = parseInt(scheduling_cell.attr("data-scheduling-id"));
    cancelScheduling(this, scheduling_id);
  }

  function schedulingClick(ev){
    var scheduling_cell = $(this).closest('.scheduling')
    var day = scheduling_cell.attr("data-day");
    var hour = parseInt(scheduling_cell.attr("data-hour"));
    $(this).prop('disabled', true);
    createScheduling({scheduling : {day: day , hour: hour} }, this);
  }


 loadButtonLogic();
  function loadButtonLogic(){
    //function that schedule a room
    $("#tbl-selectRoom tbody td .btn.btn-success").off('click');
    $("#tbl-selectRoom tbody td .badge").off('click');
    $("#tbl-selectRoom tbody td .btn.btn-success").click(schedulingClick);

     //function that unschedule a room
    $("#tbl-selectRoom tbody td .badge").click(cancelchedulingClick);
    function createScheduling(scheduling, btn){
      var scheduling_cell = $(btn).closest('.scheduling')
        debugger;
      scheduleRoomService( this,'POST','schedulings', function(msg){
        scheduling_cell.attr("data-scheduling-id",msg["scheduling-id"]);
        scheduling_cell.append("<div class='cancel'><span class='badge'>x</span></div>");
        scheduling_cell.append("<span class='userName'>" + $("#user-name").text().trim() + "</span>");
        scheduling_cell.removeClass("available").addClass("busy").find("button").remove();
        loadButtonLogic();
      }, scheduling);
    }

    function cancelScheduling(btn,scheduling_id){
      var scheduling_cell = $(btn).closest('.scheduling')
      scheduleRoomService(this,'DELETE','schedulings/' + scheduling_id, function(msg){
        scheduling_cell.removeAttr("data-scheduling-id");
        scheduling_cell.removeClass("busy").addClass("available");
        scheduling_cell.find(".userName").remove();
        scheduling_cell.append("<button type='button' class='btn btn-success'>Agendar</button>");
        scheduling_cell.find('.cancel').remove();
        loadButtonLogic();
      });
    }

    function scheduleRoomService(btn, type, url, callback,scheduling){
      $.ajax({
        type: type,
        url: url,
        data: scheduling,
        success: function(msg){
          $(btn).prop('disabled', false);
          callback(msg);
        },
        error: function(msg){
          $(btn).prop('disabled', false);
        }
      });
    }
  }
});
