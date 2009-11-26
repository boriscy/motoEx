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


    /**
     * Objeto principal que inicializa todo
     */
    Iniciar = function() {
        this.init();
    }

    Iniciar.prototype = {
        'cssSeleccionado': 'sel',
        'area': false,
        'areaMinima': 4,
        init: function() {
            var ini = this;
            // Evento cuando se cambia area (select#area)
            $('select#area').change(function() {
                $('body').trigger("destruir:area");
                ini.destruir();
                if($(this).val() != 'disabled') {
                    ini['area'] = new AreaGeneral();
                }
            });
            // Evento cuando se cambia de hoja
            $("div#lista_hojas a").click(function() { 
                $('#sheet-'+hoja_numero).trigger("destruir:area");
                ini.destruir();
            });
            // Evento para mostrar el formulario con propiedades
            $("#propiedades").click(function() {
                $("#propiedades").trigger('cargar:datos');
                $("#formulario-areas").dialog("open");
            });
            //Evento para guardar con Salvar
            $('#salvar').click(function(){
                $("#formulario-areas form").trigger('submit');    
            });

            this.eventosMenu();
        },
        /**
         * Eventos realacionados la menu
         */
        'eventosMenu': function() {
            var ini = this;
            // Evento para el vinculo a#area-importar
            $("#area-importar").click( function() {
                // Se deberia definir area minima
                if( $('.' + ini.cssSeleccionado).length >= ini.areaMinima) {
                    // Crea un area o sino presenta el formulario
                    if(!ini.area) {
                        var puntos = ini.obtenerPuntos();
                        ini["area"] = new AreaGeneral(puntos[0], puntos[1]);
                    }else{
                        $('#sheet-'+hoja_numero).trigger('marcar:area');
                    }
                }
            });

            $('#area-encabezado').click(function() { $('#area-encabezado').trigger("marcar:encabezado") } );
            $('#area-fin').click(function() { $('#area-fin').trigger("marcar:fin") } );
            $('#area-descartar').click(function() { $('#area-descartar').trigger("marcar:descartar") });
        },
        /**
         * Elimina el area
         */
        destruir: function() {
            if(typeof(this.area) != 'undefined') {
                delete(this.area);
            }
        },
        crear: function() {
            //
            this['area']= new AreaGeneral();
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
    
});
