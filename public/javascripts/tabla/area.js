/**
 * Clase madre de la cual heredan todas las demas areas
 */
var Area = Class.extend({
    /**
     * Variables
     */
    'celdaInicial': '',
    'celdaFinal': '',
    'cssSeleccionado': 'sel',
    'cssMarcar': '',
    'areaMinima': 1,
    'iterarFila': true,
    /**
     * Indica como esta serializado el campo en la BD, que esta almacenado
     * en la variable global "estado" si esta vacio no produce cambios
     * pero en caso de que contenga un valor se mapea de la siguiente forma:
     * Ej.
     *    serialize: 'encabezado' => estado.area.encabezado
     */
    'serialize': '',
    /**
     * Constructor que esta intimamente ligado a la variable global "estado"
     * en la cual se almancena las respuestas de la BD en formato JSON
     * @param String ini
     * @param String fin
     */
    'init': function(ini, fin) {
        // Llamada JSON
        if(this.serialize!= '') {
            if(estado.area[this.serialize]) {
                if (this.serialize != 'descartar'){
                    this.celdaInicial = estado.area[this.serialize].celda_inicial;
                    this.celdaFinal = estado.area[this.serialize].celda_final;
                    this.marcarCeldas(this.celdaInicial, this.celdaFinal, this.cssMarcar);
                }
            }else {
                estado.area[this.serialize] = {};
            }
        }else{
            if(estado['area'] ) {
                this.celdaInicial = estado.area.celda_inicial;
                this.celdaFinal = estado.area.celda_final;
                this.marcarCeldas(this.celdaInicial, this.celdaFinal, this.cssMarcar);
            }else {
                estado['area'] = {};
                this.marcarArea(this.cssMarcar);
            }
        }

        var area = this;
        // Evento para menu contextual
        $('.context-' + this.cssMarcar).live("click", function(e) {
            area.desmarcarArea(area.cssMarcar, e);
            if (area.serialize == ''){
                //si es area general => elimina la variable area del objeto Iniciar
                $('body').trigger('eliminar:area');
                $('#sheet-' + hoja_numero).trigger("destruir:area");
            }
        });
    },
    /**
     * Aciciona una clase css a un area
     */
    'marcarArea': function(css, cssSel) {
        // Validacion de area minima
        if(!this.validarAreaMinima)
            return false;
        cssSel = cssSel || this.cssSeleccionado;
        $('.' + cssSel).addClass(css);
        $('.' + cssSel).removeClass(cssSel);
        this.cambiarEstado();
    },
    /**
     * Elimina la clase css de un area 
     * @param String css
     * @param Event e
     */
    'desmarcarArea': function(css, e) {
        css = css || this.cssSeleccionado;
        $('.' + css).removeClass(css);
        this.borrarAreaEstado();
        // Elimina el evento de menu contextual
        $('.context-' + this.cssMarcar).expire("click");
    },
    /**
     * Cambia la variable global estado
     */
    'cambiarEstado': function() {
        var puntos = this.obtenerPuntos(this.cssMarcar);
        if(this.serialize != '') {
            estado.area[this.serialize]['celda_inicial'] = puntos[0];
            estado.area[this.serialize]['celda_final'] = puntos[1];
            estado.area[this.serialize]['celdas'] = this.listaCeldas();
        }else {
            estado.area['celda_inicial'] = puntos[0];
            estado.area['celda_final'] = puntos[1];
        }
    },
    /**
     * Lista de celdas que incluye
     */
    'listaCeldas': function() {
        var lista = [];
        $('.' + this.cssMarcar).each(function(i, el) {
            lista[i] = {'texto': $(el).text().trim(), 'pos': $(el).attr("id").replace(/^\d+_(\d_\d+)$/, "$1") };
        });
        return lista;
    },
    /**
     * Inicializa en 0 los valores del estado
     */
    'borrarAreaEstado': function() {
        if(this.serialize != '') {
            estado.area[this.serialize] = {};
        }else{
            estado.area = {};
        }
    },
    /**
     * marca con el css indicado desde el inicio al fin
     * @param String inicio
     * @parma String fin
     * @param String css
     */
    'marcarCeldas': function(inicio, fin, css) {
        if(!inicio && !fin)
            return false;
        inicio = inicio.split("_");
        fin = fin.split("_");
        
        var iIni = parseInt(inicio[0]);
        var iFin = parseInt(fin[0]);
        var jIni = parseInt(inicio[1]);
        var jFin = parseInt(fin[1]);

        for(var i = iIni; i <= iFin; i++) {
            for(j = jIni; j <= jFin; j++) {
                $('#' + hoja_numero + '_' + i + '_' + j).addClass(css);
            }
        }
    },
    /**
     * Valida la inclusion de un area en otra
     * @param String css # clase del area donde incluir
     * @return Boolean
     */
    'validarInclusion': function(css) {
        var area1 = $('.' + this.cssSeleccionado + '[class*=' + css + ']').length; 
        var area2 = $('.' + this.cssSeleccionado).length;  

        if (area1 != area2){
            return false;
        }
        return true;
    },
    /**
     * Verifica de que haya un area minima seleccionada
     * @return Boolean
     */
    'validarAreaMinima': function() {
        return $('.' + this.cssSeleccionado).length >= this.areaMinima;
    },
    /**
     * Valida que dos areas marcadas solo esten marcadas una vez
     * @param Array estilos
     * @return Boolean
     */
    'validarSolapamiento': function(estilos) {
        if(isArray(estilos)){
            for (var k in estilos){
                if ($('.' + this.cssSeleccionado + '[class*=' + estilos[k] + ']').length > 0)
                    return false;
            }
        }else{
            return false;
        }
        return true;
    },
     /**
     * Obtiene el punto inicial y final del area
     * @param String css
     * @return Array
     */
    'obtenerPuntos': function(css) {
        arr = [];
        try{
            arr.push(this.punto( $('.' + css + ':first').attr("id") ) );
            var $fin = $('.' + css + ':last');
            var punto = $fin.attr("id");
            var pp = punto.split("_");

            if ($fin.attr('colspan') && $fin.attr('colspan') > 1){
                pp[2] = parseInt(pp[2]) + parseInt($fin.attr('colspan')) - 1;
            }
            if ($fin.attr('rowspan') && $fin.attr('rowspan') > 1){
                pp[1] = parseInt(pp[1]) + parseInt($fin.attr('rowspan')) - 1;
            }

            punto = pp.join("_");
            arr.push(this.punto( punto ) );
        }catch(e){
            arr[0] = "", arr[1] = "";
        }

        return arr;
    },
    /**
    * Retorna el id de la celda sin hoja
    * @return String
    */
    'punto': function(p) {
        return p.replace(/^\d+_([\d_]+)$/, "$1");
    },
    /**
     * Destructor que elimina eventos y areas marcadas
     */
    'destruir': function() {
        this.destruirEventos();
        this.desmarcarArea(this.cssMarcar);
    },
    /**
     * Obtiene el borde del area
     * return Object
     */
    'obtenerBordes': function() {
        var ini = this.celdaInicial.split("_");
        var fin = this.celdaFinal.split("_");
        return {'filaInicial': ini[0], 'filaFinal': fin[0], 'columnaInicial': ini[1], 'columnaFinal': fin[1] }
    }
});

