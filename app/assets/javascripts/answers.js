$(document).ready(function(){
  var comment_id = document.getElementsByTagName("h6")[].getAttribute("class");
  $("#post-answer-" + comment_id).click(function(){

    $("#answer-form-" + comment_id).slideDown("slow");
  });
});
