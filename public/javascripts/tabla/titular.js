Titular = Area.extend({
    'area': false,
    'areaMinima': 1,
    'serialize': 'titular',
    /**
     * Constructor
     * @param String ini
     * @param String fin
     * @param AreaGeneral area
     */
    'init': function(ini, fin, area){
        this.cssMarcar = 'bg-light-grey';
        this._super(ini, fin);
        this.area = area;
        this.crearEventos();
    },
    /**
     * Creación de eventos relacionados
     */
    'crearEventos': function(){
        var tit = this;
        $('#area-titular').bind('marcar:titular', function() {
            // Validar que este dentro del AreaGeneral
            if (tit.validarInclusion(tit.area.cssMarcar) && 
              tit.validarSolapamiento([tit.area.fin.cssMarcar, tit.area.encabezado.cssMarcar, tit.area.descartar.cssMarcar]) ) {

                tit.desmarcarArea(tit.cssMarcar);
                tit.marcarArea(tit.cssMarcar);
            }else{
                //trigger();
            }
        });
    },
    /**
     * Elimina los eventos creados
     */
    'destruirEventos': function() {
        $('#area-titular').unbind('marcar:titular');
    }
});
