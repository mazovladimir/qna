# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready2 = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId')
    $('form#edit-question-' + question_id).show()

$(document).ready(ready2) # "вешаем" функцию ready на событие document.ready
$(document).on('page:load', ready2)  # "вешаем" функцию ready на событие page:load
$(document).on('page:update', ready2) # "вешаем" функцию ready на событие page:update

