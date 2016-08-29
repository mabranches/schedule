// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the rails generate channel command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.CreateChannel || (this.CreateChannel = {});
  this.CancelChannel || (this.CancelChannel = {});

  CreateChannel.cable = ActionCable.createConsumer();
  CancelChannel.cable = ActionCable.createConsumer();

}).call(this);
