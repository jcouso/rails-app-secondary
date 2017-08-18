$(document).ready(function() {

   $(".money").inputmask('decimal', {
                'alias': 'numeric',
                'groupSeparator': '.',
                'autoGroup': true,
                'digits': 2,
                'radixPoint': ",",
                'digitsOptional': false,
                'allowMinus': false,
                'prefix': "R$",
                'placeholder': ''
    });

  $(".percent").inputmask("decimal", {
    radixPoint: ",",
    groupSeparator: ".",
    autoGroup: true,
    suffix: "%",
    clearMaskOnLostFocus: false
});

});
