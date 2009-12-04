Fin = Area.extend({
    'area': false,
    'areaMinima': 1,
    'init': function(ini, fin, area){
        this.area = area;
        this.cssMarcar = 'bg-light-yellow';
        this.serialize = 'fin';
        this._super(ini, fin);
        this.crearEventos();
    },
    /**
     * Creación de eventos relacionados
     */
    'crearEventos': function(){
        var fin = this;
        $('#area-fin').bind('marcar:fin', function(){
            // Validar que este dentro del AreaGeneral
            if (fin.validarInclusion(fin.area.cssMarcar) && fin.validarSolapamiento([fin.area.encabezado.cssMarcar]) ) {
                fin.desmarcarArea(fin.cssMarcar);
                fin.marcarArea(fin.cssMarcar);
            }
        });
    },
    /**
     * Elimina los eventos creados
     */
    'destruirEventos': function(){
        $('#area-fin').unbind('marcar:fin');
    },
    /**
     * desmarca el area seleccionada
     */
    'desmarcarArea': function(css, e) {
        $('#area-fin').trigger("desmarcar:fin:desc");
        this._super(css, e);
    }
});
