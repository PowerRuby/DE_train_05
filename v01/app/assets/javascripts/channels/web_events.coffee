App.web_events = App.cable.subscriptions.create "WebEventsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    request_selector = '#' + data['job_id'] + ' > td.request'
    status_selector  = '#' + data['job_id'] + ' > td.status'
    jobret_selector  = '#' + data['job_id'] + ' > td.jobret'
    request = $('#events').find(request_selector).html()
    if not request
      $('#events').append '<tr id="'                 + data['job_id']  + '">' +
               '<td class="request">'                + data['request'] + '</td>' +
               '<td class="status" align="center">'  + data['status']  + '</td>' +
               '<td class="jobret" align="center">'  + data['job_id']  + '</td></tr>'
    else
      $('#events').find(status_selector).html(data['status'])
      $('#events').find(jobret_selector).html(data['jobret'])

  sbmjob: (data) ->
    @perform 'sbmjob', command: data
