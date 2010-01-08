/**
 * Formulario general, clase principal a la cual todas
 * las clases estan realcionadas
 */
AreaGeneral = Area.extend({
    'formulario': false,
    'areaMinima': 4,
    'encabezado': false,
    'descartar': false,
    'titular': false,
    'fin': false,
    'iterarFilas': true,
    'sinonimos': false,
    
    'init': function(ini, fin) {
        this.cssMarcar = "bg-light-green";
        // Parent
        this._super(ini, fin);
        this.formulario = new FormularioArea(this);
        this.crearEventos();
        // Creación en caso de que no sea AJAX
        // Sub Areas
        this.titular= new Titular(false, false, this);
        this.encabezado = new Encabezado(false, false, this);
        this.fin = new Fin(false, false, this);
        this.descartar = new Descartar([], this);
        
        this.sinonimos = new Sinonimos();
        
        this.cambiarIterarFilas();
    },
    /**
     * Para poder cambiar iterarFila
     */
    'cambiarIterarFilas': function() {
        // Indica si itera fila
        this.iterarFilas = $('#formulario-areas input:radio:checked[name="area[iterar_fila]"]').val();
        estado.area['iterar_fila'] = this.iterarFilas;
    },
    /**
     * Eventos generales
     */
    'crearEventos': function() {
        var area = this;
        $("#sheet-" + hoja_numero).bind("destruir:area", function() {
            area.destruir();
        });
        $('#formulario-areas input:radio[name="area[iterar_fila]"]').live("click", function() {
            area.cambiarIterarFilas();
        });
    },
    /**
     * Llama a las funciones de destruccion de la areas dependientes
     */
    'destruirAreas': function() {
        var area = this;
        $(['encabezado', 'titular', 'descartar', 'fin']).each(function(i, el) {
            area[el].destruir();
        });
    },
    /**
     * Elimina los ventos creados en la clase
     */
    'destruirEventos': function() {
        $("#sheet-" + hoja_numero).unbind("destruir:area");
        $("#sheet-" + hoja_numero).unbind("marcar:area");
        $('#formulario-areas input:radio[name="area[iterar_fila]"]').die("click");
    },
    /**
     * Elimina todas las variables y desmarca
     */
    'destruir': function() {
        this._super();
        this.formulario.destruir();
        this.encabezado.destruir();
        this.titular.destruir();
        this.descartar.destruir();
        this.fin.destruir();
        
        this.sinonimos.destruir();
    },
    /**
     * Revisa si dos clases CSS se intersectan en algún elemento
     * @param String css1 # Nombre de la clase css elementos 1
     * @param String css2 # Nombre de la clase css elementos 2
     * @return Boolean # true, false
     */
    revisarInterseccionAlguno:function(css1, css2) {
        css1 = '.' + css1;
        css2 = css2 || this.cssSeleccionado;
        css2 = '.' + css2;
        var ret = false;
            $(css1 + " " + css2).each(function(i, el) {
            if($(el).hasClass(css1) && $(el).hasClass(css2)){ 
                ret = true;
                exit;
            }
        });
        return ret;
    }
});
