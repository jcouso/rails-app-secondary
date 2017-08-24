$(function() {
  $("[name='bid_calculation[mode]']").on("change", function() {
    if ($(this).val() == "price") {
      $(".rate-mode").addClass("hidden");
      $(".indexer-mode").addClass("hidden");
      $(".price-mode").removeClass("hidden");
      $("#bid_calculation_price").focus();
    } else {
      $(".rate-mode").removeClass("hidden");
      $(".indexer-mode").removeClass("hidden");
      $(".price-mode").addClass("hidden");
      $("#bid_calculation_rate").focus();
    }
  });
});
