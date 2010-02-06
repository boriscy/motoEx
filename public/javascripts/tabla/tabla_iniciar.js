/**
 * Funciones al iniciar la hoja
 */
$(document).ready(function() {

    // para que abra un popup al hacer click en un enlace de la clase .ventana-ayuda
    $('.ventana-ayuda').click(function(){
        var ventana = window.open(this.href, this.target, 'width=400, height=300, scrollbars=1, resizable=yes, location=no, status=no');
        //openWindow(, , 400, 300);
        return false;
    });
    // Variable global para sabe cuando shift es presionada
    shift = false;
    $(window).keydown( function(e) {
        if(e.keyCode == 16)
            shift = true;
    });

    // posicionamiento dinamico de las hojas dependiendo del contenido del div spreadsheet
    $('.sheet').css('top', $('#areas-importacion').position().top + 34);
    $('#sheet-0').spreadsheet({numero: 0});
    
    var hojas = {0: hoja_id};

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
        //'cssSeleccionado': 'sel',
        //'area': false,
        /**
         * Constructor
         */
        init: function() {
            var base = this;
            // Evento cuando se cambia area (select#area)
            $('select#area').change(function() {
                var temp = $(this).val();
                
                base.destruir();
                
                $(this).val(temp); //no hay problemas con esta linea ya que no llama al evento on change => no crea recursividad
                
                if (temp != 'disabled') {
                    // AJAX
                    $.getJSON("/areas/" + temp, function(resp) {
                        estado = resp;
                        base['area'] = new AreaGeneral();
                        $('#area_nombre').val(estado.area['nombre']);
                        $('#area_rango_filas').val(estado.area['rango_filas']);
                        $('#area_rango_columnas').val(estado.area['rango_columnas']);
                        $('#area_iterar_fila_true')[0].checked = estado.area['iterar_fila'];
                        $('#area_iterar_fila_false')[0].checked = !estado.area['iterar_fila'];
                        $('#area_fija')[0].checked = estado.area['fija'];
                    });
                    $('.forma_areas span.area_id').html($(this).val());
                }else{
                    $('.forma_areas span.area_id').html('');
                }
            });
            // Evento cuando se cambia de hoja
            $("div#lista_hojas a").click(function() {
                base.destruir();
            });
            // Evento para mostrar el formulario con propiedades
            $("#propiedades").click(function() {
                //solo si hay un area_general seleccionada
                if (typeof(base.area) != 'undefined') {
                    $("#propiedades").trigger('cargar:datos');
                    $('#formulario-areas').trigger("limpiar:errores");
                    $("#formulario-areas").dialog("open");
                }
            });
            //Evento para guardar con Salvar
            $('#salvar').click(function(){
                //solo si hay un area_general seleccionada
                if (typeof(base.area) != 'undefined') {
                    $("#formulario-areas form").trigger('guardar');
                }
            });
            //Evento para guardar un area nueva con Guardar como
            $('#guardar-como').click(function(){
                //solo si hay un area_general seleccionada
                if (typeof(base.area) != 'undefined') {
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
            $('body').bind("eliminar:area", function() {
                base.eliminarArea();
            });
            // para que cargue las areas de una hoja
            $('body').bind("cargar:areas", function(e, num) {
                $.ajax({
                    type: "POST",
                    url: "/hojas/areas",
                    data: {'archivo_id': archivo_id, 'numero': num},
                    success: function(html) {
                        $('select#area').html(html);
                    },
                    failure: function() {
                        $('select#area').html("");
                    }
                });
            });
            
            this.eventosMenu();
        },
        /**
         * Eventos realacionados la menu
         */
        'eventosMenu': function() {
            // Evento para el vinculo a#area-importar
            //cambiando el click con un binding para que se pueda llamar desde otros metodos
            var base = this;
            $("#area-importar").bind('marcar:area', function(){ base.crearArea(); });
            $("#area-importar").click( function() { $("#area-importar").trigger("marcar:area"); });
            
            $('#area-titular').click(function() { $('#area-titular').trigger("marcar:titular") } );
            $('#area-encabezado').click(function() { $('#area-encabezado').trigger("marcar:encabezado") } );
            $('#area-descartar').click(function() { $('#area-descartar').trigger("marcar:descartar") });
            $('#area-fin').click(function() { $('#area-fin').trigger("marcar:fin") });
        },
        /**
         * Código extraido y adaptado de $("#area-importar").click()
         * Crea el areaGeneral para su marcado
         */
        'crearArea': function(){
            //if (this['area']) {
            if (typeof(this.area) != 'undefined') {
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
                this.area.destruir();
                delete(this.area);
            }
            //elimina el estado.area
            estado = {};
            
            if ($('select#area').val() != "disabled"){
                $('select#area').val("disabled"); //no llama al evento change
                $('.forma_areas span.area_id').html('');
            }
        }
    }

    iniciar = new Iniciar();
    
    //para el formulario de guardar como
    //formulario_guardar_como = new FormularioGuardarComo();
    
    //para el formulario de descartar por patrones
    formulario_descartar = new FormularioDescartar();

    // Menu contextual
    menuContextual = new MenuContextual();
    // Sinonimos
    
    // Para el formulario de sinonimos
    formularioSinonimos = new FormularioSinonimos();

    /*************************************************/
    $('#lista_hojas a').live('click',function() {
        
        var $newtab = $(this);
        var num = $newtab.attr('href').split('-')[1];
        var $newhoja = $('#sheet-' + num);
        
        hoja_numero = num;
        
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
                        $newhoja.spreadsheet({'numero': num});
                        
                        hojas[num] = hoja_id;
                        
                        $('body').trigger("right:click");
                        // cargar listado de areas
                        $('body').trigger("cargar:areas", num);
                    },
                    failure: function() {
                        alert("Error al cargar la hoja");
                        $newhoja.html("");
                        // elimina el listado de areas
                        $('select#area').html("");
                    }
                });
            }else {
                hoja_id = hojas[num];
                $('body').trigger("cargar:areas", num);
            }
        }
    });
});
