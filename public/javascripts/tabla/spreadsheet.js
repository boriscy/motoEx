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
            $(tab).addClass("excel");
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
            //crea elementos a partir de estilos
            html = "<table style='width:50px;height:"+ (tabla.height()) +"px'>";
            tabla.find('tr:not(:first)').each(function(i, el) {
                html += "<tr style='height:" + (el.clientHeight) + "px; border:0px;";
                if ($(el).css('display') == "none") html += "display:none;";
                html += "'><th style='padding: 0px 0px;'>"+ $(el).find('th')[0].innerHTML +"</th></tr>";
            });
            html += "</table>";
            $('#sheet-' + numero + '-rows').append(html);
            $('#sheet-' + numero + '-rows table').height((tabla.height()-20) + 'px' );
            
            //Une los scrolls de las filas y columnas al contenido
            $('#sheet-' + numero + '-content').scroll(function(){
                $('#sheet-' + numero + '-cols').scrollLeft($('#sheet-' + numero + '-content').scrollLeft());
            });
            $('#sheet-' + numero + '-content').scroll(function(){
                $('#sheet-' + numero + '-rows').scrollTop($('#sheet-' + numero + '-content').scrollTop());
            });
            
            //ubicando los divs de contenido y filas de acuerdo al ancho de la primera celda (la que esta vacia [0, 0]) de la tabla contenido
            var anchofila = $('#sheet-'+numero+'-content table tr:first th:first').css('width','50px').clientWidth;
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
        //table.live('mouseover', function(e) {
        table.mouseover(function(e) {
            if (mouseIsDown) {
                var target = getEventTarget(e);
                createArea(initCell, target);
                //$(idtabla).find('.curr_cel').removeClass('curr_cel');
                $(idtabla).find('.curr_cel').removeClass('curr_cel');
                $(idtabla).find(target).addClass('curr_cel');
                endCell = getEventTarget(e);
            }
            return false;            
        });

        
        function getEventTarget(e) {
            e = e || window.event;
            return e.target || e.srcElement;
        }

        /**
         * Crea un area marcando todas las celdas como seleccionadas
         */
        function createArea(c0, c1, css) {
            css = css || 'sel';
            var row0 = parseInt(c0.id.split('_')[1]);
            var col0 = parseInt(c0.id.split('_')[2]);
            var row1 = parseInt(c1.id.split('_')[1]) + (parseInt($(c1).attr('rowspan')) || 1) - 1;
            var col1 = parseInt(c1.id.split('_')[2]) + (parseInt($(c1).attr('colspan')) || 1) - 1;
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
            //table.find(c0).addClass('curr_cel');
            $(c0).addClass('curr_cel');
            //quita el estilo a todos los seleccionados
            $(idtabla).find('.sel').removeClass('sel');
            //aplica el estilo a todos los elementos dentro del area
            for (var row = row0; row <= row1; row++) {
                for (var col = col0; col <= col1; col++) {
                    //table.find('#'+numero+'_'+row+'_'+col).addClass('sel');
                    $('#'+config.numero+'_'+row+'_'+col).addClass('sel');
                    //if (table[0].rows[row].cell[col].id)
                    //table[0].rows[row].cell[col]
                }
            }
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

