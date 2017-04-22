$("#contact").click(function() {
  $("#msgmodal").css("display", "block");
  $("textarea").val("Send new message..");
  console.log("lorem ipsum dolor sit amet");
});

$(".close").click(function() {
  $("#msgmodal").css("display", "none");
});
