$(function() {
  function buildHTML(message) {
    var avatar = '<image src="'+ message.avatar.url +'">'
    var body = $('<p class ="chat-message__body">').append(message.body).append("<br/>").append(avatar);
    var name = $('<p class ="chat-message__header__name">').append(message.name);
    var time = $('<p class ="chat-message__header__time">').append(message.time);
    var header = $('<div class ="chat-message__header">').append(name).append(time);
    var html = $('<li class ="chat-message">').append(header).append(body);
    return html;
  };

  $('.chat-footer').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_body');
    var body = textField.val();
    var fileField = $('#message_avatar');
    var avatar = fileField.val();
    $.ajax({
      type: form.attr('method'),
      url: form.attr('action'),
      data: new FormData($(".new_message")[0]),
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data.message);
      chat_messages = $('.chat-messages').append(html);
      textfield = textField.val('');
    })
    .fail(function(data) {
      alert('please create again');
    });
    return false;
  });
});
