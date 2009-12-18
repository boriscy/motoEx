/**
 * Clase para poder manejar el formulario de seleccion de columnas para los patrones
 */
FormularioDescartar = function(options) {
    this.merge(options);
    // Inicializacion de dialog y tabs jQueryUI
    this.init();
}

FormularioDescartar.prototype = {
    'formularioExcepciones': '',
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
        this.formularioExcepciones = new FormularioDescartarExcepciones();
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
                // Actualizacion de la tabla con el patron seleccionado
                $("#area-descartar").trigger("actualizar:tabla:patrones");
            },
            'beforeclose': function(e, ui) {
                $("#area-descartar").trigger("actualizar:estado");
            },
            'width': 600, 
            'height': 400, 
            'resizable': false, 
            'modal': true, 
            'title': 'Patrones para descartar'
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
        var limites = this.crearLimitesCelda(area);
        for(var i = limites[0]; i <= limites[1]; i++) {
            var pos = this.construirPosicion(area, i);
            var $el = $('#' +  pos);
            html += '<option title="' + $el.text().trim() + '" value="' + pos + '" class="' + pos + '">(' + celdaExcel(pos) + ') ' + $el.text().trim() + '</option>';
        }
        $select.append(html);

        var values = [];
        for (var k in estado.area.descartar[area].patron) {
            var pos = this.construirPosicion(area, k);
            values.push(pos);
        }
        
        // Patron
        this.adicionarPatron(values);

        // Excepciones
        $('#grupo-excepciones ul.grupo-excepcion').remove();
        $('#area-descartar').trigger("cargar:excepciones");
    },
    /**
     * @return Array 
     */
    'crearLimitesCelda': function(area) {
        var inicio = estado.area.descartar[area].celda_inicial.split("_"),
        fin = estado.area.descartar[area].celda_final.split("_");
        
        if( estado.area['iterar_fila'] ) {
            return [inicio[1], fin[1]];
        }else{
            return [inicio[0], fin[0]];
        }
    },
    /**
     *
     */
    'construirPosicion': function(area, iteracion) {
        var tmppos = estado.area.descartar[area].celda_inicial.split("_");
        if( estado.area['iterar_fila'] ) {
            return hoja_numero + '_' + tmppos[0]  + '_' + iteracion;
        }else{
            return hoja_numero + '_' + iteracion  + '_' + tmppos[1];
        }
    },
    /**
     * Devuelve el nombre de la fila o columna del patron
     * @param String celda #id de la celda a generar
     */
    'obtenerPosicionPatron': function(celda) {
        if (estado.area['iterar_fila']) {
            return numExcelCol(celda.split('_')[2]);
        }else{
            return celda.split('_')[1];
        }
    },
    /**
     * Adiciona la lista de patron
     */
    'adicionarPatron': function(values) {
        var html = '';
        var form = this;
        $(values).each(function(i, el) {
            var $option = $("#select-columnas option." + el);
            var pos = form.obtenerPosicionPatron($option.val());
            html += '<li class=' + el + '>(' + pos + ') <span>' + $option.text().replace(/^\([\w]+\)\s/, "").trim() + '</span> <a class="borrar-patron">borrar</a></li>';
            $option.attr("disabled", true);
        });
        $('#formulario-descartar .listado').append(html);
        $('#select-columnas option').attr("selected", false);
    },
    /**
     * elimina el patron seleccionado
     */
    'borrarPatron': function(target){
        var $li = $(target).parent('li');
        $("#select-columnas option." + $li.attr("class")).attr("disabled", false);
        var area = $('#id-descartar').val();
        delete(estado.area.descartar[area]['patron'][$li.attr("class")]);
        $li.remove();
    }
}
