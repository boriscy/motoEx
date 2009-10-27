# Array
Array.class_eval do
  # Retorna valores únicos de un array
  def unique_values
    self.inject([]){|ary, v| ary << v unless ary.include?(v) ; ary}
  end
end

# String
String.class_eval do
  def replace_gtlt
    self.gsub /(&lt;|&gt;)/ do |v|
      if v == "&lt;"
        "<"
      else
        ">"
      end
    end
  end

  def nl2br
    self.gsub(/\n/, "<br/>")
  end

  # Metodos para upcase downcase en Español
  # test en http://snipt.net/boriscy/to-convert-spanish-characters-to-upcase-downcase/
  alias_method :old_upcase, :upcase
  def upcase
    self.gsub( /\303[\240-\277]/ ) do |match|
      match[0].chr + (match[1] - 040).chr
    end.old_upcase
  end
  
  alias_method :old_downcase, :downcase
  def downcase
    self.gsub( /\303[\200-\237]/ ) do |match|
      match[0].chr + (match[1] + 040).chr
    end.old_downcase
  end

end
