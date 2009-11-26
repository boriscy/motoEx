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
    /**
     * Constructor
     */
    'init': function(ini, fin) {
        this.celdaInicial = ini || '';
        this.celdaFinal = fin || '';
    },
    /**
     * Aciciona una clase css a un area
     */
    'marcarArea': function(css, cssSel){
        cssSel = cssSel || this.cssSeleccionado;
        $('.' + cssSel).addClass(css);
    },
    /**
     * Elimina la clase css de un area 
     */
    'desmarcarArea': function(css) {
        css = css || this.cssSeleccionado;
        $('.' + css).removeClass(css);
    },
    /**
     * marca con el css indicado desde el inicio al fin
     * @param String inicio
     * @parma String fin
     * @param String css
     */
    'marcarCeldas': function(inicio, fin, css) {
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
    }
});

