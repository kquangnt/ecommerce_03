$("#rating-form").raty({
  scoreName: "review[rating]",
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

$("input[name='number']").TouchSpin({
  verticalbuttons: true
});
