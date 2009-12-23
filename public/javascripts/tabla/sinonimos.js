/**
 * Clase para poder manejar los Sinonimos de los encabezados
 * maneja directamente la variable estado.area.encabezado.sinonimos
 * y cada vez que se modifica la misma, llama a los eventos correspondientes del formulario-sinonimos
 */
Sinonimos = function() {
    this.init();
}

Sinonimos.prototype = {
    /**
     * Constructor
     */
    'init': function() {
        this.crearEventos();
    },
    /**
     * Destructor
     */
    'destruir': function() {
        this.destruirEventos();
    },
    /**
     * Creacion de eventos
     */
    'crearEventos': function() {
        var sin = this;
        // para agregar grupos de sinonimos
        $("#sinonimos").bind("agregar", function(e, grupoSinonimo) {
            sin.agregar(grupoSinonimo);
        });
        $("#sinonimos").bind("modificar", function(e, grupoSinonimoNombre) {
            sin.modificar(grupoSinonimoNombre);
        });
        // para borrar un solo sinonimo de un grupo
        // recibe el nombre de la celda a eliminar en el formato "fila_columna"
        $('#sinonimos').bind("borrar:sinonimo", function(e, nombreCelda) {
            sin.borrarSinonimo(nombreCelda);
        });
    },
    /**
     * Destrucción de eventos
     */
    'destruirEventos': function() {
        $("#sinonimos").unbind("agregar");
        $("#sinonimos").unbind("modificar");
        $('#sinonimos').unbind("borrar:sinonimo");
    },
    /**
     * agrega un grupo de sinonimos
     * @param DOM grupoSinonimo #Sinonimo a agregar
     */
    'agregar': function(grupoSinonimo) {
        var valido = true;
        var nombre = "";
        for (var k in grupoSinonimo){
            nombre = k;
        }
        // primero valida el sinonimo (comprueba nombre)
        for (var k in estado.area.encabezado['sinonimos']) {
            if (k == nombre){
                valido = false;
            }
        }
        // que se haya seleccionado al menos uno
        var total = 0;
        for (var m in grupoSinonimo[nombre]) {
            total++;
        }
        if (total == 0) valido = false;
        // si es valido agrega a la variable estado.area.encabezado.sinonimos
        if (valido) {
            estado.area.encabezado['sinonimos'][nombre] = grupoSinonimo[nombre];
            // y agrega en el formulario
            $('#formulario-sinonimos').trigger("adicionar", nombre);
        }else{
            //muestra un mensaje de error
        }
    },
    /**
     *
     */
    'modificar': function(grupoSinonimoNombre) {
        var grupoSinonimo = grupoSinonimoNombre['sinonimo'];
        var nombreGrupo = grupoSinonimoNombre['nombreGrupo'];
        // supone que ya existe una variable de ese nombre en estado.area.encabezado.sinonimos
        var insertar = true;
        for (var k in estado.area.encabezado['sinonimos'][nombreGrupo]) {
            insertar = false;
            break;
        }
        // si no existiera, agrega uno nuevo
        if (insertar) {
            this.agregar(grupoSinonimo);
        }else{
            // si existiera, agrega los sinonimos de grupoSinonimo a estado.area.encabezado.sinonimos
            // ejecuta las mismas validaciones al agregar(excepto la del nombre)
            var valido = true;
            var nombre = "";
            for (var k in grupoSinonimo){
                nombre = k;
            }
            /*
            // primero valida el sinonimo (comprueba nombre)
            for (var k in estado.area.encabezado['sinonimos']) {
                if (k == nombre){
                    valido = false;
                }
            }
            */
            // que se haya seleccionado al menos uno
            var total = 0;
            for (var m in grupoSinonimo[nombre]) {
                total++;
            }
            if (total == 0) valido = false;
            // si es valido modifica la variable estado.area.encabezado.sinonimos
            if (valido) {
                //modifica el nombre del objeto
                //copia las celdas del objeto anterior al nuevo
                for (var k in estado.area.encabezado['sinonimos'][nombreGrupo]) {
                    grupoSinonimo[nombre][k] = estado.area.encabezado['sinonimos'][nombreGrupo][k];
                }
                //borra el objeto anterior
                delete(estado.area.encabezado['sinonimos'][nombreGrupo]);
                //e inserta uno nuevo
                estado.area.encabezado['sinonimos'][nombre] = grupoSinonimo[nombre];
                // y modifica en el formulario
                $('#formulario-sinonimos').trigger("modificar", {'nombreAnterior': nombreGrupo, 'nombreNuevo': nombre});
            }else{
                //muestra un mensaje de error
            }
        }
        
    },
    /**
     * Borra un sinonimo de un grupo de Sinonimos
     * @param String nombreCelda
     */
    'borrarSinonimo': function(nombreCelda) {
        var sinonimos = estado.area.encabezado['sinonimos'];
        var encontrado = false;
        //busca el sinonimo dentro de todos los grupos de sinonimos
        for (var k in sinonimos) {
            for (var m in sinonimos[k]) {
                if (m == nombreCelda) {
                    // borra la variable de estado.area
                    delete(estado.area.encabezado.sinonimos[k][m]);
                    // para el parent correspondiente cuenta si quedan mas elementos
                    var contador = 0;
                    for (x in estado.area.encabezado.sinonimos[k]){
                        contador++;
                    }
                    // si no quedan elementos elimina el grupo
                    if (contador == 0) {
                        delete(estado.area.encabezado.sinonimos[k]);
                    }
                    //si encuentra el sinonimo se sale del primer for (y de este tambien)
                    encontrado = true;
                    break;
                }
            }
            if (encontrado)
                break;
        }
    }
}
