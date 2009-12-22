/**
 * Clase para poder manejar el formulario de Area
 */
FormularioSinonimosCrear = function() {
    this.init();
}

FormularioSinonimosCrear.prototype = {
    /**
     * Constructor
     */
    'init': function() {
        var form = this;
        //crea el formulario
        $("#formulario-sinonimos-crear").dialog({
            'close': function(e, ui) {
                $("#formulario-sinonimos-crear").trigger("cerrar");
            },
            'width': 450, 
            'height': 300, 
            'resizable': false, 
            'modal': false, 
            'autoOpen': false,
            'title': 'Crear sinónimo'
        });
        //crea los eventos
        this.crearEventos();
    },
    /**
     * Creacion de eventos
     */
    'crearEventos': function() {
        var form = this;
        //para mostrar el formulario
        $('#formulario-sinonimos-crear').bind("mostrar", function() {
            //carga los datos del area
            form.llenaSelect();
            //muestra el formulario
            $("#formulario-sinonimos-crear").dialog("open");
        });
        // edita o guarda uno nuevo
        $('#formulario-sinonimos-crear').bind("cerrar", function() {
            form.cerrar();
        });
    },
    /**
     * Destruir eventos
     */
    'destruirEventos': function() {
        $('#formulario-sinonimos-crear').unbind("mostrar");
        $('#formulario-sinonimos-crear').unbind("cerrar");
    },
    'cerrar': function() {
        
    },
    /**
     * Destruye el objeto
     */
    'destruir': function() {
        this.destruirEventos();
    },
    'llenaSelect': function() {
        $("#sinonimos_campos").html("");
        //llena el select multiple
        var html = "";
        var campos = estado.area.encabezado.campos;
        for (var k in campos) {
            html += "<option class='" + k + "'>" + campos[k].campo + "</option>";
        }
        $("#sinonimos_campos").append(html);
    }
};
