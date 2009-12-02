 /**
 * Clase para poder manejar el formulario de seleccion de columnas para los patrones
 */
FormularioDescartar = function(area, options) {
    this.merge(options);
    // Inicializacion de dialog y tabs jQueryUI
    this.init(area);
    this.crearEventos();
}

FormularioDescartar.prototype = {
    'area': false,
    'celdaInicial': '',
    'celdaFinal': '',
    'porFila': true,
    /**
     * Se une con otro JSON
     */
    'merge': function(options) {
        for(var k in options) {
            this.formOptions[k] = options[k];
        }
    },
    'init': function(area){
        this.area = area;
        
        this.crearEventos();
    },
    'crearEventos': function(){
        form = this;
        $('#formulario-descartar').bind('formulario:mostrar', function(){
            form.mostrar();
        });
    },
    /**
     * Muestra el formulario de las columnas a descartar
     * @param String celdaInicial: id de la primera celda seleccionada
     * @param String celdaFinal: id de la ultima celda seleccionada
     */
    'mostrar': function(celdaInicial, celdaFinal){
        this.celdaInicial = celdaInicial;
        this.celdaFinal = celdaFinal;
        //dependiendo de la celda Inicial y Final, calcula si es una fila o columna a descartar
        
        //y por ultimo muestra el formulario
        $("#formulario-descartar").dialog("open");
    }
}
