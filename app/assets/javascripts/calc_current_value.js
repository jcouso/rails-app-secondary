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

Number.prototype.formatMoney = function(c, d, t){
var n = this,
    c = isNaN(c = Math.abs(c)) ? 2 : c,
    d = d == undefined ? "," : d,
    t = t == undefined ? "." : t,
    s = n < 0 ? "-" : "",
    i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };

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
        $('#security_current_value').val('R$ ' + data.formatMoney(2, '.', ','));
      }
    })
  }
}

