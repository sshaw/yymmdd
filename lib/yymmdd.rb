require "date"

module YYMMDD
  VERSION = "0.0.1"

  FORMATS = %w[yyyy yy y mm m dd d]
  FORMATS.each do |abbr|
    define_method(abbr) { |date = nil| DatePart.new(abbr, date) }
    module_function abbr
  end

  groups = FORMATS.group_by { |fmt| fmt[0] }
  groups["y"].each do |y|
    groups["m"].each do |m|
      groups["d"].each do |d|
        [y, m, d].permutation.each do |set|
          name = set.join("")
          module_eval(<<-YMD, __FILE__, __LINE__)
            def #{name}(date = nil)
              #{set[0]} << #{set[1]} << #{set[2]}(date)
            end
          YMD

          module_function name
        end
      end
    end
  end

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

      if date.is_a?(Date)
        fmt = @parts.map { |part, tok| sprintf("%s%s", tok, STRFTIME[part.format]) }.join("")
        date.strftime(fmt)
      else
        fmt  = @parts.map { |part, tok| sprintf("%s%s", tok, STRPTIME[part.format]) }.join("")
        date = date.to_s if date.is_a?(Fixnum)
        Date.strptime(date, fmt)
      end
    end
  end
end
