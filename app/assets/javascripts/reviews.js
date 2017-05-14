$("#rating-form").raty({
  scoreName: "review1[rating1]",
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

$(".new_review1").validate({
  errorPlacement: function (error, element) {
    error.insertAfter(element);
  },
  debug: true,
  rules: {
    "review1[rating1]": {required: true},
    "review1[comment1]": {required: true}
  },
  messages: {
    "review1[comment1]": {
      required: "Please enter your comment!"
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
