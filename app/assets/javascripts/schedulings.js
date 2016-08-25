$(window).load(function(e) {
  $("#tbl-selectRoom tbody td .btn.btn-success").click(schedulingClick);
  $("#tbl-selectRoom tbody td .badge").click(cancelchedulingClick);
});

  function cancelchedulingClick(ev){
    var scheduling_cell = $(this).closest('.scheduling')
    cancelScheduling(scheduling_cell, this);
  }

  function schedulingClick(ev){
    var scheduling_cell = $(this).closest('.scheduling')
    $(this).prop('disabled', true);
    createScheduling(scheduling_cell, this);
  }

  //TODO use handlebars
  function createScheduling(scheduling_cell, btn){
    var day = scheduling_cell.data("day");
    var hour = scheduling_cell.data("hour");
    var scheduling = {scheduling : {day: day , hour: hour} }
    var userName = $("#user-name").text().trim();

    scheduleRoomService(btn, 'POST', 'schedulings', function(msg){
      var scheduling_id = msg["scheduling-id"];
      var scheduling_div = '<div class="cancel">' +
                              '<span  class="badge">x</span>' +
                           '</div>' +
                           '<span class="userName">' + userName + '</span>';
        scheduling_cell.data("scheduling-id", scheduling_id);
        scheduling_cell.removeClass("available").addClass("busy");
        scheduling_cell.html(scheduling_div);
        scheduling_cell.find('.badge').click(cancelchedulingClick)
      }, scheduling);
    }

    //TODO use handlebars
    function cancelScheduling(scheduling_cell, btn){
      var scheduling_id = scheduling_cell.data("scheduling-id");
      var day = scheduling_cell.data("day");
      var hour = scheduling_cell.data("hour");
      scheduleRoomService(btn,'DELETE','schedulings/' + scheduling_id, function(msg){
        scheduling_div = '<div data-day="' + day  + '" data-hour="' + hour  + '" id="' +
           day + '-' + hour + '" class="available scheduling">' +
          '<button type="button" class="btn btn-success">' +
            'Agendar'
          '</button>'
        '</div>'

        scheduling_cell.removeClass("busy").addClass("available");
        scheduling_cell.html(scheduling_div);
        scheduling_cell.find('.btn-success').click(schedulingClick);
      });
    }

    function scheduleRoomService(btn, type, url, callback,scheduling){
      $.ajax({
        type: type,
        url: url,
        data: scheduling,
        success: function(msg){
          callback(msg);
        },
        error: function(msg){
          $(btn).prop('disabled', false);
        }
      });
    }

