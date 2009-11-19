CrearArea = function(idArea, config) {
    var area = this;
    this.idArea = "-" + idArea; // El id del area se identifica con el guion por delante de la clase css
    return this.definirAreaImportar();
}

CrearArea.prototype = {
    idArea: '',
    cssSeleccionado: 'sel',
    cssAreaImp: 'area-imp',
    areaSel: false, // Indica si es que el área principal ha sido seleccioanda
    cssAreaEnc: 'area-enc',
    areaEncSel: false, // Indica si se ha seleccionado el encabezado
    cssAreaDesc: 'area-desc',
    cssAreaFin: 'area-fin',
    /**
    * Define el area a importar en base a los elementos seleccionados ".sel"
    */
    definirAreaImportar: function() {
        var test = $('.' + this.cssAreaImp).find("." + this.cssSeleccionado).length > 0;
        if(!test) {
            $(".visible .sel").addClass("area-imp " + this.idArea);
            this.areaSel = true;
            return this;
        }else{
            this.errorMessage("No se puede seleccionar parte de un área definida para una nueva área");
            return false;
        }
    },
    crearAreaImportar: function(){
    },
    /**
    * Define el area del encabezado, debe estar dentro del .area-importar
    */
    definirAreaEncabezado: function() {
        if(this.areaSel) {
            var inicio = $('.' + this.idArea + 'td:first');
            var fin = $('.' + this.idArea + 'td:first').parent("tr").find("td." + this.cssAreaImp + ":last");
            if(inicio.hasClass(this.cssSeleccionado) && fin.hasClass(this.cssSeleccionado)) {
                this.crearArea(this.cssAreaEnc);
                this.areaEncSel = true;
            }
        }
    },
    /**
    * Define el a descartar
    */
    definirAreaDescartar: function() {
        if(this.crearArea(this.cssAreaDesc) && this.areaEncSel) {
            
        }
    },/**
    * Define el fin
    */
    definirAreaFin: function() {
        //$('.' + this.cssAreaFin).removeClass(this.cssAreaFin);
        if(this.crearArea(this.cssAreaFin) && this.areaEncSel) {
        }
    },
    /**
    * Revisa si dos clases CSS se intersectan en algún elemento
    * @param String css1 # Nombre de la clase css elementos 1
    * @param String css2 # Nombre de la clase css elementos 2
    * @return Boolean # true, false
    */
    revisarInterseccionAlguno: function(css1, css2) {
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
    },
    /**
     *
     */
    crearArea: function(css) {
        if(this.revisarInterseccionAlguno(this.cssAreaImp)) {
            $(".visible .sel").addClass(css);
            return true
        }else{
          return false;
        }
    },
    /**
     * Marca el borde con el color del css1, es necesario definir en el DOM la lista de colores de cada Area
     */
    marcarBordeSobreArea: function(css1, css2) {
    }
}
