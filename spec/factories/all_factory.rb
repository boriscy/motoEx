Factory.define :grupo do |g|
  g.nombre ""
  g.descripcion ""
end

Factory.define :usuario do |u|
  u.nombre ""
  u.paterno "" 
  u.materno ""
  u.login
  u.password
  u.password_confirmation
  u.rol_id
  u.grupo_ids 
end

Factory.define :rol do |r|
  r.nombre ""
end
