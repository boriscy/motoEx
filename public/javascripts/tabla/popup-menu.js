 /**
 * Clase para poder manejar el menu contextual al hacer click derecho en la hoja
 */
PopupMenu = function(options) {
    this.merge(options);
    this.crearEventos();
}

PopupMenu.prototype = {
    'area': false,
    /**
     * Se une con otro JSON
     */
    'merge': function(options) {
        for(var k in options) {
            this.formOptions[k] = options[k];
        }
    },
    'init': function(){
        this.crearEventos();
    },
    'crearEventos': function(){
        $('.sheet-content').contextMenu('popup-menu', {
            bindings: {
                'menu-area': function(t) {
                    $("#area-importar").trigger("marcar:area");
                },
                'menu-titular': function(t) {
                    $('#area-titular').trigger("marcar:titular");
                },
                'menu-encabezado': function(t) {
                    $('#area-encabezado').trigger("marcar:encabezado");
                },
                'menu-fin': function(t) {
                    $('#area-fin').trigger("marcar:fin");
                },
                'menu-descartar': function(t) {
                    //abre el formulario de las columnas a descartar
                    $("#formulario-descartar").dialog("open");
                    //y le agrega las columnas dentro de la seleccion para desmarcar
                    $("#columnas").innerHTML = "";
                    $(".visible .sel").each(function(i, e){
                        $("#columnas").append("<option>" + (e.innerHTML || ("Columna " + i)) + "</option>");
                        $("#asmSelect0").append("<option>" + (e.innerHTML || ("Columna " + i)) + "</option>");
                    });
                }
            }
        });
    }
}
