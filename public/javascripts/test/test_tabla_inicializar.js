$(document).ready(function(){
  module("Inicializar");

  test("Creación de ", function() {
    equals( $("#sheet-0-content tr:first th").length, $("#sheet-0-cols table tr:first th").length, "Deben copiar cabecera");
    // Anchos
    $("#sheet-0-content tr:first th").each(function(i, el) {
      equals( $(el).width(), $("#sheet-0-cols tr:first th:eq("+i+")").width(), "ancho: "+i);
    });
    // Altos
    $("#sheet-0-content tr:not(:first) th").each(function(i, el) {
      equals( $(el).height(), $("#sheet-0-rows th:eq("+ i +")").height(), "alto: "+i);
    });
  });

  test( "Eventos para tabs", function(){
      expect(3);
      $('#lista_hojas a:eq(1)').trigger("click");
      equals( $('#lista_hojas a:eq(1)').hasClass("active"), true, "Deberia seleccionar tab");
      equals( $('#lista_hojas a:not(:eq(1))').find(".active").length, 0, "Solo debe estar el segundo tab seleccionado");
      ok( $("#sheet-1").hasClass("visible"), "Clase activada para hoja seleccionada")
  });

});
