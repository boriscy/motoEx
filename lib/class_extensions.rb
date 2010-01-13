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

  # Crea un br por cada \n
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

Integer.class_eval do
  def to_byte_size(r=2)
    case
      when self < 1.kilobyte then "#{self.to_f.round(r)} bytes"
      when self < 1.megabyte then "#{(self.to_f/1.kilobyte).round(r)} Kb"
      when self < 1.gigabyte then "#{(self.to_f/1.megabyte).round(r)} MB"
      when self < 1.terabyte then "#{(self.to_f/1.gigabyte).round(r)} GB"
      when self < 1.petabyte then "#{(self.to_f/1.terabyte).round(r)} TB"
      when self < 1.exabyte then "#{(self.to_f/1.petabyte).round(r)} PB"
      else
        "#{(self.to_f/1.exabyte).round(r)} EB"
    end
  end

  # Convierte un mumero a una columna de una hoja electronica
  # @param Integer num
  def excel_col()
    ( ( ( (self - 1)/26>=1) ? ( (self - 1)/26+64).chr: '') + ((self - 1)%26+65).chr)
  end
end


Array.class_eval do

  # Method to convert to CSV data in an array with hash values
  # @param String separator
  # @param String encodind
  # @return String
  def to_csv_hash(separator=',', encoding='utf-8')
    header = self.first.keys
    csv = header.join(separator) + "\n"

    case encoding
    when 'utf-8'
      @proc_encoding = lambda{|v| v }
    when 'Windows-1252'
      @proc_encoding = lambda{|v| v.unpack('U*').pack('C*') }
    end

    csv << self.inject([]) do |arr, row|
      arr << header.inject([]) do |pos, k|
        cell = row[k]
        cell = "\"#{row[k].join(",")}\"" if row[k].is_a? Array
        pos << @proc_encoding.call(cell)
      end.join(separator)
    end.join("\n")

  end

end

