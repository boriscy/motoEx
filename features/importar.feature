# language: es
Caracteristica: debo poder loguearmne e importar los datos de una hoja electronica
Para poder importar de una hoja electronica un area
debo revisar que el area corresponda al mismo archivo

  Esquema del escenario: Importar un archivo
    Dado que quiero importar el <archivo>, <archivo_yaml>
    Entonces debo obtener la <respuesta>

  Ejemplos:
    | archivo       | archivo_yaml      | respuesta  |
    |ParteDiario.xls| ParteDiario.yml   | parte_diario.yml  |
