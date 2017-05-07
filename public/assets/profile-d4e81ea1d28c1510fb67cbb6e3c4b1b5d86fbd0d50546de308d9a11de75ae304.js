$(".ruleset-box").on('click', function() {
  if ($(this).find('input:checkbox').is(":checked")) {
    $(this).find('input:checkbox').prop("checked", false);
    $(this).css('background-color', 'transparent');
  }
  else {
    $(this).find('input:checkbox').prop("checked", true);
    $(this).css('background-color', '#6699ff');
  }
  console.log("Box checked/unchecked");
});


$('input[type=checkbox]').click(function(e) {
  e.stopPropagation();
});
