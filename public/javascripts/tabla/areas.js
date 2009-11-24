
/**
 * Clase madre de la cual heredan todas las demas areas
 */
var Area = Class.extend({
    init: function(ini, fin) {
        this.celdaInicial = ini;
        this.celdaFinal = fin;
    },
    /**
     *
     */
    marcarArea: function(css, cssSel){
        cssSel = cssSel || this.cssSeleccionado;
        $('.' + cssSel).addClass(css);
        //$( $("a.active").attr("href") + ' .' + this.cssSeleccionado )
    },
    desmarcarArae: function(css) {
        cssSel = cssSel || this.cssSeleccionado;
        $('.' + cssSel).removeClass(css);
    },
    celdaInicial: '',
    celdaFinal: '',
    cssSeleccionado: 'sel'
});


 
AreaGeneral = Area.extend({
    formulario: '',
    init: function(ini, fin) {
        this._super(ini, fin);
        if(this.formulario == '') {
            this.formulario = new FormularioArea(this);
            // buscar hoja visble
            var areagen = this; 
            $('.visible').bind("area:cambiar", function() { areagen.triggerMarcar() });
        }
    },
    /**
     *
     */
    triggerMarcar: function() {
        this.marcarArea('bg-light-green');
    },
    /**
    * Define el area a importar en base a los elementos seleccionados ".sel"
    */
    definirAreaImportar:function() {
        $("#sheets td").bind("area:modificar", function() {
        });
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
    /**
     *
     */
    crearAreaImportar:function(){
    },
    /**
    * Define el area del encabezado, debe estar dentro del .area-importar
    */
    definirAreaEncabezado:function() {
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
    definirAreaDescartar:function() {
        if(this.crearArea(this.cssAreaDesc) && this.areaEncSel) {
            
        }
    },
    /**
    * Define el fin
    */
    definirAreaFin:function() {
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
    },
    /**
     *
     */
    crearArea:function(css) {
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
    marcarBordeSobreArea:function(css1, css2) {
    }


  
});
    
