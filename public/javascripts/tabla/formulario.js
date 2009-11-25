 /**
 * Clase para poder manejar el formulario de Area
 */
FormularioArea = function(area, options) {
    this['area'] = area;
    this['areas']['general'] = this.area.cssSeleccionado;
    this.merge(options);
    // Inicializacion de dialog y tabs jQueryUI
    if(!$("div#formulario-areas").hasClass("ui-dialog-content") ) {
        $("div#formulario-areas").dialog({'width': 600, 'resizable': false, 'modal': true});
        $("#area-tabs").tabs();
    }else{
        $("div#formulario-areas").dialog("open");
    }
    this.crearEventos();
}

FormularioArea.prototype = {
    area: '',
    'areas': {
      'encabezado':"bg-light-blue", 
      'fin':"bg-light-yellow"
    },
    formOptions:{ width: 600, title: 'Definición de areas', modal: true},
    /**
     * Se une con otro JSON
     */
    merge: function(options) {
        for(var k in options) {
            this.formOptions[k] = options[k];
        }
    },
    /**
     * Creacion de eventos
     */
    'crearEventos': function() {
      var form = this;
      $('div#formulario-areas').bind("cargar:datos", function(datos) { form.cargarDatos(datos) });
      var form = this;
      $('div#formulario-areas form').submit(function() {
          form.guardar();
          return false;
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
     * Carga el formulario con los datos
     */
    'cargarDatos': function(datos) {
      $("area_hoja_id").val(hoja_id);
    },
    /**
     * Carga los datos de un area al formulario en base a las clases css
     */
    'cargarDatosArea': function() {
      for(var k in this.areas) {
        var id = k == 'general' ? '': '_' + k;
        var celdas = this.obtenerPuntos(this.areas[k]);
        $('#area'+ id +'_celda_inicial').val( celdas[0] );
        $('#area'+ id +'_celda_final').val( celdas[1] );
        // span
        $('#span'+ id +'_celda_inicial').html( celdaExcel(celdas[0]) );
        $('#span'+ id +'_celda_final').html( celdaExcel(celdas[1]) );
      }
      $("area_hoja_id").val(hoja_id);
    },
    /**
     * Obtiene el punto inicial y final del area
     * @return Array
     */
    obtenerPuntos: function(param) {
        arr = [];
        try{
            arr.push(this.punto( $('.' + param +':first').attr("id") ) );
            arr.push(this.punto( $('.' + param +':last').attr("id") ) );
        }catch(e){
            arr[0] = "", arr[1] = "";
        }
        return arr;
    },
    /**
    * Retorna el id de la celda sin hoja
    * @return String
    */
    punto: function(p) {
        return p.replace(/^\d+_([\d_]+)$/, "$1");
    },
    /**
     * Prepara en el formulario las celdas inicial, final
     */
    iniciarCeldas: function() {
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
    formatoSpan: function(sp) {
        var f = sp.split("_");
        return numExcelCol(parseInt(f[1])) + f[0];
    },
    /**
     * guarda el area seleccionada en BD usando AJAX
     */
    guardar: function() {
      var formulario = this;
        var area_id = $('select#area').val();
        var post = area_id == 'disabled' ? '/areas' : '/areas/' + area_id;
        // AJAX
        $.post(post, $('div#formulario-areas').hashify(),  function(resp) {
          // Crear
          if(area_id == 'disabled') {
            area_id = resp['area']['id'];
            $('select#area').append("<option value='"+ area_id +"'>" + resp["area"]["nombre"] + "</option>");
            $('select#area option[value='+ area_id +']').attr("selected", "selected");
            $('input:hidden[name=_method]').val("put");
            $('div#formulario-areas').append('<input type="hidden" name="_method" value="put" />');
          }
          // Clase para todos los eventos, Evento definido en la clase AreaGeneral tabla/areas.js
          $('#sheet-'+hoja_numero).trigger("marcar:area");
          $("#formulario-areas").dialog("close");
        }, 'json');
    },
    /**
     * Cierra el formulario y deselecciona
     */
    cerrar: function() {
      var formulario = this;
      $('div#formulario-areas').dialog("close");
    },
    /**
     *
     */
    eventosCrear: function() {
      var formulario = this;
      //$("#area-importar").live('click', function() {
          //formulario.buscarCrear();
          /*$('a#area-encabezado').live('click', function() { formulario.definirAreaEncabezado(); } );
          $('a#area-descartar').live('click', function() { formulario.definirAreaDescartar(); });
          $('a#area-fin').live('click', function() { formulario.definirAreaFin(); });
          */
      //});
    },
    /**
     *
    definirAreaEncabezado: function(){
      var inicio = $('.' + this.idArea + 'td:first');
      var fin = $('.' + this.idArea + 'td:first').parent("tr").find("td." + this.cssAreaImp + ":last");
      if(inicio.hasClass(this.cssSeleccionado) && fin.hasClass(this.cssSeleccionado)) {
          this.crearArea(this.cssAreaEnc);
          this.areaEncSel = true;
      }    
    },
    /**
     * Eventos que eliminan el formulario
     * select#area "change"
     * div#lista_hojas a "click"2
     */
    eventosDestruir: function() {
      var formulario = this;
      //$("body").bind("destruir:area", function() { formulario.eliminarFormulario() });
    }
};
