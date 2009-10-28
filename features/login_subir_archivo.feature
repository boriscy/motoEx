Caracteristica: loguearse y subir archivo
  Para que un usuario pueda
  Ingresar y definir su tabla debe
  estar autenticado

  Escenario: Login subir archivo 
    Dado que estoy en /
    Cuando ingreso mi login y password
    Entonces deberia estar logueado
    Y deberia ir a archivos/new
    Entonces debo seleccionar un archivo excel y subirlo

