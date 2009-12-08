 /**
 * Clase para poder manejar el formulario de seleccion de columnas para los patrones
 */
FormularioDescartar = function(options) {
    this.merge(options);
    // Inicializacion de dialog y tabs jQueryUI
    this.init();
}

FormularioDescartar.prototype = {
    /**
     * Se une con otro JSON
     */
    'merge': function(options) {
        for(var k in options) {
            this.formOptions[k] = options[k];
        }
    },
    /**
     * Constructor
     */
    'init': function() {
        this.crearEventos();
    },
    /**
     * Creacion de eventos
     */
    'crearEventos': function() {
        var form = this;
        $("#formulario-descartar").bind("mostrar", function(e, target){
            var area = $(target).attr("class").replace(/.*(desc\d).*/, "$1");
            form.mostrar(area);
        });
        $("#formulario-descartar").dialog({
            'close': function(e, ui) {
                $("#area-descartar").trigger("actualizar:estado");
            }
        });
    },
    /**
     * Muestra el formulario de las columnas a descartar
     * @param DOM target
     */
    'mostrar': function(area) {
        this.crearSelect(area);
        //y por ultimo muestra el formulario
        $("#formulario-descartar").dialog("open");
    },
    /**
     * Crea el select para la seleccion de columnas de descartar
     */
    'crearSelect': function(area){
        $('.asmContainer0').remove();
        var html = '<select id="columnas-descartar" multiple="multiple">';
        $(estado.area.descartar[area].celdas).each(function (i, el){
           html += "<option>(<span class=\"desc-opt\">" + celdaExcel(el.id) + '</span>) ' + el.texto + "</option>";
        });
        html += '</select>';
        $('#div-select').html(html);
        //configurando el formulario de los patrones de las columnas a descartar
        $("#columnas-descartar").asmSelect({
            addItemTarget: 'bottom',
            animate: true,
            //removeLabel: 'quitar',
            sortable: true
        });
        //$('#asmSelect0 option:eq(0)').remove();
        $('#asmSelect0').attr('multiple','multiple');
        //colocando el sortable a la derecha
        html = "<table><tr><th class='ui-active-state'>Columnas</th><th class='ui-active-state'>Seleccionadas</th></tr>" + 
                      "<tr><td><div id='columnas-multiple'></div></td>" + 
                          "<td><div id='columnas-seleccionadas'></div></td></tr></table>";
        $('.asmContainer').append(html);
        $('#asmSelect0').prependTo('#columnas-multiple');
        $('#asmList0').prependTo('#columnas-seleccionadas');
        //para que siempre tenga un ancho correcto
        $('#columnas-seleccionadas').width(250);
        $('#columnas-multiple').width(250);
        //colocando los mismos estilos
        $('#asmSelect0 option').addClass('asmListItem');
        $('#id-descartar').val(area);
    }
}
