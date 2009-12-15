/**
 * Funciones al iniciar la hoja
 */
$(document).ready(function() {

    // Variable global para sabe cuando shift es presionada
    shift = false;
    $(window).keydown( function(e) {
        if(e.keyCode == 16)
            shift = true;
    });

    // posicionamiento dinamico de las hojas dependiendo del contenido del div spreadsheet
    $('.sheet').css('top', $('#areas-importacion').position().top + 31);
    $('#sheet-0').spreadsheet({numero: 0});

    // Funciones para scroll de hojas
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

    // Variable que almancena el estado general de un area
    estado = {};
    
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
        /**
         * Constructor
         */
        init: function() {
            var ini = this;
            // Evento cuando se cambia area (select#area)
            $('select#area').change(function() {
                $('body').trigger("destruir:area");
                ini.destruir();

                if($(this).val() != 'disabled') {
                    // AJAX
                    $.getJSON("/areas/"+$(this).val(), function(resp) {
                        estado = resp;
                        ini['area'] = new AreaGeneral();
                        $('#area_nombre').val(estado.area['nombre']);
                        $('#area_rango').val(estado.area['rango']);
                        $('#area_iterar_fila_true')[0].checked = estado.area['iterar_fila'];
                        $('#area_fija')[0].checked = estado.area['fija'];
                    });
                }else{
                    // limpia el formulario tambien
                }
            });

            // Evento cuando se cambia de hoja
            $("div#lista_hojas a").click(function() { 
                $('body').trigger("destruir:area");
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
            //Evento para menu contextual
            $("#sheet-" + hoja_numero + "-content").rightClick(function(e) {
                $('.sheet-content').trigger("menu:contextual", e);
            });
            $('body').bind("right:click" , function() {
                $("#sheet-" + hoja_numero + "-content").rightClick(function(e) {
                    $('.sheet-content').trigger("menu:contextual", e);
                });
            });
            
            this.eventosMenu();
        },
        /**
         * Eventos realacionados la menu
         */
        'eventosMenu': function() {
            var ini = this;
            // Evento para el vinculo a#area-importar
            //cambiando el click con un binding para que se pueda llamar desde otros metodos
            $("#area-importar").bind('marcar:area', function(){ ini.crearArea(); });
            $("#area-importar").click( function() { $("#area-importar").trigger("marcar:area"); });
            
            $('#area-titular').click(function() { $('#area-titular').trigger("marcar:titular") } );
            $('#area-encabezado').click(function() { $('#area-encabezado').trigger("marcar:encabezado") } );
            //$('#area-fin').click(function() { $('#area-fin').trigger("marcar:fin") } );
            $('#area-descartar').click(function() { $('#area-descartar').trigger("marcar:descartar") });
        },
        /**
         * Código extraido y adaptado de $("#area-importar").click()
         * Crea el areaGeneral para su marcado
         */
        'crearArea': function(){
            if(this['area']) {
                //$('#sheet-' + hoja_numero).trigger("destruir:area");
                this.destruir();
            }
            this['area'] = new AreaGeneral();
        },
        
        /**
         * Elimina el area y inicializa la variable global "estado"
         */
        destruir: function() {
            $('#sheet-' + hoja_numero).trigger("destruir:area");
            //$('.sel').removeClass("sel");
            if(typeof(this.area) != 'undefined') {
                //this.area.destruir();
                delete(this.area);
                estado = {};
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
    
    //para el formulario de descartar por patrones
    formulario_descartar = new FormularioDescartar();

    // Menu contextual
    menuContextual = new MenuContextual();

  
    /*************************************************/
    $('#lista_hojas a').live('click',function() {
        
        var num = $(this).attr('href').split('-')[1];
        var $newtab = $(this);
        var $newhoja = $('#sheet-' + num);
        if ( !$newtab.parent().hasClass('active') ) {
            // deselecciona las celdas que estuvieran seleccionadas
            $('.sel').removeClass("sel");
            // muestra la hoja seleccionada
            $('.active').removeClass('active');
            $newtab.addClass('active');
            $('.visible').removeClass('visible');
            $newhoja.addClass('visible');
             // Destruir el formulario para areas
            if ($newhoja.html() == "" ) {
                $newhoja.html("<div style='text-align: center; height:100%;'><img src='/images/ajax-loader.gif' /></div>");
                //carga el contenido de la hoja por ajax
                $.ajax({
                    type: "POST",
                    url: "/hoja",
                    data: "archivo_id="+archivo_id+"&numero="+num,
                    success: function(html) {
                        $newhoja.html(html);
                        //ejecuta el codigo para muestra de hojas
                        $newhoja.spreadsheet({numero: num});
                        $('body').trigger("right:click");
                    },
                    failure: function() {
                        alert("Error al cargar la hoja");
                        $newhoja.html(""); 
                    }

                });
            }
        }
    });
});
