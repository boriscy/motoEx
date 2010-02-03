def condiciones_importar
  @usuario = Soporte::crear_usuario()
  Soporte::stub_crear_hoja_html()
end

def crear_parametros_para_importar(usuario, archivo, area_id)
  @params = {'login' => usuario.login,'password' => usuario.password,
    'importar' => {'archivo_tmp' => Soporte::crear_archivo_temporal(archivo),
      'archivo_nombre' => Soporte::path(archivo),
      'areas' => {'0' => area_id}
    } 
  }
end

Dado /que quiero importar el (\w+\.\w+), (\w+\.\w+)/ do |archivo, yaml|
  condiciones_importar()
  area = Soporte::crear_archivo_test(archivo, yaml)

  post "/importar.yaml", crear_parametros_para_importar(@usuario, archivo, area.id)
end

Entonces /debo obtener la (\w+\.\w+)/ do |respuesta|
  y = YAML::parse(File.open( File.join(RAILS_ROOT, "ejemplos", "respuestas", respuesta) )).transform
  resp = YAML::parse(response.body).transform
  y[y.keys.first].should == resp[resp.keys.first]
end

