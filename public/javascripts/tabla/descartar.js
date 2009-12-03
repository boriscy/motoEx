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
            if(desc.validarInclusion(desc.area.cssMarcar) && desc.validarSolapamiento([desc.area.encabezado.cssMarcar, desc.area.titular.cssMarcar]) ) {
                desc.marcarArea(desc.cssMarcar);
                desc.mostrarFormulario();
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
    'marcarArea': function(cssSel) {
        desc = this;
        var cssEsp = 'desc' + desc.contador;
        // Iterar
        $('.' + this.cssSeleccionado).parent('tr').each(function(i, el) {
            $(el).find("td." + desc.area.cssMarcar).addClass('desc'+desc.contador).addClass(desc.cssMarcar);
        });
        $('.' + cssEsp + '[class*=' + desc.area.fin.cssMarcar + ']').removeClass(desc.cssMarcar).addClass(desc.cssMarcarAlt);
        desc.contador++;
        estado.area.descartar = [{}];
    },
    /**
     * Obtiene toda la fila del area seleccionada 
     */
    'obtenerFila': function(el) {
        var ini = $('.' + this.area.cssMarcar).parent('tr td:first').attr("id");
        var fin = $('.' + this.area.cssMarcar).parent('tr td:last').attr("id");
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
    },
    /**
     * Muestra el formulario para patrón
     */
    'mostrarFormulario': function() {
        $('#formulario-descartar').trigger("formulario:mostrar");
    }
});
