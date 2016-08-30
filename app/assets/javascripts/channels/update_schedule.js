function same_user(data){
   userId = $("#user-id").text().trim();
   return data['user']['id'] == userId
}

function receive_common(data, receive_function){
  if (same_user(data))
    return;
  schdedulingCellId = '#' + data['day'] +
                        '-' +data['hour'];
  schedulingCell = $(schdedulingCellId);
  receive_function(schedulingCell);
  return
}

CreateChannel.messages = CreateChannel.cable.
  subscriptions.create('CreatedSchedulingChannel', {
  received: function(data) {
    receive_common(data, function(schedulingCell){
      schedulingCell.html("<span class='userName'>" +
                            data['user']['name'] + "</span>");
    });
  }
});

CancelChannel.messages = CancelChannel.cable.
  subscriptions.create('CanceledSchedulingChannel', {
  received: function(data) {
    receive_common(data, function(schedulingCell){
      emptyScheduling = new EmptyScheduling(schedulingCell);
      emptyScheduling.build();
    })
  }
});
