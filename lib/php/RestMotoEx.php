<?php
/**
 * Cliente REST para poder consumir el servicio WEB de MotoEx
 * @author: Boris Barroso
 * @license: GNU/GPL
 */
class RestMotoEx {
  public $url, $format;

  /**
   * Constructor
   * @param String url
   * @param String format # Formatos de los cuales estan: (json, xml, csv y yaml)
   */
  public function __construct($url, $format = 'json') {
    if(!function_exists('curl_version')) {
      die("Debe instalar php5-curl y CURL <pre>apt-get install curl<br/>apt-get install php5-culr</pre>");
    }
    $this->url = $url.'.'.$format;
    $this->format = $format;
  }

  /**
   * Envia los datos al url definido
   * @parm Array $data
   * @param File $archivo
   */
  public function postDatos($data, $archivo) {
    $ch = curl_init();
    $datos = $this->crearDatos($data, $archivo);
    
    //curl_setopt_array($ch, $this->crearCurlOpciones($datos));
    curl_setopt($ch, CURLOPT_VERBOSE, 1);
    curl_setopt($ch, CURLOPT_URL, $this->url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $datos);

    $content = curl_exec( $ch );
    $response = curl_getinfo( $ch );
    curl_close($ch);

    return $content;
  }

  /**
   * Prepara los datos a ser enviados al servicio
   * @param Array $params
   * @param File $archivo
   * @return Array
   */
  private function crearDatos($params, $archivo) {
    $arr =  array(
      'login' => $params['login'],
      'password' => $params['password'],
      'importar[archivo_tmp]' => "@$archivo",
      'importar[archivo_nombre]' => $archivo
    );
    
    // Areas
    foreach($params['areas'] as $k => $v) {
      $arr["importar[areas][$k]"] = $v;
    }
     
    return $arr;
  }

 }
