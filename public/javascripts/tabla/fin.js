Fin = Area.extend({
    'area': false,
    'areaMinima': 1,
    'init': function(ini, fin, area){
        this.cssMarcar = 'bg-light-yellow';
        this._super(ini, fin);
        this.area = area;
        this.crearEventos();
    },
    /**
     * Creación de eventos relacionados
     */
    'crearEventos': function(){
        var fin = this;
        $('#area-fin').bind('marcar:fin', function(){
            // Validar que este dentro del AreaGeneral
            if (fin.validarInclusion(fin.area.cssMarcar) && fin.validarSolapamiento([fin.area.encabezado.cssMarcar]) && fin.validarAreaMinima()) {
                fin.desmarcarArea(fin.cssMarcar);
                fin.marcarArea(fin.cssMarcar);
            }else{
                
            }
        });
    },
    /**
     * Elimina los eventos creados
     */
    'destruirEventos': function(){
        $('#area-fin').unbind('marcar:fin');
    }
});
