$(document).on('turbolinks:load', function() {
  var publisher, session, publisherOptions;
  if ($('#publisher').length) {
    session = TB.initSession(gon.opentok.sessionId);
    publisherOptions = {
      name: gon.opentok.email
    };

    publisher = TB.initPublisher(gon.opentok.apiKey, 'publisher', publisherOptions);
    session.on({
      sessionConnected: function(event) {
        if (session.capabilities.publish === 1) {
          return session.publish(publisher);
        }
      }
    });

    session.on({
      streamCreated: function(event) {
        var html =
          '<tr id="' +
          event.stream.streamId +
          '">' +
          '<td>' +
          event.stream.name +
          '</td>' +
          '<td></td></tr>';
        $("#streams").append(html);
        return session.subscribe(event.stream, $('#' + event.stream.streamId + ' td')[1]);
      }
    });

    session.on({
      streamDestroyed: function (event) {
        $('#' + event.stream.streamId).remove();
      }
    });

    return session.connect(gon.opentok.apiKey, gon.opentok.token);
  }
});