Caracteristica: loguearse y subir archivo para parsear
  Para que un usuario pueda
  Ingresar y definir su tabla debe
  estar autenticado

  Escenario: Login subir archivo 
    Dado que estoy en /
    Cuando ingreso mi login y password
    Entonces deberia estar logueado
    Y deberia ir a archivos/new
    Entonces debo ver el archivo
