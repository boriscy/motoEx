/**
 * Funciones al iniciar la hoja
 */
$(document).ready(function(){
    // posicionamiento dinamico de las hojas dependiendo del contenido del div spreadsheet
    $('.sheet').css('top', $('#areas-importacion').position().top + 31);
    var hojas = new Array();
    $('#sheet-0').spreadsheet({numero: 0});
    var hojaActual =  0;
    
    hojas[0] = hojaActual;

    // Funciiones para scroll de hojas
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


    Iniciar = function() {
        this.init();
    }
    Iniciar.prototype = {
        cssSeleccionado: 'sel',
        init: function() {
            var ini = this;
            $("#area-importar").live('click', function() {
                  if(typeof(area) == 'undefined') {
                      puntos = ini.obtenerPuntos();
                      area = new AreaGeneral(puntos[0], puntos[1]);
                  }else{
                      $("#formulario-areas").dialog("open");
                  }
            });
        },
        obtenerPuntos: function() {
            arr = [];
            arr.push(this.punto( $('.' + this.cssSeleccionado +':first').attr("id")) );
            arr.push(this.punto( $('.' + this.cssSeleccionado +':last').attr("id")) );
            return arr;
        },
        punto: function(p) {
            return p.replace(/^\d+_([\d_]+)$/, "$1");
        }
    }

    iniciar = new Iniciar();

   
    //var formArea = new FormularioArea();

  
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
