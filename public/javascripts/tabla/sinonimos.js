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
        /*
        // para agregar sinonimos
        $("#sinonimos").bind("agregar", function() {
            sin.agregar();
        });
        // para borrar sinonimos
        $("#sinonimos").bind("borrar", function(sinonimoId) {
            sin.borrar(sinonimoId);
        });
        // para agregar campos a un sinonimos
        $("#sinonimos").bind("agregar:campo", function(e, sinonimoId) {
            sin.agregarCampo(sinonimoId);
        });
        // para agregar campos a un sinonimos
        $("#sinonimos").bind("borrar:campo", function(e, sinonimoIdCampoId) {
            sin.borrarCampo(sinonimoIdCampoId);
        });
        // para borrar un solo sinonimo de un grupo
        // recibe el nombre de la celda a eliminar en el formato "fila_columna"
        $('#sinonimos').bind("borrar:sinonimo", function(e, el) {
            sin.borrarSinonimo(el);
        });
        */
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
        $("#sinonimos").unbind("agregar");
        $("#sinonimos").unbind("borrar");
        $("#sinonimos").unbind("agregar:campo");
        $("#sinonimos").unbind("borrar:campo");
    },
    /**
     * agrega un sinonimo
     */
    'agregar': function(sinonimoId) {
        estado.area.encabezado.sinonimos[sinonimoId] = {};
    },
    'borrar': function(sinonimoId) {
        delete(estado.area.encabezado.sinonimos[sinonimoId]);
    },
    'agregarCampo': function(sinonimoId, campoNombre) {
        
    },
    /**
     * Borra un sinonimo de un grupo de Sinonimos
     * @param String nombreCelda
     */
    'borrarSinonimo': function(el) {
        var sinonimos = estado.area.encabezado['sinonimos'];
        var encontrado = false;
        //buscamos el parent
        var grupo = $(el).parents("fieldset").find("legend").text();
        var sinonimo = $(el).attr("rel");
        var numero = this.buscaNumeroSinonimo(grupo, sinonimo);
        // borra la variable de estado.area
        delete(estado.area.encabezado.sinonimos[grupo][numero]);
        // para el parent correspondiente cuenta si quedan mas elementos
        var contador = 0;
        for (x in estado.area.encabezado.sinonimos[grupo]){
            contador++;
            break;
        }
        // si no quedan elementos elimina el grupo
        if (contador == 0) {
            delete(estado.area.encabezado.sinonimos[grupo]);
        }
    },

    'construirGrupo': function(nombre) {
        var sin = this;
        if(!estado.area.encabezado.sinonimos[nombre])
            estado.area.encabezado.sinonimos[nombre] = {};
        $('#sinonimos_campos option:selected').each(function(i, el) {
            estado.area.encabezado.sinonimos[nombre][sin.contador] = {
                'pos': $(this).attr("class"),
                'campo': $(this).val(),
                'lista': 0
            };
            sin.contador++;
        });
    },

    'nombreGrupoEsUnico': function(nombre) {
        var sinonimos = estado.area.encabezado.sinonimos;
        for (var k in sinonimos) {
            if (k == nombre)
                return false;
        }
        return true;
    },
    /**
     *
     */
    'buscaNumeroSinonimo': function(grupo, campo) {
        var grupo = estado.area.encabezado.sinonimos[grupo];
        for (var k in grupo) {
            if (grupo[k].campo == campo) {
                return k;
            }
        }
    }
}
