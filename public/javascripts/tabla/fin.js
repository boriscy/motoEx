Fin = Encabezado.extend({
    'serialize': 'fin',
    'cssMarcar': 'bg-light-yellow',
    /**
     * Creación de eventos relacionados
     */
    'crearEventos': function() {
        var base = this;
        $('#area-fin').bind('marcar:fin', function(){
            // Validar que este dentro del AreaGeneral
            if (base.validarInclusion(base.area.cssMarcar) && 
                base.validarSolapamiento([base.area.titular.cssMarcar, base.area.encabezado.cssMarcar, base.area.descartar.cssMarcar]) ) {
                
                base.desmarcarArea(base.cssMarcar);
                base.marcarArea(base.cssMarcar);
                base.crearTablaCeldas();
            }
        });
        $('.' + this.serialize + '-check').live("click", function() { base.adicionarBorrarCampo(this);});
        $('.' + this.serialize + '-text').livequery("blur", function() { base.mapearCampo(this);});
    },
    /**
     * Funcion para que pueda realizar opciones adicionales
     */
    'marcarArea': function(css, cssSel) {
        this._super(css, cssSel);
        $('#formulario-areas').trigger("limpiar:errores");
        //y desmarca el input de area_fija
        $('#area_fija').attr("checked", false);
    },
    /**
     * Desmarca el area de encabezado y destruye los eventos de marcado
     */
    'desmarcarArea': function(css, e) {
        this._super(css, e);
        $('#formulario-areas').trigger("limpiar:errores");
    }
});
