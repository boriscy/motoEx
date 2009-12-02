/**
 * Funciones al iniciar la hoja
 */
$(document).ready(function(){
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
                    });
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
            $('#area-fin').click(function() { $('#area-fin').trigger("marcar:fin") } );
            $('#area-descartar').click(function() { $('#area-descartar').trigger("marcar:descartar") });
        },
        /**
         * Código extraido y adaptado de $("#area-importar").click()
         * Crea el areaGeneral para su marcado
         */
        'crearArea': function(){
            if(this['area']) {
                $('#sheet-' + hoja_numero).trigger("destruir:area");
                this.destruir();
            }
            this['area'] = new AreaGeneral();
        },
        
        /**
         * Elimina el area y inicializa la variable global "estado"
         */
        destruir: function() {
            if(typeof(this.area) != 'undefined') {
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
    
    //para el menu contextual
    popmenu = new PopupMenu();
   
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
            newhoja.addClass('visible');
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
                        newhoja.spreadsheet({numero: num});
                    },
                    failure: function() {
                        alert("Error al cargar la hoja");
                        newhoja.html(""); 
                    }

                });
            }
        }
    });
    
    //configurando el formulario de los patrones de las columnas a descartar
    $("select[multiple]").asmSelect({
        addItemTarget: 'bottom',
        animate: true,
        //highlight: true,
        sortable: true,
        removeLabel: 'quitar'
    });
    $('#asmSelect0 option:eq(0)').remove();
    $('#asmSelect0').attr('multiple','multiple');
    $('#asmContainer0').css('float','left');
    //colocando el sortable a la derecha
    $('#asmContainer0').prepend("<div id='columnas-seleccionadas' style='float:left'></div>");
    $('#asmContainer0').prepend("<div id='columnas-boton' style='float:left'> | </div>");
    $('#asmContainer0').prepend("<div id='columnas-multiple' style='float:left'></div>");
    $('#asmSelect0').prependTo('#columnas-multiple');
    $('#asmList0').prependTo('#columnas-seleccionadas');
    //para que siempre tenga un ancho correcto
    //$('#columnas-seleccionadas').width($('#asmSelect0')[0].clientWidth + 50);
    $('#columnas-seleccionadas').width(250);
    $('#columnas').css('width',250);
    //colocando los mismos estilos
    $('#asmSelect0 option').each(function(i, e){
        $(e).addClass('asmListItem');
    });
    
});
