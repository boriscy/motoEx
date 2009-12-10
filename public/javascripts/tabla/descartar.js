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
                desc.marcarArea();
                //desc.mostrarFormulario();
            }
        });
        $('#area-fin').bind("desmarcar:fin:desc", function() { desc.desmarcarFin(); });
        // para desmarcar menu contextual y css alternativo
        $('.context-' + this.cssMarcarAlt).live("click", function(e) {
            desc.desmarcarArea(desc.cssMarcar, e);
        });
        // estado
        $('#area-descartar').bind("actualizar:estado", function(){ 
            desc.actualizarEstado();
        });
        // patrones en el grid
        $('#area-descartar').bind("actualizar:patrones", function(){ 
            desc.actualizarPatrones();
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
     * @param String cssSel
     */
    'marcarArea': function(cssSel) {
        desc = this;
        var cssID = 'desc' + this.contador;
        cssSel = cssSel || this.cssSeleccionado;
        // Iterar
        $('.' + cssSel + ':first').siblings('td.' + this.area.cssMarcar).andSelf().addClass(cssID);
        var filas = $('tr td.' + cssID + ':nth-child(3)').parents("tr").length;

        this.marcarAreaSinID(cssID, filas);
        desc.contador++;
        this.cambiarEstado(cssID);
        // Quitar css seleccionado
        $('.' + this.cssSeleccionado).removeClass(this.cssSeleccionado);
    },
    /**
     * marca un css sin aumentar el id en la clase
     * @param String css
     * @param Integer filas
     */
    'marcarAreaSinID': function(css, filas) {
        filas = filas || 1;
        $('.' + css).addClass(this.cssMarcar);
        // Para cambiar el estilo en caso de que sea fin
        $('.' + css + '[class*=' + this.area.fin.cssMarcar + ']').removeClass(this.cssMarcar).addClass(this.cssMarcarAlt);
        // Marcar con clase especial
        if(filas == 1)
            $('.' + css).addClass(desc.cssMarcarOpts);
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
     * Actualiza la variable estado para el area de descarte 'area'
     * param String area
     */
    'actualizarEstado': function(){
        var area = $("#id-descartar").val();
        if(!estado.area.descartar[area]['campos'])
            estado.area.descartar[area]['campos']= {};
        $('#formulario-descartar .listado li').each(function (i, el) {
            var $el = $(el);
            var pos = $el.attr("class");
            var texto = $el.find('span:first').text();
            estado.area.descartar[area]['campos'][pos] = {'texto': texto};
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
    },
    /**
     * Actualiza las celdas que cumplen con el patron
     */
    'actualizarPatrones': function() {
        var id = $('#id-descartar').val();
        var campos = estado.area[this.serialize][id];
        try {
            var min = parseInt(estado.area.encabezado.celda_final.split("_")[0]);
        }catch(e) {
            var min = parseInt(estado.area.celda_inicial.split("_")[0]);
        }
        var max = parseInt(estado.area.celda_final.split("_")[0]);
        if( campos ) {
            campos = campos.campos;
            console.log(campos);
            for(var i = min; i < max; i++) {
                var pass = true;
                for(var k in campos) {
                    var pos = k.split("_");
                    pos[1] = i + 1;
                    var $td = $('#' + pos.join("_"));
                    if( campos[k].texto != $td.text()) {
                        pass = false;
                        break;
                    }
                }
                // Marcar fila
                if(pass) {
                    $td.siblings('.' + this.area.cssMarcar).andSelf().addClass(id);
                    this.marcarAreaSinID(id);
                }
            }
        }
    }
});
