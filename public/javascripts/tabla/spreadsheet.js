//Creando la clase para las operaciones de las hojas del libro

(function($) {
    $.fn.extend({
        spreadsheet: function(config) { return new $.SpreadSheet(this[0], config); }
    });
    
    $.SpreadSheet= function(div_sheet, config) {
        var initCell, endCell, mouseIsDown = false;
        
        //para conocer la tabla actual
        var idhoja = "#sheet-" + config.numero;
        var idtabla = idhoja + " table.excel";
        
        initSheet(config.numero);
        
        table = $(div_sheet).find('.sheet-content table:first');
        
        function initSheet(numero){
            //crea los divs:
            //sheet-0-cols: para guardar los nombres de las columnas => A, B, C, D, etc.
            //sheet-0-rows: para guardar los nombres de las filas => 1, 2, 3, 4, etc.
            //sheet-0-content: para colocar la nueva tabla html, y sheet-0-cols y sheet-0-rows hagan scroll con sheet-0-content
            $(idtabla).before('<div id="sheet-' + numero + '-cols" class="sheet-cols"></div>');
            $(idtabla).before('<div id="sheet-' + numero + '-rows" class="sheet-rows"></div>');
            $(idtabla).before('<div id="sheet-' + numero + '-content" class="sheet-content"></div>');
            //coloca un id único a la tabla
            $(idtabla).attr('id', 'tabla-' + numero);
            var tabla = $(idtabla).prependTo('#sheet-' + numero + '-content');
            var html="";
            
            //copia el ancho de la tabla como estilo 
            tabla.css('width', tabla.width());
            
            //saca los nombres de las columnas a un nuevo div
            //crea un nuevo elemento tabla para agregar ahi las columnas
            tab = document.createElement("table");
            tr = document.createElement("tr");
            $("#sheet-"+numero+"-content table tr:first th").each(function(i, e){
                //creando las cabeceras
                th = document.createElement("th");
                //copia el display:none si es que la columna estuviera oculta
                if ($(e).css('display') == "none") $(th).css('display','none');
                //copia el contenido de la celda
                th.innerHTML = $(e).html();
                //establece el ancho de acuerdo a la propiedad DOM clientWidth
                $(th).css('width',$(e)[0].clientWidth);
                tr.appendChild(th);
            });
            tab.appendChild(tr);
            //copia el ancho de la tabla contenido a la nueva tabla de columnas 
            $(tab).css('width',$('#sheet-' + numero + '-content table').width() + 'px');
            //y la inserta en el div de columnas
            $('#sheet-' + numero + '-cols').append(tab);
            
            //saca los nombres de las filas a un nuevo div
            //crea un nuevo elemento tabla para agregar ahi las filas
            tab = document.createElement("table");
            tabla.find('tr:not(:first)').each(function(i, e) {
                tr = document.createElement("tr");
                if ($(e).css('display') == "none") $(tr).css('display','none');
                th = document.createElement("th");
                th.innerHTML = $(e).find('th')[0].innerHTML;
                $(th).css('height',$(e)[0].clientHeight);
                tr.appendChild(th);
                tab.appendChild(tr);
            });
            $(tab).css('width','50px');
            $(tab).css('height',(tabla.height()-20) + 'px');
            $(tab).height((tabla.height()-20) + 'px');
            $('#sheet-' + numero + '-rows').append(tab);
            
            //Une los scrolls de las filas y columnas al contenido
            $('#sheet-' + numero + '-content').scroll(function(){
                $('#sheet-' + numero + '-cols').scrollLeft($('#sheet-' + numero + '-content').scrollLeft());
            });
            $('#sheet-' + numero + '-content').scroll(function(){
                $('#sheet-' + numero + '-rows').scrollTop($('#sheet-' + numero + '-content').scrollTop());
            });
            
            //ubicando los divs de contenido y filas de acuerdo al ancho de la primera celda (la que esta vacia [0, 0]) de la tabla contenido
            var anchofila = $('#sheet-'+numero+'-content table tr:first th:first').css('width','50px')[0].clientWidth;
            $('#sheet-'+numero+'-content table').css('margin','-19px 0 0 -' + anchofila + 'px');
            $('#sheet-'+numero+'-content').css('left', anchofila + 'px');
            $('#sheet-'+numero+'-rows').css('width', anchofila + 'px');
            $('#sheet-'+numero+'-rows table').css('width', (anchofila + 1) + 'px');
            
        }
        
        /**
         * Captura de selección del mouse, Inicio
         */
        
        //table.live('mousedown', function(e) {
        table.mousedown(function(e) {
            initCell = getEventTarget(e);
            if (initCell.id.split('_')[1] != '0'){
                //$(idtabla).find(initCell).addClass('sel');
                $(initCell).addClass('sel');
                mouseIsDown = true;
                createArea(initCell, initCell);
            }
            return false;
        });
        
        /**
         * Captura de selección del mouse, Fin
         */
        //table.live('mouseup', function(e) {
        table.mouseup(function(e) {
            endCell = getEventTarget(e);
            mouseIsDown = false;
            return false;
        });

        /**
         * Captura de selección del mouse, a medida que se mueve
         */
        table.mouseover(function(e) {
            if (mouseIsDown) {
                var target = getEventTarget(e);
                createArea(initCell, target);
                $(idtabla).find('.curr_cel').removeClass('curr_cel');
                $(idtabla).find(target).addClass('curr_cel');
                endCell = getEventTarget(e);
            }
            return false;            
        });
        
        table.keypress(function(e){
            console.log(e);
            console.log(getmykey(e));
        });

        function getmykey(event) {
          if (typeof(event)=="undefined") return window.event.keyCode;
          if (event.keyCode==0 && event.charCode!=0) return event.charCode;
          if (event.keyCode==0) return event.which;
          return event.keyCode;
        }

        function getEventTarget(e) {
            e = e || window.event;
            return e.target || e.srcElement;
        }

        /**
         * Crea un area marcando todas las celdas como seleccionadas
         * @param DOM c0 # Objeto de celda inicial "td"
         * @param DOM c1 # Objeto de celda final "td"
         * @param String css # Clase css (opcional)
         */
        function createArea(c0, c1, css) {
            css = css || 'sel';
            var row0 = parseInt(c0.id.split('_')[1]);
            var col0 = parseInt(c0.id.split('_')[2]);
            //var row1 = parseInt(c1.id.split('_')[1]) + (parseInt($(c1).attr('rowspan')) || 1) - 1;
            //var col1 = parseInt(c1.id.split('_')[2]) + (parseInt($(c1).attr('colspan')) || 1) - 1;
            var row1 = parseInt(c1.id.split('_')[1]);
            var col1 = parseInt(c1.id.split('_')[2]);
            if (row0 > row1){
                t = row0;
                row0 = row1;
                row1 = t;
            }
            if (col0 > col1){
                t = col0;
                col0 = col1;
                col1 = t;
            }
            if (row0 <= 0) row0 = 1; //para que no seleccione la primera fila (la de los nombres de las columnas)
            table.find('.curr_cel').removeClass('curr_cel');
            $(c0).addClass('curr_cel');
            //quita el estilo a todos los seleccionados
            $(idtabla).find('.sel').removeClass('sel');
            //obteniendo las nuevas celdas de inicio a fin para marcado
            var celdas = celda_inicial_final(row0, col0, row1, col1);
            row0 = celdas.row0;
            col0 = celdas.col0;
            row1 = celdas.row1;
            col1 = celdas.col1;
            //aplica el estilo a todos los elementos dentro del area
            for (var row = row0; row <= row1; row++) {
                for (var col = col0; col <= col1; col++) {
                    celda = $('#'+config.numero+'_'+row+'_'+col).addClass('sel');
                }
            }
        }
        
        /**
         * Obtiene las celdas de marcado tomando en cuenta los colspan/rowspan de las celdas
         * @param row0: el numero de fila de la celda inicial
         * @param col0: el numero de columna de la celda inicial
         * @param row1: el numero de fila de la celda final
         * @param col1: el numero de columna de la celda final
         * returns: las mismas variables modificadas
         */
        function celda_inicial_final(row0, col0, row1, col1){
            //console.log("old ini cell: " + row0 + "_" + col0);
            //console.log("old end cell: " + row1 + "_" + col1);
            //busca las celdas a marcar para saber el nuevo ancho y alto de las celdas
            for (var row = row0; row <= row1; row++) {
                for (var col = col0; col <= col1; col++) {
                    celda = $('#'+config.numero+'_'+row+'_'+col);
                    if (celda.size() > 0){
                        if ( col + (parseInt(celda.attr('colspan')) || 1) - 1 > col1 ){
                            col1 = col + (parseInt(celda.attr('colspan')) || 1) - 1;
                        }
                        if ( row + (parseInt(celda.attr('rowspan')) || 1) - 1 > row1 ){
                            row1 = row + (parseInt(celda.attr('rowspan')) || 1) - 1;
                        }
                    }else{
                        //console.log("Celda no encontrada: " + row + "_"  + col);
                        //no existe la celda debido a que un rowspan/colspan lo esta sobreescribiendo
                        //busca el rowspan/colspan anterior
                        encontrada = false;
                        for (var r = row; r > 0 && !encontrada; r--){
                            for (var c = col; c > 0 && !encontrada; c--){
                                //console.log("Buscando Celda: " + r + "_"  + c);
                                celda = $('#'+config.numero+'_'+r+'_'+c);
                                if (celda.size() > 0){
                                    //si existe la pone como nueva celda inicial
                                    if ( c < col0 ){
                                        col0 = c;
                                    }
                                    if ( r < row0 ){
                                        row0 = r;
                                    }
                                    if ( c + (parseInt(celda.attr('colspan')) || 1) - 1 > col1 ){
                                        col1 = c + (parseInt(celda.attr('colspan')) || 1) - 1;
                                    }
                                    if ( r + (parseInt(celda.attr('rowspan')) || 1) - 1 > row1 ){
                                        row1 = r + (parseInt(celda.attr('rowspan')) || 1) - 1;
                                    }
                                    //y se sale del for
                                    encontrada = true;
                                }
                            }
                        }
                        //console.log('Encontrada la celda: '+config.numero+'_'+r+'_'+c);
                    }
                }
            }
            //console.log("new ini cell: " + row0 + "_" + col0);
            //console.log("new end cell: " + row1 + "_" + col1);
            return {row0: row0, col0: col0, row1: row1, col1: col1}
        }
        
        function merge(){
            
        }
        
        function bold(){
            var seleccionados = table.find('.sel');
            if( seleccionados.size() > 0 ) {
                var agregar = true;
                if (table.find('.sel.bold').size() > 0){
                    agregar = false;
                }
                
                if (agregar)
                    seleccionados.addClass('bold');
                else
                    seleccionados.removeClass('bold');
            }
        }
        
        return {
            merge: merge,
            bold: bold
        }
        
    }
    
})(jQuery);

