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
        // para agregar grupos de sinonimos
        $("#sinonimos").bind("agregar", function(e) {
            sin.agregar();
        });
        $("#sinonimos").bind("modificar", function(e, grupoNombre) {
            sin.modificar(grupoNombre);
        });
        // para borrar un solo sinonimo de un grupo
        // recibe el nombre de la celda a eliminar en el formato "fila_columna"
        $('#sinonimos').bind("borrar:sinonimo", function(e, el) {
            sin.borrarSinonimo(el);
        });
    },
    /**
     * Destrucción de eventos
     */
    'destruirEventos': function() {
        $("#sinonimos").unbind("agregar");
        $("#sinonimos").unbind("modificar");
        $('#sinonimos').unbind("borrar:sinonimo");
    },
    /**
     * agrega un grupo de sinonimos
     * @param DOM grupoSinonimo #Sinonimo a agregar
     */
    'agregar': function() {
        var sin = this;
        var nombre = $('#sinonimos_nombre').val();
      
        if (!this.nombreGrupoEsUnico(nombre) || nombre == "") 
            return false;

        this.construirGrupo(nombre);
    },
    /**
     *
     */
    'modificar': function(grupoNombre) {
        this.construirGrupo(grupoNombre);
        var nombre = $('#sinonimos_nombre').val();
        if (nombre != grupoNombre) {
            for (var k in estado.area.encabezado.sinonimos[grupoNombre]) {
                estado.area.encabezado.sinonimos[nombre][k] = estado.area.encabezado.sinonimos[grupoNombre][k];
            }
            //borra el objeto anterior
            delete(estado.area.encabezado.sinonimos[grupoNombre]);
        }
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
