
/**
 * Clase madre de la cual heredan todas las demas areas
 */
var Area = Class.extend({
    init: function(ini, fin) {
        this.celdaInicial = ini || '';
        this.celdaFinal = fin || '';
    },
    /**
     *
     */
    marcarArea: function(css, cssSel){
        cssSel = cssSel || this.cssSeleccionado;
        $('.' + cssSel).addClass(css);
    },
    desmarcarArea: function(css) {
        css = css || this.cssSeleccionado;
        $('.' + css).removeClass(css);
    },
    /**
     * marca con el css indicado desde el inicio al fin
     */
    'marcarCeldas': function(inicio, fin, css) {
        inicio = inicio.split("_");
        fin = fin.split("_");
        
        var iIni = parseInt(inicio[0]);
        var iFin = parseInt(fin[0]);
        var jIni = parseInt(inicio[1]);
        var jFin = parseInt(fin[1]);

        for(var i = iIni; i <= iFin; i++) {
            console.log(i);
            for(j = jIni; j <= jFin; j++) {
                $('#' + hoja_numero + '_' + i + '_' + j).addClass(css);
            }
        }
    },
    celdaInicial: '',
    celdaFinal: '',
    cssSeleccionado: 'sel',
    cssMarcar: ''
});


/**
 * Formulario general, clase principal a la cual todas
 * las clases estan realcionadas
 */
AreaGeneral = Area.extend({
    formulario: false,
    // encabezado: '',
    // fin: '',
    datos: {},
    init: function(ini, fin) {
        var area_id = $('select#area').val();
        this._super(ini, fin);
        this.formulario = new FormularioArea(this);
        this.cssMarcar = "bg-light-green";
        this.crearEventos();
        var area = this;
        if(area_id == 'disabled') {
            area.formulario.cargarDatosArea();
        }else{   
            area.cargarDatos();
        }
    },
    /**
     * Eventos generales
     */
    crearEventos: function() {
        var area = this;
        $("#sheet-"+hoja_numero).bind("destruir:area", function() {
            area.desmarcarArea(area.cssMarcar);
        });
        $("#sheet-"+hoja_numero).bind("marcar:area", function(){
            area.marcarArea(area.cssMarcar);
            //$('.'+area.cssSeleccionado).removeClass(area.cssSeleccionado);
        });
    },
    /**
     * Elimina los ventos creados en la clase
     */
    borrarEventos: function() {
        var area = this;
        $("#sheet-"+hoja_numero).unbind("destruir:area");
        $("#sheet-"+hoja_numero).unbind("marcar:area");
    },
    /**
     * Realiza la carga de datos relacionada a un area
     */
    cargarDatos: function() {
        var area = this;
        $.getJSON('/areas/' + $("select#area").val(), function(resp){
            // Cargar datos en area
            area.datos = resp;
            $("div#formulario-areas").trigger("cargar:datos", resp);
            area.marcarCeldas(resp.area.celda_inicial, resp.area.celda_final, area.cssMarcar);
        });
    },
    /**
     *
     */
    destruir: function() {
        delete(this.formulario);
        //delete(this.encabezado);
        //delete(this.fin);
    },
    /**
     *
     */
    triggerMarcar: function() {
        this.marcarArea(this.cssMarcar);
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
    
