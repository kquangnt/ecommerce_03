$("#rating-form").raty({
  scoreName: "rating[rating]",
  path: "/assets/"
});

$(".review-rating").raty({
  readOnly: true,
  score: function() {
    return $(this).attr("data-score");
  },
  path: "/assets/"
});

$(".average-review-rating").raty({
  readOnly: true,
  score: function() {
    return $(this).attr("data-score");
  },
  path: "/assets/"
});

$(".new_review").validate({
  errorPlacement: function (error, element) {
    error.insertAfter(element);
  },
  debug: true,
  rules: {
    "review[rating]": {required: true},
    "review[comment]": {required: true}
  },
  messages: {
    "review[comment]": {
      required: "You must type comment"
    }
  },
  onfocusout: function(element) {
    this.element(element);
  },
  submitHandler: function(form) {
    form.submit();
  }
});

$(document).ready(function(){
  $(".post-comment").click(function(){
    $(".revie-form").slideDown("slow");
  });
  $("#close").click(function(){
      $(".revie-form").slideUp("slow");
  });
});

$("input[name='number']").TouchSpin({
  verticalbuttons: true
});

$(check_is_processed).click(function(){

});
