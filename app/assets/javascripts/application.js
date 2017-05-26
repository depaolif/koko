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

function searchPulse(field, submit) {
  $(`#${field}`).keydown(function() {
     var empty = false;
     if ($(`#${field}`).val().length == 0) {
       empty = true;
     }
     if (empty) {
       $(`#${submit}`).attr('disabled', 'disabled');
       $(`#${submit}`).removeAttr('class', 'pulse');
     } else {
       $(`#${submit}`).removeAttr('disabled');
       $(`#${submit}`).attr('class', 'pulse');
     }
  });
}

$(document).ready(function() {
  searchPulse('search-field', 'search-submit')
  searchPulse('search-field-2', 'search-submit-2')
  searchPulse('search-field-3', 'search-submit-3')
  searchPulse('search-field-simple', 'search-submit-simple')
});