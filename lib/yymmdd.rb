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
    # Output formats
    STRFTIME = {
      "y"    => "%y",
      "yy"   => "%y",
      "yyyy" => "%Y",
      "m"    => "%-m",
      "mm"   => "%m",
      "d"    => "%-d",
      "dd"   => "%d"
    }.freeze

    # Input formats, strptime() doesn't support "%-X" formats
    STRPTIME = STRFTIME.merge("d" => "%d", "m" => "%m").freeze

    attr :format
    attr :date

    def initialize(format, date)
      @format = format
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

    def to_str
      to_s
    end

    def inspect
      to_s
    end

    private
    def process(tok, part)
      @parts << [part, tok]
      return build_date if part.date
      self
    end

    def build_date
      date = @parts[-1][0].date || Date.today
      date = date.to_s if date.is_a?(Fixnum)

      if date.is_a?(Date)
        fmt = @parts.map { |part, tok| sprintf("%s%s", tok, STRFTIME[part.format]) }.join("")
        date.strftime(fmt)
      else
        fmt = @parts.map { |part, tok| sprintf("%s%s", tok, STRPTIME[part.format]) }.join("")
        Date.strptime(date, fmt)
      end
    end
  end
end
