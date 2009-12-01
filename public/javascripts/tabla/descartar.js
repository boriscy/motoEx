/**
 * Clase que permite la creación de areas descartables
 * - Cuando se selecciona por defecto utiliza el css "bg-red"
 * - Para cada selección tambien se debe crear un cssID
 */
var Descartar = Area.extend({
    'serialize': 'no_importar',
    'area': false,
    /**
     * clase css utilizada cuando se solapa en area fin
     */
    'cssMarcarAlt': 'border-red-top',
    /**
     * contador de areas
     */
    'contador': 0,
    /**
     * Constructor
     * @param Array areas
     */
    'init': function(areas, area) {
        this.area = area;
        this.cssMarcar = "bg-red-color";
        this.crearEventos();
    },
    /**
     * Creación de eventos
     */
    'crearEventos': function() {
        var desc = this;
        $('#area-descartar').bind('marcar:descartar', function() {
            if(desc.validarSolapamiento([desc.area.encabezado.cssMarcar, desc.area.titular.cssMarcar]) ) {
                desc.marcarArea(desc.cssMarcar);
            }
        });
    },
    /**
     * Destruccion de eventos
     */
    'destruirEventos': function() {
    },
    /**
     * Marca el area seleccionada y añade un ID en forma de clase css
     */
    'marcarArea': function() {
        var cssEsp = 'desc' + this.contador;
        $('.' + this.cssSeleccionado).addClass(cssEsp);
        // Marcar con una clase especial a todos los que se intersecten con area Fin
        var fin = $('.' + cssEsp + '[class*=' + this.area.fin.cssMarcar + ']');
        if( fin.length > 0 ) {
            $(fin).addClass(this.cssMarcarAlt);
        }
        $('.' + this.cssSeleccionado + ':not([class*=' + this.cssMarcarAlt + '])').addClass(this.cssMarcar);
        estado.area.descartar = [{}];
        this.contador++;
    },
    /**
     * Funcion especializada para cambiar el estado
     */
    'cambiarEstado': function() {
    },
    /**
     * Elimina el area y los eventos
     */
    'destruir': function() {
        this.destruirEventos();
    }
});
