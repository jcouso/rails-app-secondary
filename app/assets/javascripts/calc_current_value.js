$(function() {
  $("[name='security[issue_date]']").on("change", function() {
    checkValuesPresence()
  });
  $("[name='security[maturity]']").on("change", function() {
    checkValuesPresence()
  });
  $("[name='security[quantity]']").on("change", function() {
    checkValuesPresence()
  });
  $("[name='security[unit_price]']").on("change", function() {
    checkValuesPresence()
  });
  $("[name='security[rate]']").on("change", function() {
    checkValuesPresence()
  });
  $("[name='security[indexer]']").on("change", function() {
    checkValuesPresence()
  });
});

function checkValuesPresence() {
  issue_date = $("[name='security[issue_date]']").val()
  maturity = $("[name='security[maturity]']").val()
  quantity = $("[name='security[quantity]']").val()
  unit_price = $("[name='security[unit_price]']").val()
  rate = $("[name='security[rate]']").val()
  indexer = $("[name='security[indexer]']").val()

  if (issue_date && maturity && quantity && unit_price && rate && indexer) {
    unit_price = $("[name='security[unit_price]']").maskMoney('unmasked')
    rate = $("[name='security[rate]']").maskMoney('unmasked')
    $.ajax('/securities/ajax_calculate', {
      method: 'GET',
      type: 'json',
      data: {
        issue_date: issue_date,
        maturity: maturity,
        quantity: quantity,
        unit_price: unit_price[0],
        rate: rate[0],
        indexer: indexer
      },
      success: function(data) {
        $('#security_current_value').val(data);
      }
    })
  }
}

