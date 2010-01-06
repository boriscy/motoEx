# language: es
Caracteristica: debo poder loguearmne e importar los datos de una hoja electronica
  Para poder importar de una hoja electronica un area
  debo revisar que el area corresponda al mismo archivo

    Escenario: Importar un area
    Dado que me logueo
    Y que tengo el archivo "VentasPrecio2000-2008.xls"
    Entonces debo poder leer los datos seleccionados de este archivo
