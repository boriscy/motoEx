Encabezado = Area.extend({
    'area': false,
    'areaMinima': 1,
    'serialize': 'encabezado',
    /**
     * Constructor
     * @param String ini
     * @param String fin
     * @param AreaGeneral area
     */
    'init': function(ini, fin, area){
        this.cssMarcar = 'bg-light-blue';
        this._super(ini, fin);
        this.area = area;
        this.crearEventos();
    },
    /**
     * Creación de eventos relacionados
     */
    'crearEventos': function(){
        var enc = this;
        $('#area-encabezado').bind('marcar:encabezado', function(){
            // Validar que este dentro del AreaGeneral
            if (enc.validarInclusion(enc.area.cssMarcar) && enc.validarSolapamiento([enc.area.fin.cssMarcar]) && enc.validarAreaMinima()) {
                enc.desmarcarArea(enc.cssMarcar);
                enc.marcarArea(enc.cssMarcar);
            }else{
                //trigger();
            }
        });
    },
    /**
     * Elimina los eventos creados
     */
    'destruirEventos': function(){
        $('#area-encabezado').unbind('marcar:encabezado');
    }
});
