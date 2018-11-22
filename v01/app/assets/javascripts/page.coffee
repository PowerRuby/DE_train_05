$ ->
  $('#add_row_btn').click (event) ->
    App.web_events.sbmjob($('#command').val())
