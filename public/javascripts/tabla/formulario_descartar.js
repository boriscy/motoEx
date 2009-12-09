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
                $("#area-descartar").trigger("actualizar:patrones");
            },
            'beforeclose': function(e, ui) {
                $("#area-descartar").trigger("actualizar:estado");
            }
        });
        $('#select-columnas').live("change", function() {
            var values = $(this).val();
            form.adicionarPatron(values);
        });
        $('#formulario-descartar .listado a.borrar-patron').live("click", function(e) {
            var target = getEventTarget(e);
            form.borrarPatron(target);
        });
    },
    /**
     * Muestra el formulario de las columnas a descartar
     * @param DOM target
     */
    'mostrar': function(area) {
        $('#id-descartar').val(area);
        this.crearSelect(area);
        //y por ultimo muestra el formulario
        $("#formulario-descartar").dialog("open");
    },
    /**
     * Crea el select para la seleccion de columnas de descartar
     */
    'crearSelect': function(area) {
        $select = $('#select-columnas');
        $select.find("option").remove();
        $('#formulario-descartar ul.listado li').remove();
        var html = '';
        //.append('<option title="Este es un texto bastante largo 2">Este es un texto bastante largo 2</option>');
        $(estado.area.descartar[area].celdas).each(function (i, el) {
            html += '<option title="' + el.texto + '" value="' + el.id + '" class="' + el.id + '">(' + celdaExcel(el.id) + ') ' + el.texto + '</option>';
        });
        $select.append(html);
        var values = [];
        for (var k in estado.area.descartar[area].campos) {
            values.push(k);
        }
        this.adicionarPatron(values);
    },
    /**
     * Adiciona la lista de patrones
     */
    'adicionarPatron': function(values) {
        var html = '';
        $(values).each(function(i, el) {
            var $option = $("#select-columnas option." + el);
            var col = numExcelCol($option.val().split('_')[2]);
            html += '<li class=' + el + '>(' + col + ') <span>' + $option.text().replace(/^\([\w]+\)\s/, "") + '</span> <a class="borrar-patron">borrar</a></li>';
            $option.attr("disabled", true);
        });
        $('#formulario-descartar .listado').append(html);
        $('#select-columnas option').attr("selected", false);
        // cambio de estado
        $("#area-descartar").trigger("actualizar:estado");
    },
    /**
     * elimina el patron seleccionado
     */
    'borrarPatron': function(target){
        var $li = $(target).parent('li');
        $("#select-columnas option." + $li.attr("class")).attr("disabled", false);
        var area = $('#id-descartar').val();
        delete(estado.area.descartar[area]['campos'][$li.attr("class")]);
        $li.remove();
    },
    /**
     * Desabilita las columnas seleccionadas
     */
    'deshabilitarOpciones': function(values) {
    },
    /**
     * Realiza un listado de las columnas
     * @return Array
     */
    'listarColumnas': function() {
        //
    }
}
