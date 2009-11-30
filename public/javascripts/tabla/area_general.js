/**
 * Formulario general, clase principal a la cual todas
 * las clases estan realcionadas
 */
AreaGeneral = Area.extend({
    'formulario': false,
    'areaMinima': 4,
    'encabezado': false,
    'fin': false,
    // fin: '',
    datos: {},
    init: function(ini, fin) {
        var area_id = $('select#area').val();
        this.cssMarcar = "bg-light-green";
        // Parent
        this._super(ini, fin);
        this.formulario = new FormularioArea(this);
        this.crearEventos();
        var area = this;
        // Creación en caso de que no sea AJAX
        if(!ini && !fin)
            this.marcarArea(this.cssMarcar);
        // Sub Areas
        this.encabezado = new Encabezado(false, false, this);
        this.fin = new Fin(false, false, this);
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
            if(area.validarAreaMinima() ) {
                area.desmarcarArea(area.cssMarcar);
                area.marcarArea(area.cssMarcar);
            }
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
