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
            },
            'width': 600, 
            'height': 400, 
            'resizable': false, 
            'modal': true, 
            'title': 'Patrones de columnas a descartar'
        });
        $('#select-columnas').live("change", function() {
            var values = $(this).val();
            form.adicionarPatron(values);
        });
        $('#formulario-descartar .listado a.borrar-patron').live("click", function(e) {
            var target = getEventTarget(e);
            form.borrarPatron(target);
        });
        
        //para el formulario de seleccion de excepciones
        $("#formulario-descartar-excepciones").dialog({
            'close': function(e, ui) {
                //$("#area-descartar").trigger("actualizar:patrones");
                //agrega en el listado de excepciones
                form.actualizaExcepciones();
            },
            'beforeclose': function(e, ui) {
                //$("#area-descartar").trigger("actualizar:estado");
            },
            'width': 350, 
            'height': 250, 
            'resizable': false, 
            'modal': true, 
            'title': 'Excepciones'
        });
        $('#formulario-descartar .excepciones input:button').click(function() {
            //agrega las columnas del area
            //muestra el formulario de seleccion de columnas
            $("#formulario-descartar-excepciones").dialog("open");
        });
        $('#formulario-descartar .excepciones-listado a.borrar-excepcion').live("click", function(e) {
            var target = getEventTarget(e);
            form.borrarExcepcion(target);
        });
    },
    /**
     * Muestra el formulario de las columnas a descartar
     * @param DOM target
     */
    'mostrar': function(area) {
        $('#id-descartar').val(area);
        this.crearSelect(area);
        //y tambien crea el select de las excepciones
        this.crearSelectExcepciones(area);
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
    },
    /**
     * Llena el select de las excepciones con las columnas del area
     */
    'crearSelectExcepciones': function(area) {
        $select = $('#select-excepciones');
        $select.find("option").remove();
        var html="";
        var min = 0, max = 0;
        
        min = estado.area.celda_inicial.split('_')[1];
        max = estado.area.celda_final.split('_')[1];
        for (var i = min; i <= max; i++) {
            //html += '<option title="' + numExcelCol(i) + '" value="' + i + '" class="' + el.id + '">(' + celdaExcel(el.id) + ') ' + el.texto + '</option>';
            html += '<option title="' + numExcelCol(i) + '" value="' + area + '_excepcion_' + i + '" class="' + area + '_excepcion_' + i + '">Columna ' + numExcelCol(i) + '</option>';
        }
        $select.append(html);
    },
    /**
     * Agrega la excepcion al listado del form-descartar
     */
    'actualizaExcepciones': function() {
        var html = '';
        if ($("select#select-excepciones").val()){
            var el = $("select#select-excepciones").val();
            
            var $option = $("select#select-excepciones option." + el);
            var col = numExcelCol($option.val().split('_')[2]);
            html += '<li class=' + el + '>(' + col + ') <span>' + $("input#texto-excepciones").val() + '</span> <a class="borrar-excepcion">borrar</a></li>';
            $option.attr("disabled", true);
            
            $('#formulario-descartar .excepciones-listado').append(html);
            $('select#select-excepciones option').attr("selected", false);
        }
    },
    /**
     * elimina el excepcion seleccionada
     */
    'borrarExcepcion': function(target){
        var $li = $(target).parent('li');
        $("#select-excepciones option." + $li.attr("class")).attr("disabled", false);
        var area = $('#id-descartar').val();
        //delete(estado.area.descartar[area]['campos'][$li.attr("class")]);
        $li.remove();
    }
}
