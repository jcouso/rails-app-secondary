$(function() {
  $("[name='bid_calculation[mode]']").on("change", function() {
    if ($(this).val() == "price") {
      $(".rate-mode").addClass("hidden");
      $(".price-mode").removeClass("hidden");
      $("#bid_calculation_price").focus();
    } else {
      $(".rate-mode").removeClass("hidden");
      $(".price-mode").addClass("hidden");
      $("#bid_calculation_rate_in_percent").focus();
    }
  });
});
