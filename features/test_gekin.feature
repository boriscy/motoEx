# language: es
Caracteristica: Testear Gekin


  Esquema del escenario: Quiero testear gekin
    Dado que tengo <usuario>
    Cuando entro como <admin>

  Ejemplos:
    |usuario|tipo  |admin|
    |boris  |admin |true |
    |amaru  |user  |false|
    |boris  |admin |false|
