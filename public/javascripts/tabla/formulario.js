 /**
 * Clase para poder manejar el formulario de Area
 */
FormularioArea = function(area, options) {
    this.area = area;
    this.merge(options);
    this.eventosDestruir();
    this.buscarCrear();
}

FormularioArea.prototype = {
    area: '',
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
     * Muestra un formulario para la búsqueda o creacion de areas
     */
    buscarCrear:function () {
        var formulario = this;
        // Verifica el valor del combo #area
        if ($('#area').val() == 'disabled') {
            // AJAX
            $.get('/areas/new', function(html){
              $(html).dialog(formulario.formOptions);
              $('#area-tabs').tabs();
              formulario.iniciarCeldas();
              // Para guardar formulario
              $("#formulario-areas form").submit( function() {
                  formulario.guardar();
                  return false;
              });
            });
        }else{
          $.get('/areas/'+$('#area').val()+'/edit', function(){
            
          });
        }
    },
    obtenerPuntos: function() {
        arr = [];
        arr.push(this.punto( $('.' + this.area.cssSeleccionado +':first').attr("id")) );
        arr.push(this.punto( $('.' + this.area.cssSeleccionado +':last').attr("id")) );
        return arr;
    },
    punto: function(p) {
        return p.replace(/^\d+_([\d_]+)$/, "$1");
    },

    /**
     * Prepara en el formulario las celdas inicial, final
     */
    iniciarCeldas: function() {
        var punto = this.obtenerPuntos();
        $("#area_celda_inicial").val(punto[0]);
        $("#span_celda_inicial").html(this.formatoSpan(punto[0]));
        $("#area_celda_final").val(punto[1]);
        $("#span_celda_final").html(this.formatoSpan(punto[1]));
    },
    /**
     *
     */
    formatoSpan: function(sp) {
        var f = sp.split("_");
        return numExcelCol(parseInt(f[1])) + f[0];
    },
    /**
     * guarda el area seleccionada en BD
     */
    guardar: function() {
      var formulario = this;
        $("#area_hoja_id").val(hoja_id);
        $.post($('#formulario-areas form').attr("action"), $('#formulario-areas').hashify(),  function(resp){
          //$('#area-tabs').
          $('#area').append("<option value='"+ resp["area"]["id"] +"'>" + resp["area"]["nombre"] + "</option>")
          .select(resp["area"]["id"]);
          $('#formulario-areas').attr('action', '/areas/' + resp["area"]["id"] + '/edit');
          $('#formulario-areas').append('<input type="hidden" name="_method" value="put" />');
          // Clase para todos los eventos, Evento definido en la clase AreaGeneral tabla/areas.js
          $('.visible').trigger("area:cambiar");
          formulario.cerrar();
        }, 'json');
    },
    /**
     * Cierra el formulario y deselecciona
     */
    cerrar: function() {
      var formulario = this;
      $('#formulario-areas').dialog("close");
      $('.sel').removeClass('sel');
    },
    /**
     *
     */
    eventosCrear: function() {
      var formulario = this;
      $("#area-importar").live('click', function() {
          formulario.buscarCrear();
          $('#area-encabezado').live('click', function() { formulario.definirAreaEncabezado(); } );
          $('#area-descartar').live('click', function() { formulario.definirAreaDescartar(); });
          $('#area-fin').live('click', function() { formulario.definirAreaFin(); });
          
      });
    },
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
     */
    eventosDestruir: function() {
      var formulario = this;
      $("#area").select(function() { formulario.eliminarFormulario() });
      $("#lista_hojas a").click(function() { formulario.eliminarFormulario() });
    },
    /**
     * Función que elimina el formulario del DOM
     */
    eliminarFormulario: function() {
      $('#formulario-areas').remove();
    }
};

