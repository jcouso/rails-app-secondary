//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require bootstrap-datepicker

$(document).ready(function() {
  $('.datepicker').datepicker({
      format: "yyyy/mm/dd",
      language: "pt",
      todayHighlight: true
  });
});
