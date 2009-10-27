# instance_eval
ActiveRecord::Base.instance_eval do
  def list(params={})
    all(params).map{|v| [v.to_s, v.id]}
  end
end

# class_eval
ActiveRecord::Base.class_eval do
  def squish_data(*params)
    params.each{|v| self.send(v).squish! }
  end
end



