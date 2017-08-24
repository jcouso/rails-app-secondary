$(document).ready(function() {

  $.fn.datepicker.dates['pt-BR'] = {
      days: ["Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sábado"],
      daysShort: ["Dom","Seg","Ter","Qua","Qui","Sex","Sáb"],
      daysMin: ["Dom","Seg","Ter","Qua","Qui","Sex","Sáb"],
      months: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
      monthsShort: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
      today: "Hoje",
      clear: "Fechar",
      format: "dd/mm/yyyy",
      titleFormat: "MM yyyy", /* Leverages same syntax as 'format' */
      weekStart: 0
  };

  $('.datepicker').datepicker({
      isRTL: false,
      format: "dd/mm/yyyy",
      language: "pt-BR",
      todayHighlight: true,
      autoclose: true,
      orientation: "bottom auto"
  });
});
