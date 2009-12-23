/**
 * Clase para poder manejar el formulario de Creacion de sinonimos
 * utilizan la variable estado.area para lectura solamente (llenado de formulario, etc)
 */
FormularioSinonimosCrear = function() {
    this.init();
}

FormularioSinonimosCrear.prototype = {
    /**
     * Para diferenciar si inserta un nuevo grupo o edita
     */
    'insertarNuevoGrupo': true,
    /**
     * nombre del grupo de sinonimos si es que se va a editar un grupo
     */
    'nombreGrupo': '',
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
            //limpia el formulario
            form.limpiar();
            //carga los datos del area
            form.llenaSelect();
            //muestra el formulario
            $("#formulario-sinonimos-crear").dialog("open");
        });
        // para agregar campos
        $('#formulario-sinonimos-crear').bind("adicionar:campos", function(e, nombreGrupo) {
            form.limpiar();
            form.cargarDatos(false, nombreGrupo);
            form.llenaSelect();
            $("#formulario-sinonimos-crear").dialog("open");
        });
        // para el cierre del formulario
        $('#formulario-sinonimos-crear').bind("cerrar", function() {
            form.cerrar();
        });
    },
    /**
     * Destruir eventos
     */
    'destruirEventos': function() {
        $('#formulario-sinonimos-crear').unbind("mostrar");
        $('#formulario-sinonimos-crear').unbind("adicionar:campos");
        $('#formulario-sinonimos-crear').unbind("cerrar");
    },
    /**
     * Metodo al cerrar el formulario
     */
    'cerrar': function() {
        // formatea los datos en objeto javascript
        var nombre = $('#sinonimos_nombre').val();
        var sinonimo = {}
        sinonimo[nombre] = {};
        $('#sinonimos_campos option:selected').each(function(i, el) {
            sinonimo[nombre][$(this).attr("class")] = {
                'campo': $(this).val(),
                'lista': 0
            };
        });
        // llama al evento de la clase sinonimos que modifica la variable estado
        if (this.insertarNuevoGrupo){
            $('#sinonimos').trigger("agregar", sinonimo);
        }else{
            $('#sinonimos').trigger("modificar", {'sinonimo': sinonimo, 'nombreGrupo': this.nombreGrupo});
        }
    },
    /**
     * Destruye el objeto
     */
    'destruir': function() {
        this.destruirEventos();
    },
    /**
     * Limpia los datos del formulario: "nombre" del sinonimo y vacia el select "campos"
     */
    'limpiar': function() {
        $('#sinonimos_nombre').val("");
        $('#sinonimos_campos').html("");
    },
    /**
     * Llena el select de seleccion de columnas
     */
    'llenaSelect': function() {
        //llena el select multiple
        var html = "";
        var campos = estado.area.encabezado.campos;
        for (var k in campos) {
            html += "<option class='" + k + "'>" + campos[k].campo + "</option>";
        }
        $('#sinonimos_campos').append(html);
        // y deshabilita los seleccionados por estado.area
        var sinonimos = estado.area.encabezado.sinonimos;
        for (var k in sinonimos) {
            for (var m in sinonimos[k]) {
                $('#sinonimos_campos option.' + m).attr("disabled", true);
            }
        }
    },
    'cargarDatos': function(insertarGrupo, nombreGrupo) {
        this.insertarNuevoGrupo = insertarGrupo;
        this.nombreGrupo = nombreGrupo;
        $('#sinonimos_nombre').val(nombreGrupo);
    }
};
