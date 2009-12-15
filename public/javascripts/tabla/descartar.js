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
        if (estado.area[this.serialize]){
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
        //estado.area[this.serialize] = {};
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
        //$('#area-fin').bind("desmarcar:fin:desc", function() { desc.desmarcarFin(); });
        // para desmarcar menu contextual y css alternativo
        $('.context-' + this.cssMarcarAlt).live("click", function(e) {
            desc.desmarcarArea(desc.cssMarcar, e);
        });
        // estado
        $('#area-descartar').bind("actualizar:estado", function(){ 
            desc.actualizarEstado();
        });
        // patron en el grid
        $('#area-descartar').bind("actualizar:tabla:patrones", function(){ 
            desc.actualizarTablaPatrones();
        });
        // patrones
        $('#area-descartar').bind("actualizar:patron", function(){ 
            desc.actualizarEstadoPatron();
        });
        // creacion de excepciones
        $('#area-descartar').bind("descartar:crear:excepcion", function() {
            desc.crearExcepcion();
        });
    },
    /**
     * Destruccion de eventos
     */
    'destruirEventos': function() {
        /*$('#area-descartar').unbind("marcar:descartar");
        $('.context-' + this.cssMarcar).expire("click");
        $('.context-' + this.cssMarcarAlt).expire("click");*/
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
        //$('.' + css + '[class*=' + this.area.fin.cssMarcar + ']').removeClass(this.cssMarcar).addClass(this.cssMarcarAlt);
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
            //console.log("aki=>" + css);
            $('.' + css).removeClass(css).removeClass(this.cssMarcar).removeClass(this.cssMarcarAlt).removeClass(this.cssMarcarOpts);
            this.borrarAreaEstado(css);
        }
        //this.destruir();
    },
    /**
     * Para marcar cambiar el css del area que tenia fin
     */
    /*'desmarcarFin': function() {
        $fin = $('.' + this.area.fin.cssMarcar);
        if($fin.hasClass(this.cssMarcarAlt))
            $fin.removeClass(this.cssMarcarAlt).addClass(this.cssMarcar);
    },*/
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
        if (!(estado.area[this.serialize][cssEsp])){
            estado.area[this.serialize][cssEsp] = {'celda_inicial': puntos[0], 'celda_final': puntos[1], 'celdas': [], 'patron': {'excepciones': []}};
        }else{
            puntos[0] = estado.area[this.serialize][cssEsp]['celda_inicial'];
            puntos[1] = estado.area[this.serialize][cssEsp]['celda_final'];
        }
        estado.area[desc.serialize][cssEsp].celdas = [];
        //para todas las celdas entre la celda_inicial y la celda_final
        var x1 = puntos[0].split("_")[0], y1 = puntos[0].split("_")[1];
        var x2 = puntos[1].split("_")[0], y2 = puntos[1].split("_")[1];
        for (var i = x1; i <= x2; i++){
            for (var k = y1; k <= y2; k++){
              var $el = $("#" + hoja_numero + "_" + i + "_" + k);
              if ($el)
                  estado.area[desc.serialize][cssEsp].celdas.push({'id': $el.attr("id"), 'texto': $el.text()});
            }
        }
        /*$('.' + cssEsp).each(function(i, el) {
              var $el = $(el);
              estado.area[desc.serialize][cssEsp].celdas.push({'id': $el.attr("id"), 'texto': $el.text()});
        });*/
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
     */
    'actualizarEstadoPatron': function() {
        var area = $("#id-descartar").val();
        var desc = this;
        
        //primero elimina todos los patrones
        for (var k in estado.area.descartar[area]['patron']){
            if (k != "excepciones"){
                delete(estado.area.descartar[area]['patron'][k]);
            }
        }
        
        $('#formulario-descartar .listado li').each(function (i, el) {
            var $el = $(el);
            /**
             * Aquí debe guardarse la fila o la columna de acuerdo a lo que se selecciona en el formulariio principal 
             */
            var pos = $el.attr("class").split("_")[2];

            var texto = $el.find('span:first').text();

            estado.area.descartar[area]['patron'][pos] = {'texto': texto};

            // Excepciones
            estado.area[desc.serialize][area].patron['excepciones'] = [];
            $('ul.grupo-excepcion').each(function(i, el) {
                estado.area[desc.serialize][area].patron['excepciones'][i] = [];
                $(el).find('li.excepcion').each(function(ii, elem) {
                    // Campo oculto
                    var col = $(elem).find("span.col").text();
                    var texto = $(elem).find("span.texto").text();
                    estado.area[desc.serialize][area].patron['excepciones'][i].push({'col': col, 'texto': texto});
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
        $('.' + this.cssMarcarAlt).removeClass(this.cssMarcarAlt);
        $('.' + this.cssMarcarOpts).removeClass(this.cssMarcarOpts);
        for (var i = 0; i < this.contador; i++){
            $('.desc' + i).removeClass('desc' + i);
            //this.borrarAreaEstado('desc' + i);
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
        try {
            var min = parseInt(estado.area.encabezado.celda_final.split("_")[0]);
        }catch(e) {
            var min = parseInt(estado.area.celda_inicial.split("_")[0]);
        }
        var max = parseInt(estado.area.celda_final.split("_")[0]);
        
        //marca las celdas de inicial a final (solo una fila)
        var fila = estado.area[this.serialize][id]['celda_inicial'].split('_')[0];
        var ini = estado.area[this.serialize][id]['celda_inicial'].split('_')[1];
        var fin = estado.area[this.serialize][id]['celda_final'].split('_')[1];
        for (var k = ini; k <= fin; k++){
            $('#' + hoja_numero + '_' + fila + '_' + k).addClass(id).addClass(this.cssMarcar).addClass(this.cssMarcarOpts);
        }

        if( campos ) {
            var patron = campos.patron;
            for(var i = min; i < max; i++) {
                var pass = true;
                for(var k in patron) {
                    var pos = [];
                    pos[0] = hoja_numero; //hoja
                    pos[1] = i + 1; //fila
                    if(k == 'excepciones'){
                        //busca excepciones
                        for (var m in patron[k]){ //grupos de excepciones
                            //que cumpla con todos las excepciones
                            var total = patron[k][m].length;
                            var cumple = 0;
                            for (var n in patron[k][m]){
                                pos[2] = patron[k][m][n].col;
                                if (patron[k][m][n].texto == $('#' + pos.join("_")).text()){
                                    cumple++;
                                }
                            }
                            if (total == cumple){
                                pass = false;
                            }
                        }
                    }else{
                        //construye la celda a comparar el patron
                        pos[2] = k; //columna
                        var $td = $('#' + pos.join("_"));
                        if( patron[k].texto != $td.text()) {
                            pass = false;
                            break;
                        }
                    }
                }
                // Marcar fila
                if(pass) {
                    try{
                        $td.siblings('.' + this.area.cssMarcar).andSelf().addClass(id);
                        this.marcarAreaSinID(id);
                    }catch(e){}
                }
            }
        }
    },
    /**
     * Crea excepciones para un patron
     */
    'crearExcepcion': function() {}
});
