Fin = Encabezado.extend({
    'serialize': 'fin',
    'cssMarcar': 'bg-light-yellow',
    'init': function(ini, fin, area){
        this._super(ini, fin, area);
    },
    /**
     * Creación de eventos relacionados
     */
    'crearEventos': function(){
        var fin = this;
        $('#area-fin').bind('marcar:fin', function(){
            // Validar que este dentro del AreaGeneral
            if (fin.validarInclusion(fin.area.cssMarcar) && 
                fin.validarSolapamiento([fin.area.titular.cssMarcar, fin.area.encabezado.cssMarcar, fin.area.descartar.cssMarcar]) ) {
                
                fin.desmarcarArea(fin.cssMarcar);
                fin.marcarArea(fin.cssMarcar);
                fin.crearTablaCeldas();
            }
        });
        $('.' + fin.serialize + '-check').live("click", function() { fin.adicionarBorrarCampo(this);});
        $('.' + fin.serialize + '-text').livequery("blur", function() { fin.mapearCampo(this);});
    }
});
