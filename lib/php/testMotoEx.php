<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
                      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"> 
<head profile="http://purl.org/NET/erdf/profile"> 
  <meta http-equiv="content-type" content="text/html;charset=utf-8" /> 
  <title>Prueba MotoEx</title>
  <style>
  table{
    border-collapse: collapse;
  }
  td, th{ padding: 4px;}
  a{
    color: blue;
    text-decoration: underline;
    cursor: pointer;
  }
  </style>
</head>
<body>

<?php

function presentar($resp, $areas) {
  $first = true;

  echo '<a onClick="toggleTabla()" id="aTablas">Ocultar Tablas</a>';
  echo '<div id="tablas">';
  foreach($areas as $pos => $area) {
    echo '<table border="1">';
    foreach($resp->{$area} as $k => $row) {
      if($first == true) {
        echo '<tr>';
        foreach($row as $head => $val)
          echo "<th>$head</th>";
        echo '</tr>';
        $first = false;
      }
      echo "<tr>";
      foreach($row as $kk => $value) {
        echo "<td>$value</td>";
      }
      echo "</tr>";
    }

    echo '</table>';
  }
  echo '</div>';
}


if($_POST['login']) {
  //echo $_FILES['archivo']['tmp_name'];
  //print_r($_POST);
  include_once('RestMotoEx.php');
  $target = 'archivos/'.basename($_FILES['archivo']['name']);
  if(move_uploaded_file($_FILES['archivo']['tmp_name'], $target)) {
    $rest = new RestMotoEx("http://localhost:3000/importares", "json");
    $resp = $rest->postDatos($_POST, realpath($target));
    $resp = json_decode($resp);
    
    presentar($resp, $_POST['areas']);
  } 
}
?>
  <form method="post" enctype="multipart/form-data" action="testMotoEx.php">
<ul>
  <li>
    <label>login</label><input type="text" name="login" id="login">
  </li>

  <li>
    <label>Password</label><input type="text" name="password" id="password">
  </li>

  <li>
    <label>Archivo</label><input type="file" name="archivo" id="archivo">
  </li>
  <li>
    <label>Formato</label>
    
  </li>

  <li>
    <label>Areas</label>
    <select name="areas[]" multiple="multiple">
      <option value="1">Area 1</option>
      <option value="2">Area 2</option>
      <option value="3">Area 3</option>
      <option value="8">Area 8</option>
    </select>
  </li>
</ul>
<input type="submit" value="Ingresar" />
</form>
<script type="text/javascript">
function toggleTabla() {
  var div = document.getElementById('tablas');
  var a = document.getElementById('aTablas');

  if(a.innerHTML == 'Mostrar Tablas') {
    div.style.display = 'block';
    a.innerHTML = 'Ocultar Tablas';
  }else{
    div.style.display = 'none';
    a.innerHTML = 'Mostrar Tablas';
  }
}
</script>
</body>
</html>
