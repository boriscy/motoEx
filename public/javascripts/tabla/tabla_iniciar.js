/**
 * Funciones al iniciar la hoja
 */
$(document).ready(function(){
    // posicionamiento dinamico de las hojas dependiendo del contenido del div spreadsheet
    $('.sheet').css('top', $('#areas-importacion').position().top + 31);
    var hojas = new Array();
    var hoja_actual = $('#sheet-0').spreadsheet({numero: 0});
    
    // Inicializacion de opciones de marcado de areas
    grupoAreas = {
        areas: {},
        inicializar: function(){
            $('#area-importar').click(function() {
                // deberia mostrar un formulario
                // devuelve el id del area
                this.areas[id] = new CrearArea(id);
                if(this.areas[id] === false) {
                    delete(this.areas[id]);
                }
            });
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

    var areas = {};
    
    hojas[0] = hoja_actual;

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
    
    $('#lista_hojas a').live('click',function() {
        
        var num = $(this).attr('href').split('-')[1];
        var newtab = $(this);
        var newhoja = $('#sheet-' + num);
        if ( !newtab.parent().hasClass('active') ) {
            //$('.visible table:first').unbind('mousedown');
            //$('.visible table:first').unbind('mouseup');
            //$('.visible table:first').unbind('mouseover');
            
            $('.active').removeClass('active');
            newtab.addClass('active');
            $('.visible').removeClass('visible');
            hoja_actual = newhoja.addClass('visible');
            
            if (newhoja.html() == "" ){
                newhoja.html("<div style='text-align: center; height:100%;'><img src='/images/ajax-loader.gif' /></div>");
                //carga el contenido de la hoja por ajax
                $.ajax({
                    type: "POST",
                    url: "../hoja",
                    data: "archivo_id=<%= @archivo.id %>&numero="+num,
                    success: function(html){
                        newhoja.html(html);
                        //ejecuta el codigo para muestra de hojas
                        hoja_actual = newhoja.spreadsheet({numero: num});
                        hojas[num] = hoja_actual;
                    }
                });
            }
        }
    });
});
