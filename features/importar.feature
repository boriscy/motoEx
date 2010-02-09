# language: es
Caracteristica: debo poder loguearmne e importar los datos de una hoja electronica
Para poder importar de una hoja electronica un area
debo revisar que el area corresponda al mismo archivo

  Esquema del escenario: Importar un archivo
    Dado que quiero importar <archivo>, <archivo_imp>, <archivo_yaml>
    Entonces debo obtener la <respuesta>

  Ejemplos:
    | archivo         | archivo_imp       | archivo_yaml      | respuesta         |
    |ParteDiario.xls  | ParteDiario.xls   | ParteDiario.yml   | parte_diario.yml  |
    |test.xls         | test.xls          | test.yml          | test_resp.yml     |
    |test.xls         | testAbajoDer.ods  | test.yml          | test_resp.yml     |
    |test.xls         | testArriba.ods    | test.yml          | test_resp.yml     |
    |test.xls         | testArribaDer.ods | test.yml          | test_resp.yml     |
    |test.xls         | testArribaIz.ods  | test.yml          | test_resp.yml     |
