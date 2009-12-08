 /**
 * Clase para poder manejar el formulario de Area
 */
FormularioArea = function(area, options) {
    this.merge(options);
    // Inicializacion de dialog y tabs jQueryUI
    this.area = area;
    this.crearEventos();
}

FormularioArea.prototype = {
    'area': '',
    'celdas': ['celda_inicial', 'celda_final'],
    'areas': ['', 'encabezado', 'fin', 'titular'],
    /**
     * Se une con otro JSON
     */
    'merge': function(options) {
        for(var k in options) {
            this.formOptions[k] = options[k];
        }
    },
    /**
     * Creacion de eventos
     */
    'crearEventos': function() {
      var form = this;
      $('#formulario-areas form').submit(function() {
          form.guardar();
          return false;
      });

      $('div#formulario-areas').bind("salvar:datos", function(datos) { 
          form.guardar(); 
      });

    },
    /**
     * Destruir eventos
     */
    'destruirEventos': function() {
        $('div#formulario-areas').unbind("cargar:datos");
        $('div#formulario-areas form').unbind("submit");
    },
    /**
     * Prepara en el formulario las celdas inicial, final
     */
    'iniciarCeldas': function() {
        var punto = this.obtenerPuntos();
        $("input#area_celda_inicial").val(punto[0]);
        $("span#span_celda_inicial").html(this.formatoSpan(punto[0]));
        $("input#area_celda_final").val(punto[1]);
        $("span#span_celda_final").html(this.formatoSpan(punto[1]));
    },
    /**
     * Da formato para presentar en los spans estilo "Excel"
     * @return String
     */
    'formatoSpan': function(sp) {
        var f = sp.split("_");
        return numExcelCol(parseInt(f[1])) + f[0];
    },
    /**
     * guarda el area seleccionada en BD usando AJAX
     */
    'guardar': function() {

        if (this.validarDatos()){
            var formulario = this;
            var area_id = $('select#area').val();
            var post = area_id == 'disabled' ? '/areas' : '/areas/' + area_id;
            //llena los datos restantes del formulario
            estado.area['nombre'] = $('#area_nombre').val();
            estado.area['rango'] = $('#area_rango').val();
            estado.area['iterar_fila'] = $('#area_iterar_fila_true')[0].checked;
            estado.area['fija'] = $('#area_fija')[0].checked;
            estado.area['hoja_id'] = hoja_id;
            // AJAX
            $.post(post,{'area': JSON.stringify(estado.area)},  function(resp) {
              // Crear
                if(area_id == 'disabled') {
                    area_id = resp['area']['id'];
                    $('select#area').append("<option value='" + area_id + "'>" + resp["area"]["nombre"] + "</option>");
                    $('select#area option[value=' + area_id + ']').attr("selected", "selected");
                    $('input:hidden[name=_method]').val("put");
                    $('div#formulario-areas').append('<input type="hidden" name="_method" value="put" />');
                }
            }, 'json');
        }else{
            $("#formulario-areas").dialog("open");
        }
    },
    /**
     * Valida los datos del area antes de guardarla en BD
     * @return boolean
     */
    'validarDatos': function() {
        var nombre = $('#area_nombre').val();//.trim();
        var val=true;
        if(nombre == "") {
            this.adicionarError('#area_nombre', 'No debe estar el nombre en blanco');
            val = false;
        }else if( $('select#aera option:contains(' + nombre + ')').length > 0 ) {
            this.adicionarError('#area_nombre', "El nombre ya esta en uso");
            val = false;
        }
        if ($('.' + this.area.cssMarcar).length <= 1){
            this.adicionarError('#span_celda_inicial',"El area marcada debe ser mayor que una celda");
            val = false;
        }

        if (! /^\d+$/.test($('#area_rango').val())){
            this.adicionarError('#area_rango',"El rango debe ser un valor numérico"); 
            val = false;
        }
        var encabezados = 0;
        for (var k in estado.area.encabezado.campos){
            encabezados++;
        }
        //que al menos un campo este seleccionado
        if (encabezados == 0){
            this.adicionarError('#encabezado p',"Debe seleccionar al menos un campo");
            val = false;
        }
        return val;

    },
    /**
     * Adiciona mensajes de error
     * @param String id
     * @param String msj
     */
    'adicionarError': function(id, msj) {
        $(id).after("<span class='error'>" + msj + "</span>");
    },
    /**
     * Cierra el formulario y deselecciona
     */
    'cerrar': function() {
      var formulario = this;
      $('div#formulario-areas').dialog("close");
    }
};
