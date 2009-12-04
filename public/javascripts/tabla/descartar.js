/**
 * Clase que permite la creación de areas descartables
 * - Cuando se selecciona por defecto utiliza el css "bg-red"
 * - Para cada selección tambien se debe crear un cssID
 */
var Descartar = Area.extend({
    'serialize': 'no_importar',
    'area': false,
    /**
     * Clase css para marcar
     */
    'cssMarcar': 'bg-red-color',
    /**
     * clase css utilizada cuando se solapa en area fin
     */
    'cssMarcarAlt': 'border-red-top',
    /**
     * css para poder indicar si la fila permite opciones
     */
    'cssMarcarOpts': 'opciones-',
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
        this.cssMarcarOpts = 'opciones-' + this.cssMarcar;
        this.crearEventos();
    },
    /**
     * Creación de eventos
     */
    'crearEventos': function() {
        var desc = this;
        $('#area-descartar').bind('marcar:descartar', function() {
            if (desc.validarInclusion(desc.area.cssMarcar) && 
                desc.validarSolapamiento([desc.area.encabezado.cssMarcar, desc.area.titular.cssMarcar, desc.cssMarcar]) ) {
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
        var cssEsp = 'desc' + this.contador;
        var max = 0;
        // Iterar
        $('.' + this.cssSeleccionado).parent('tr').each(function(i, el) {
            $(el).find("td." + desc.area.cssMarcar).addClass(desc.cssMarcar).addClass(cssEsp);
            max = i;
        });
        // Para cambiar el estilo en caso de que sea fin
        $('.' + cssEsp + '[class*=' + desc.area.fin.cssMarcar + ']').removeClass(desc.cssMarcar).addClass(desc.cssMarcarAlt);
        // Marcar con clase especial
        if(max == 0)
            $('.' + cssEsp).addClass(desc.cssMarcarOpts);
        
        desc.contador++;
        estado.area.descartar = [{}];
        // Quitar css seleccionado
        $('.' + this.cssSeleccionado).removeClass(this.cssSeleccionado);
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
