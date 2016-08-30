function same_user(data){
   userId = $("#user-id").text().trim();
   return data['user']['id'] == userId
}

function receive_common(data, receive_function){
  if (same_user(data))
    return;
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
    receive_common(data, function(){
      schdedulingCellId = '#' + data['scheduling']['day'] +
                            '-' +data['scheduling']['hour'];
      schedulingCell = $(schdedulingCellId);
      emptyScheduling = new EmptyScheduling(schedulingCell);
      emptyScheduling.build();
    })
  }
});
