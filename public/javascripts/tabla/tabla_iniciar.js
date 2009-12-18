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
        //'area': false,
        /**
         * Constructor
         */
        init: function() {
            var ini = this;
            // Evento cuando se cambia area (select#area)
            $('select#area').change(function() {
                var temp = $(this).val();
                
                ini.destruir();
                
                $(this).val(temp); //no hay problemas con esta linea ya que no llama al evento on change => no crea recursividad
                
                if (temp != 'disabled') {
                    // AJAX
                    $.getJSON("/areas/" + temp, function(resp) {
                        estado = resp;
                        ini['area'] = new AreaGeneral();
                        $('#area_nombre').val(estado.area['nombre']);
                        $('#area_rango').val(estado.area['rango']);
                        $('#area_iterar_fila_true')[0].checked = estado.area['iterar_fila'];
                        $('#area_iterar_fila_false')[0].checked = !estado.area['iterar_fila'];
                        $('#area_fija')[0].checked = estado.area['fija'];
                    });
                }
            });
            // Evento cuando se cambia de hoja
            $("div#lista_hojas a").click(function() {
                ini.destruir();
            });
            // Evento para mostrar el formulario con propiedades
            $("#propiedades").click(function() {
                //solo si hay un area_general seleccionada
                if (typeof(ini.area) != 'undefined') {
                    $("#propiedades").trigger('cargar:datos');
                    $("#formulario-areas").dialog("open");
                }
            });
            //Evento para guardar con Salvar
            $('#salvar').click(function(){
                //solo si hay un area_general seleccionada
                if (typeof(ini.area) != 'undefined') {
                    $("#formulario-areas form").trigger('guardar');
                }
            });
            //Evento para guardar un area nueva con Guardar como
            $('#guardar-como').click(function(){
                //solo si hay un area_general seleccionada
                if (typeof(ini.area) != 'undefined') {
                    //muestra un formulario con un campo de texto y con un boton de guardar
                    $('#guardar_como_area_nombre').val($("#area_nombre").val());
                    $("#formulario-guardar-como").dialog("open");
                    //el boton guardar de ese formulario llama a la funcion submit
                }
            });
            //Evento para el boton del formulario guardar-como
            $('#boton-guardar-como').click(function(){
                //el boton guardar de ese formulario llama a la funcion submit
                //cambia el nombre del area pero NO del estado.area['nombre'] => para que guarde como una nueva area
                $('#area_nombre').val($("#guardar_como_area_nombre").val());
                $("#formulario-areas form").trigger('guardar:como');
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
            //Evento para destruccion de area
            $("body").bind("eliminar:area", function() {
                ini.eliminarArea();
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
            $('#area-descartar').click(function() { $('#area-descartar').trigger("marcar:descartar") });
        },
        /**
         * Código extraido y adaptado de $("#area-importar").click()
         * Crea el areaGeneral para su marcado
         */
        'crearArea': function(){
            if (this['area']) {
                this.destruir();
            }
            this['area'] = new AreaGeneral();
        },
        /**
         * Elimina el area e inicializa la variable global "estado"
         */
        'destruir': function() {
            $('#sheet-' + hoja_numero).trigger("destruir:area");
            this.eliminarArea();
        },
        /**
         * Elimina la variable area
         */
        'eliminarArea': function() {
            if (typeof(this.area) != 'undefined') {
                delete(this.area);
                estado = {};
            }
            
            if ($('select#area').val() != "disabled")
                $('select#area').val("disabled"); //no llama al evento change
        }
    }

    iniciar = new Iniciar();
    
    //para el formulario de guardar como
    //formulario_guardar_como = new FormularioGuardarComo();
    
    //para el formulario de descartar por patrones
    formulario_descartar = new FormularioDescartar();

    // Menu contextual
    menuContextual = new MenuContextual();

    /*************************************************/
    $('#lista_hojas a').live('click',function() {
        
        var $newtab = $(this);
        var num = $newtab.attr('href').split('-')[1];
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
                    data: {'archivo_id': archivo_id, 'numero': num},
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
