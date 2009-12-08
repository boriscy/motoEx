/**
 * Clase que permite la creación de areas descartables
 * - Cuando se selecciona por defecto utiliza el css "bg-red"
 * - Para cada selección tambien se debe crear un cssID
 */
var Descartar = Area.extend({
    'serialize': 'descartar',
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
        this._super();
        this.crearEventos();
        estado.area[this.serialize] = {};
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
        $('#area-fin').bind("desmarcar:fin:desc", function() { desc.desmarcarFin(); });
        // para desmarcar menu contextual y css alternativo
        $('.context-' + this.cssMarcarAlt).live("click", function(e) {
            desc.desmarcarArea(desc.cssMarcar, e);
        });
    },
    /**
     * Destruccion de eventos
     */
    'destruirEventos': function() {
        /*$('#area-descartar').unbind("marcar:descartar");
        $('.context-' + this.cssMarcar).expire("click");
        $('.context-' + this.cssMarcarAlt).expire("click");*/
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
        this.cambiarEstado(cssEsp);
        // Quitar css seleccionado
        $('.' + this.cssSeleccionado).removeClass(this.cssSeleccionado);
    },
    /**
     * Funcion para pode desmarcar un area especifica
     * @param String css
     * @param Event e
     */
    'desmarcarArea': function(css, e) {
        var target = getEventTarget(e);
        var css = $(target).attr("class").replace(/.*(desc\d+).*/, "$1");
        $('.' + css).removeClass(css).removeClass(this.cssMarcar).removeClass(this.cssMarcarAlt).removeClass(this.cssMarcarOpts);
        this.borrarAreaEstado(css);
        this.destruir();
    },
    /**
     * Para marcar cambiar el css del area que tenia fin
     */
    'desmarcarFin': function() {
        $fin = $('.' + this.area.fin.cssMarcar)
        if($fin.hasClass(this.cssMarcarAlt))
            $fin.removeClass(this.cssMarcarAlt).addClass(this.cssMarcar);
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
     * @param String cssEsp # css para poder definir el id
     */
    'cambiarEstado': function(cssEsp) {
        var desc = this;
        var puntos = this.obtenerPuntos(cssEsp);
        estado.area[this.serialize][cssEsp] = {'celda_inicial': puntos[0], 'celda_final': puntos[1], 'celdas': []};
        $('.' + cssEsp).each(function(i, el) {
              var $el = $(el);
              estado.area[desc.serialize][cssEsp].celdas.push({'id': $el.attr("id"), 'texto': $el.text()});
        });
    },
    /**
     * Elimina el area de la variable global estado
     * @param String cssEsp # css para poder definir el id
     */
    'borrarAreaEstado': function(cssEsp) {
        delete(estado.area[this.serialize][cssEsp]);
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
