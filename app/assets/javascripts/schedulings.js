function Getter(el){
  this.el = el;
}

Getter.prototype = {
  getDay: function(){return this.el.data("day");},
  getHour: function(){return this.el.data("hour");},
  getUserName: function(){return $("#user-name").text().trim();},
  getUserId: function(){return $("#user-id").text().trim();},
  getSchedulingId: function(){return this.el.data("scheduling-id")}
}

function register_click_common(btn, klass, callback){
  var schedulingCell = btn.closest('.scheduling')
  var getter = new Getter(schedulingCell);
  var day = getter.getDay();
  var hour = getter.getHour();
  var userName = getter.getUserName();
  var schedulingId = getter.getSchedulingId();
  callback(btn);
  obj = new klass(schedulingCell, day, hour, userName, btn, schedulingId);
  obj.action();
}

var EmptySchedulingEvents = {
  click: function(){
    register_click_common($(this), EmptyScheduling, function(btn){
      //btn.prop('disabled', true);
    });
  }
}

var SchedulingEvents = {
  click: function(){
    register_click_common($(this), Scheduling, function(){
    });
  }
}

var base_url = '/schedulings'
function EmptyScheduling(schedulingCell, day, hour, userName, btn){
  this.schedulingCell= schedulingCell;
  this.day = day;
  this.hour = hour;
  this.userName = userName;
  this.url = base_url;
  this.btn = btn;
};

EmptyScheduling.prototype = {
  method: 'POST' ,
  build: function (){
       scheduling_div = '<button type="button" class="btn btn-success">' +
                           'Agendar' +
                        '</button>'

      this.schedulingCell.removeClass("busy").addClass("available");
      this.schedulingCell.html(scheduling_div);
      this.schedulingCell.find('.btn-success').click(EmptySchedulingEvents.click);
  },

  action: function(){
    var s = this;
    var scheduling_data = { scheduling : {day: this.day , hour: this.hour} };
    $.ajax({
      type: this.method,
      url: this.url,
      data: scheduling_data,
      success: function(msg){
        var schedulingId = msg["scheduling-id"];
        scheduling = new Scheduling(s.schedulingCell, s.day, s.hour, s.userName,
                           s.btn, schedulingId);
        scheduling.build();
      },
      error: function(msg){
        s.btn.prop('disabled', false);
      }
    });
  }
}

function Scheduling(schedulingCell, day, hour, userName, btn, schedulingId) {
  this.schedulingCell = schedulingCell;
  this.day = day;
  this.hour = hour;
  this.userName = userName;
  this.btn = btn;
  this.id = schedulingId;
  this.url = base_url + '/' +schedulingId;
};

Scheduling.prototype = {
  method: 'DELETE' ,
  build: function (){
    var scheduling_div = '<div class="cancel">' +
                            '<span  class="badge">x</span>' +
                         '</div>' +
                         '<span class="userName">' + this.userName + '</span>';
    this.schedulingCell.data("scheduling-id", this.id);
    this.schedulingCell.removeClass("available").addClass("busy");
    this.schedulingCell.html(scheduling_div);
    this.schedulingCell.find('.badge').click(SchedulingEvents.click)

  },

  action: function(){
    var s = this;
    $.ajax({
      type: this.method,
      url: this.url,
      success: function(msg){
        emptyScheduling = new EmptyScheduling(s.schedulingCell, s.day, s.hour,
                                s.userName, s.btn);
        emptyScheduling.build();
      },
      error: function(msg){
      }
    });
  }
}

$("#tbl-selectRoom tbody td .btn.btn-success").click(EmptySchedulingEvents.click);
$("#tbl-selectRoom tbody td .badge").click(SchedulingEvents.click);

function same_user(data){
   userId = $("#user-id").text().trim();
   return data['user']['id'] == userId
}

function receive_common(data, receive_function){
  if (same_user(data))
    return;
  debugger;
  receive_function();
  return
}

CreateChannel.messages = CreateChannel.cable.
  subscriptions.create('CreatedSchedulingChannel', {
  received: function(data) {
    receive_common(data, function(){
      schdedulingCellId = '#' + data['scheduling']['day'] +
                            '-' +data['scheduling']['hour'];
      schedulingCell = $(schdedulingCellId);
      schedulingCell.html("<span class='userName'>" +
                            data['user']['name'] + "</span>");
    });
  }
});

CancelChannel.messages = CancelChannel.cable.
  subscriptions.create('CanceledSchedulingChannel', {
  received: function(data) {
    debugger;
    receive_common(data, function(){
      schdedulingCellId = '#' + data['scheduling']['day'] +
                            '-' +data['scheduling']['hour'];
      schedulingCell = $(schdedulingCellId);
      emptyScheduling = new EmptyScheduling(schedulingCell);
      emptyScheduling.build();
    })
  }
});
