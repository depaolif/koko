// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require_tree ./channels

$(document).ready(function() {
   $('#search-field').keydown(function() {
     var empty = false;
     if ($('#search-field').val().length == 0) {
       empty = true;
     }
     if (empty) {
       $('#search-submit').attr('disabled', 'disabled');
       $('#search-submit').removeAttr('class', 'pulse');
     } else {
       $('#search-submit').removeAttr('disabled');
       $('#search-submit').attr('class', 'pulse');
     }
   });
   $('#search-field-simple').keydown(function() {
    var empty = false;
    if ($('#search-field-simple').val().length == 0) {
      empty = true;
    }
    if (empty) {
      $('#search-submit-simple').attr('disabled', 'disabled');
      $('#search-submit').removeAttr('class', 'pulse');
    } else {
      $('#search-submit-simple').removeAttr('disabled');
      $('#search-submit-simple').attr('class', 'pulse');
    }
  });
   $('#search-field-2').keydown(function() {
    debugger
    var empty = false;
    if ($('#search-field-2').val().length == 0) {
      empty = true;
    }
    if (empty) {
      $('#search-submit-2').attr('disabled', 'disabled');
      $('#search-submit-2').removeAttr('class', 'pulse');
    } else {
      $('#search-submit-2').removeAttr('disabled');
      $('#search-submit-2').attr('class', 'pulse');
    }
  });
   $('#search-field-3').keydown(function() {
    var empty = false;
    if ($('#search-field-3').val().length == 0) {
      empty = true;
    }
    if (empty) {
      $('#search-submit-3').attr('disabled', 'disabled');
      $('#search-submit-3').removeAttr('class', 'pulse');
    } else {
      $('#search-submit-3').removeAttr('disabled');
      $('#search-submit-3').attr('class', 'pulse');
    }
  });
});