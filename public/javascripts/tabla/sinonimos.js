/**
 * Clase para poder manejar los Sinonimos de los encabezados
 * maneja directamente la variable estado.area.encabezado.sinonimos
 * y cada vez que se modifica la misma, llama a los eventos correspondientes del formulario-sinonimos
 */
Sinonimos = function() {
    this.init();
}

Sinonimos.prototype = {
    'contador': 1,
    /**
     * Constructor
     */
    'init': function() {
        this.crearEventos();
    },
    /**
     * Destructor
     */
    'destruir': function() {
        this.destruirEventos();
    },
    /**
     * Creacion de eventos
     */
    'crearEventos': function() {
        var sin = this;
        //solo guarda los sinonimos con estado.area
        $("#lista-sinonimos-mapeo").bind("guardar", function() {
            sin.guardar();
        });
    },
    
    'guardar': function() {
        // guarda los datos del formulario en estado.area
        $fieldsets = $('div#lista-sinonimos-mapeo fieldset');
        sinonimos = {};
        $fieldsets.each(function(i, el) {
            var s = $(el).find('input.sinonimo-id').val();
            sinonimos[s] = {};
            $(el).find('table tr:not(:first)').each(function(k, fila) {
                var $fila = $(fila);
                var campo = $fila.find('select.campo-buscado').val();
                sinonimos[s][campo] = [];
                $fila.find('.campos-busqueda option:selected').each(function(m, busqueda) {
                    sinonimos[s][campo].push($(busqueda).val());
                });
            });
        });
        estado.area['sinonimos'] = sinonimos;
    },
    
    /**
     * Destrucción de eventos
     */
    'destruirEventos': function() {
        $("#lista-sinonimos-mapeo").unbind("guardar");
    }
    /*,
    'nombreGrupoEsUnico': function(nombre) {
        var sinonimos = estado.area.encabezado.sinonimos;
        for (var k in sinonimos) {
            if (k == nombre)
                return false;
        }
        return true;
    },
    'buscaNumeroSinonimo': function(grupo, campo) {
        var grupo = estado.area.encabezado.sinonimos[grupo];
        for (var k in grupo) {
            if (grupo[k].campo == campo) {
                return k;
            }
        }
    }*/
}
