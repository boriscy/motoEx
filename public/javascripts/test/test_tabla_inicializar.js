$(document).ready(function(){
  module("Inicializar");

  test( "Eventos para tabs", function(){
      $('#lista_hojas a:eq(1)').trigger("click");
      equals( $('#lista_hojas a:eq(1)').hasClass("active"), true, "Deberia seleccionar tab");
  });
})
