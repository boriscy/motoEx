# Modificaciones para que pueda funcionar roo con ciertos tipos de formaros
module Spreadsheet
  # Formatting data
  class Format
    # Is the cell formatted as a Date or Time?
    def date?
      number_format = @number_format.to_s
      code = client("[YMD]", 'UTF-8')
      !!Regexp.new(code).match(number_format) and !(/\[[a-z]+\]/i =~ number_format)
    end
    # Is the cell formatted as a Date or Time?
    def date_or_time?
      number_format = @number_format.to_s
      code = client("[hmsYMD]", 'UTF-8')
      !!Regexp.new(code).match(number_format) and !(/\[[a-z]+\]/i =~ number_format)
    end
  end
end

# Permite funcionar correctamente a roo 1.9.1 con Authlogic
#class String
#  remove_method :force_encoding if method_defined? :force_encoding
#end
