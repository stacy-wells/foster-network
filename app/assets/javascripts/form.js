$(document).ready(function(){
  $('form #additional').hide();

  $('#user_rescue_group_false').on('click', function(){
    $('form #additional').show();
  });

  $('#user_rescue_group_true').on('click', function(){
    $('form #additional').hide();
  });
});
