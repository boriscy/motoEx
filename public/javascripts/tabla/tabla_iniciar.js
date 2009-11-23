/**
 * Funciones al iniciar la hoja
 */
$(document).ready(function(){
    // posicionamiento dinamico de las hojas dependiendo del contenido del div spreadsheet
    $('.sheet').css('top', $('#areas-importacion').position().top + 31);
    var hojas = new Array();
    $('#sheet-0').spreadsheet({numero: 0});
    var hojaActual =  0;
    
    // Inicializacion de opciones de marcado de areas
    Area = {
        inicializar: function(){
            
            var ga = this;
            $('#area-encabezado').click(function() { ga.llamarMetodo("definirAreaEncabezado"); } );
            $('#area-descartar').click(function() { ga.llamarMetodo("definirAreaDescartar"); });
            $('#area-fin').click(function() { ga.llamarMetodo("definirAreaFin"); });
            
        },
        llamarMetodo: function(metodo) {
            var id = $('.sel').attr("class").replace(/^.*(-id-[a-z0-9]+).*$/, "$1");
            if(id != "") {
                this.areas[id][metodo]();
            }else{
                this.mensajeError("Debe seleccionar dentro de un área definida");
            }
        }
    };

    //new Area();

    hojas[0] = hojaActual;

    $('#scroll_start').click(function() {
        $('#lista_hojas').scrollTo(0, 0, {duration: 500});
    });
    $('#scroll_left').click(function() {
        var posicion = $('#lista_hojas').scrollLeft()-80;
        $('#lista_hojas').scrollTo(posicion >= 0 ? posicion : 0 , 0, {duration: 200});
    });
    $('#scroll_right').click(function() {
        $('#lista_hojas').scrollTo($('#lista_hojas').scrollLeft() + 80, 0, {duration: 200});
    });
    $('#scroll_end').click(function(){
        $('#lista_hojas').scrollTo($('#lista_hojas').width(), {duration: 500});
    });
    
    //$('.opt_bold').live('click',function(){ $('.visible').setBold(); });
    
    //var lista_hojas = $('.lista_hojas').tabsajax();

    /**
     * Clase para poder manejar el formulario de Area
     */
    FormularioArea = function(options) {
      this.merge(options);
      this.eventosCrear();
      this.eventosDestruir();
      
    }

    FormularioArea.prototype = {
      id: '',
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
        if ($('#area').val() == 'disabled') {
          if($('#formulario-areas').length == 0){
            $.get('/areas/new', function(html){
              $(html).dialog(formulario.formOptions);
              $('#area-tabs').tabs();
              $("form").live('submit', function() {
                formulario.guardar(); 
                return false;
              });
            });
          }else{
            $('#formulario-areas').dialog("open");
          }
        }else{
          $.get('/areas/'+$('#area').val()+'/edit', function(){
            
          });
        }
      },
      guardar: function() {
        var formulario = this;
          $("#area_hoja_id").val(hoja_id);
          $.post('/areas/'+formulario.id, $('#formulario-areas').hashify(),  function(resp){
            //$('#area-tabs').
            $('#area').append("<option value='"+ resp["area"]["id"] +"'>" + resp["area"]["nombre"] + "</option>")
            .select(resp["area"]["id"]);
            $('#formulario-areas').attr('action', '/areas/' + resp["area"]["id"] + '/edit');
            $('#formulario-areas').append('<input type="hidden" value="put" />');
            $('.sel').addClass('green');
            console.log(resp);
          }, 'json');
      },
      eventosCrear: function() {
        var formulario = this;
        $("#area-importar").click(function() {
            formulario.buscarCrear();
        });
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

    var formArea = new FormularioArea();

  
    /*************************************************/
    $('#lista_hojas a').live('click',function() {
        
        var num = $(this).attr('href').split('-')[1];
        var newtab = $(this);
        var newhoja = $('#sheet-' + num);
        if ( !newtab.parent().hasClass('active') ) {
            
            $('.active').removeClass('active');
            newtab.addClass('active');
            $('.visible').removeClass('visible');
            hoja_actual = newhoja.addClass('visible');
             // Destruir el formulario para areas

            if (newhoja.html() == "" ) {
                newhoja.html("<div style='text-align: center; height:100%;'><img src='/images/ajax-loader.gif' /></div>");
                //carga el contenido de la hoja por ajax
                $.ajax({
                    type: "POST",
                    url: "/hoja",
                    data: "archivo_id="+archivo_id+"&numero="+num,
                    success: function(html) {
                        newhoja.html(html);
                        //ejecuta el codigo para muestra de hojas
                        hoja_actual = newhoja.spreadsheet({numero: num});
                        hojas[num] = hoja_actual;
                    },
                    failure: function() {
                      alert("Error al cargar la hoja");
                      newhoja.html(""); 
                    }

                });
            }
        }
    });
    /*
    $('#area-importar').click(function() {
        // deberia mostrar un formulario
        // devuelve el id del area
        if($('#sheet-'+hojaActual).find('.sel').length > 1){
          buscarCrear();
        }
    });
    
    // Cargar los datos del area
    $('#area').select(function() {
        if ($(this).val() != 'disabled'){
          $.getJSON('/areas/'+$(this).val(), function(e) {

          });
        }
    });
    */

    
    
});
