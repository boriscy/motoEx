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
     * css para poder indicar si la fila permite opciones
     */
    'cssMarcarOpts': 'opciones-',
    /**
     * contador de areas
     */
    'contador': 0,
    /**
     * Guarda las excepciones por cada area de descarte
     */
    'excepciones': {},
    /**
     * Constructor
     * @param Array areas
     */
    'init': function(areas, area) {
        
        this.area = area;
        this.cssMarcarOpts = 'opciones-' + this.cssMarcar;
        this.serialize = 'descartar';
        this._super();
        this.crearEventos();
        // si estado.area[this.serialize] carga los datos de las areas de descarte
        if (estado.area[this.serialize]) {
            var max = 0;
            for (var k in estado.area[this.serialize]){
                // si es que tuviera patrones actualiza las celdas correspondientes
                $('#id-descartar').val(k);
                this.actualizarTablaPatrones();
                // aumenta el contador
                this.contador = parseInt(k.replace(/.*desc(\d+).*/, "$1"));
                if (this.contador > max)
                    max = this.contador;
                // marca cada area
                // selecciona la primera celda (para ejecutar el mismo algoritmo)
                $('.' + this.cssSeleccionado).removeClass(this.cssSeleccionado);
                $('#' + hoja_numero + '_' + estado.area[this.serialize][k]['celda_inicial']).addClass(this.cssSeleccionado);
                this.marcarArea();
                //actualiza el contador
                this.contador = max + 1;
            }
            $('.' + this.cssSeleccionado).removeClass(this.cssSeleccionado);
        }
    },
    /**
     * Creación de eventos
     */
    'crearEventos': function() {
        var base = this;
        $('#area-descartar').bind('marcar:descartar', function() {
            if (base.validarInclusion(base.area.cssMarcar) && 
                base.validarSolapamiento([base.area.titular.cssMarcar, base.area.encabezado.cssMarcar, base.cssMarcar, base.area.fin.cssMarcar]) ) {
                
                base.marcarArea();
            }
        });
        // estado
        $('#area-descartar').bind("actualizar:estado", function(){ 
            base.actualizarEstado();
        });
        // patron en el grid
        $('#area-descartar').bind("actualizar:tabla:patrones", function(){ 
            base.actualizarTablaPatrones();
        });
        // patrones
        $('#area-descartar').bind("actualizar:patron", function(){ 
            base.actualizarEstadoPatron();
        });
        // creacion de excepciones
        $('#area-descartar').bind("descartar:crear:excepcion", function() {
            base.crearExcepcion();
        });
    },
    /**
     * Destruccion de eventos
     */
    'destruirEventos': function() {
        // marcado de descartes
        $('#area-descartar').unbind('marcar:descartar');
        // actualizacion de estados
        $('#area-descartar').unbind("actualizar:estado");
        // patron en el grid
        $('#area-descartar').unbind("actualizar:tabla:patrones");
        // patrones
        $('#area-descartar').unbind("actualizar:patron");
        // creacion de excepciones
        $('#area-descartar').unbind("descartar:crear:excepcion");
    },
    /**
     * Marca el area seleccionada y añade un ID en forma de clase css
     * @param String cssSel
     */
    'marcarArea': function(cssSel) {
        var cssID = 'desc' + this.contador;
        cssSel = cssSel || this.cssSeleccionado;
        // Iterar
        $('.' + cssSel + ':first').siblings('td.' + this.area.cssMarcar).andSelf().addClass(cssID);
        var filas = $('tr td.' + cssID + ':nth-child(3)').parents("tr").length;

        this.marcarAreaSinID(cssID, filas);
        this.contador++;
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
        // Marcar con clase especial
        if(filas == 1)
            $('.' + css).addClass(this.cssMarcarOpts);
    }, 
    /**
     * Funcion para pode desmarcar un area especifica
     * @param String css
     * @param Event e
     */
    'desmarcarArea': function(css, e) {
        var target = getEventTarget(e);
        var css = $(target).attr("class").replace(/.*(desc\d+).*/, "$1");
        if (css != ""){
            $('.' + css).removeClass(css).removeClass(this.cssMarcar).removeClass(this.cssMarcarOpts);
            this.borrarAreaEstado(css);
        }
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
        if (!(estado.area[this.serialize][cssEsp])) {
            var puntos = this.obtenerPuntos(cssEsp);
            estado.area[this.serialize][cssEsp] = {'celda_inicial': puntos[0], 'celda_final': puntos[1], 'patron': {}, 'excepciones' : [] };
        }
    },
    /**
     * Actualiza la variable estado para el area de descarte 'area'
     * param String area
     */
    'actualizarEstado': function(){
        var area = $("#id-descartar").val();
        this.actualizarEstadoPatron();
    },
    /**
     * actualiza los patron de una area de descarte
     * en base a la lista en el  #formulario-descartar
     */
    'actualizarEstadoPatron': function() {
        var base = this;
        var area = $("#id-descartar").val();
        
        //primero elimina todos los patrones
        for (var k in estado.area.descartar[area]['patron']) {
           delete(estado.area.descartar[area]['patron'][k]);
        }
        
        $('#formulario-descartar .listado li').each(function (i, el) {
            var $el = $(el);
            /**
             * Aquí debe guardarse la fila o la columna de acuerdo a lo que se selecciona en el formulariio principal 
             */
            var pos = $el.attr("class").split("_")[2]; // Obtener columna

            var texto = $el.find('span:first').text().trim();

            estado.area.descartar[area]['patron'][pos] = {'texto': texto};
            
            estado.area[base.serialize][area].excepciones = [];
            // Excepciones del patron
            $('ul.grupo-excepcion').each(function(i, el) {
                estado.area[base.serialize][area].excepciones[i] = [];
                $(el).find('li.excepcion').each(function(ii, elem) {
                    // Campo oculto
                    var col = $(elem).find("span.col").text().trim();
                    var texto = $(elem).find("span.texto").text().trim();
                    // en la excepcion "pos" puede ser fila o columna
                    estado.area[base.serialize][area].excepciones[i].push({'pos': col, 'texto': texto});
                });
            });
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
        $('.' + this.cssMarcar).removeClass(this.cssMarcar);
        $('.' + this.cssMarcarOpts).removeClass(this.cssMarcarOpts);
        for (var i = 0; i < this.contador; i++){
            $('.desc' + i).removeClass('desc' + i);
        }
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
    'actualizarTablaPatrones': function() {
        var id = $('#id-descartar').val();
        $('.' + id).removeClass(id).removeClass(this.cssMarcar).removeClass(this.cssMarcarOpts);
        
        var campos = estado.area[this.serialize][id];
        var limites = this.crearLimitesCelda(id);
        var min, max, temp;
        
        min = this.obtenerIteracion(estado.area.celda_inicial);
        // min es la celda desde donde se empieza la busqueda de patrones
        if (estado.area.encabezado.celda_inicial){
            temp = this.obtenerIteracion(estado.area.encabezado.celda_final) + 1;
            if (temp > min)
                min = temp;
        }
        if (estado.area.titular.celda_inicial){
            temp = this.obtenerIteracion(estado.area.titular.celda_final) + 1;
            if (temp > min)
                min = temp;
        }
        // max es la celda desde donde se termina la busqueda de patrones
        if (estado.area.fin.celda_inicial){
            max = this.obtenerIteracion(estado.area.fin.celda_inicial) - 1;
        }else{
            max = this.obtenerIteracion(estado.area.celda_final);
        }
        //marca las celdas de inicial a final (solo una fila/columna)
        var iteracion = this.obtenerIteracion(campos.celda_inicial);
        
        for (var k = limites[0]; k <= limites[1]; k++){
            var pos = this.construirPosicion(k, iteracion);
            $('#' + pos).addClass(id).addClass(this.cssMarcar).addClass(this.cssMarcarOpts);
        }
        if( campos ) {
            for(var i = min; i <= max; i++) {
                var pass = true;
                for(var k in campos.patron) {
                    var pos = this.construirPosicion(k, i);
                    //construye la celda a comparar el patron
                    var $td = $('#' + pos);
                    if( campos.patron[k].texto != $td.text().trim()) {
                        pass = false;
                        break;
                    }
                }
                // Acelera el proceso, no es necesario buscar excepciones si no encuentra el patron
                if(pass)
                    pass = this.actualizarTablaExcepciones(campos.excepciones, i);
                // Marcar fila
                if(pass) {
                    // TODO: solo marca por filas (no funciona si se itera columnas)
                    if ($td){
                        $td.siblings('.' + this.area.cssMarcar).andSelf().addClass(id);
                        this.marcarAreaSinID(id);
                    }
                }
            }
        }
    },
    /**
     * verifica que cumplan las excepciones
     * @param Array
     */
    'actualizarTablaExcepciones': function(excepciones, pos) {
        //busca excepciones
        var marcar = true;
        for (var k in excepciones) { //grupos de excepciones
            marcar = false;
            //que cumpla con todos las excepciones
            for (var n in excepciones[k]) {
                var tmppos = this.construirPosicion(excepciones[k][n].pos, pos);
                if (excepciones[k][n].texto != $('#' + tmppos).text().trim()) {
                    marcar = true;
                    break;
                }
            }
            if (!marcar){
                break;
            }
        }
        return marcar;
    },
    /**
     * Construye la posicion para la celda en base a si se itera filas o columnas
     * @param Integer pos # Fila o columna
     * @param Integer iteracion # posicion actual
     */
    'construirPosicion': function(pos, iteracion) {
        var tmppos = [hoja_numero];
        if(this.area.iterarFilas) {
            tmppos.push(iteracion);
            tmppos.push(pos);
        }else{
            tmppos.push(pos);
            tmppos.push(iteracion);
        }
        return tmppos.join("_");
    },
    /**
     * @return Array 
     */
    'crearLimitesCelda': function(area) {
        var inicio = estado.area.descartar[area].celda_inicial.split("_"),
        fin = estado.area.descartar[area].celda_final.split("_");
        
        if( estado.area['iterar_fila'] ) {
            return [parseInt(inicio[1]), parseInt(fin[1])];
        }else{
            return [parseInt(inicio[0]), parseInt(fin[0])];
        }
    },
    /**
     * Obtiene el valor que esta iterando de una celda
     * @param String celda #id de la celda a buscar de la forma "fila_columna"
     * @return Int #numero de fila o columna a iterar
     */
    'obtenerIteracion': function(celda2) {
        var c = celda2.split("_");
        if( estado.area['iterar_fila'] ) {
            return parseInt(c[0]);
        }else{
            return parseInt(c[1]);
        }
    }
});
