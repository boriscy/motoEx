# language: es
Caracteristica: login e importar un hoja electronicaclas
  Para poder importar una hoja electronica
  es necesario loguearse
  seleccionar el archivo y 
  verificar los datos

    Escenario: Importar datos
    Dado que me logueo y tengo los datos
    Y visito importar
    Entonces hago click en VentasPrecio2000-2008.xls
    Y debo seleccionar la hoja 2000
    Cuando voy a importar
    Entonces debo ver el listado
    Y selecciono la "1" y mi archivo "VentasPrecio2000-2008.xls"
    Entonces deberia importar los datos

