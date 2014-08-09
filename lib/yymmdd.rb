require "date"

module YYMMDD
  VERSION = "0.0.1"

  FORMATS = %w[yyyy yy y mm m dd d]
  FORMATS.each do |abbr|
    define_method(abbr) { |date = nil| DatePart.new(abbr, date) }
    module_function abbr
  end

  def yymmdd(date)
    yy << mm << dd(date)
  end

  module_function :yymmdd

  alias_method :ymd, :yymmdd
  module_function :ymd

  def yyyymmdd(date)
    yyyy << mm << dd(date)
  end

  module_function :yyyymmdd

  alias_method :yyyymd, :yyyymmdd
  module_function :yyyymd

  class DatePart # :nodoc:
    STRPTIME = {
      "y"    => "%y",
      "yy"   => "%y",
      "yyyy" => "%Y",
      "m"    => "%m",
      "mm"   => "%m",
      "d"    => "%d",
      "dd"   => "%d"
    }.freeze

    attr :format
    attr :date

    def initialize(format, date)
      @format = STRPTIME[format]
      @date = date
      @parts = [[self, ""]]
    end

    def /(date = nil)
      process("/", date)
    end

    def -(date = nil)
      process("-", date)
    end

    def << (date = nil)
      process("", date)
    end

    FORMATS.each do |abbr|
      define_method(abbr) { |date = nil| process(".", DatePart.new(abbr, date)) }
    end

    def to_s
      build_date.to_s
    end

    private
    def process(tok, part)
      @parts << [part, tok]
      return build_date if part.date
      self
    end

    def build_date
      date = @parts[-1][0].date || Date.today
      fmt  = @parts.map { |part, tok| "#{tok}#{part.format}" }.join("")

      date = date.to_s if date.is_a?(Fixnum)      
      date.is_a?(Date) ? date.strftime(fmt) : Date.strptime(date, fmt)
    end
  end
end


if $0 == __FILE__
  include YYMMDD
  date = Date.today

  puts yy/mm
  puts ymd(411207)
  puts yyyy.mm.dd(date)
  puts yyyy.mm.dd("1941.12.07")
  puts mm.dd.yy("11.22.63")
  puts dd/mm/yy("21/11/79")
  puts dd/mm/yy(date)
  puts mm/dd/yy("11/21/99")
  puts mm/dd/yyyy("11/21/1999")
  puts m-d-y("11-21-99")
  puts mm-dd-yyyy("11-21-1999")
end
