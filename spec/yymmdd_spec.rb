require "minitest/autorun"
require "yymmdd"

describe YYMMDD do
  include YYMMDD

  before { @date = Date.new(2010, 1, 2) }

  describe "mm/dd/yyyy" do
    describe "with no arguments" do
      it "formats the current date" do
        (mm/dd/yyyy).to_s.must_equal(Date.today.strftime("%m/%d/%Y"))
      end
    end

    it "formats an instance of Date" do
      (mm/dd/yyyy(@date)).must_equal(@date.strftime("%m/%d/%Y"))
    end

    it "parses a String date" do
      (mm/dd/yyyy(@date.strftime("%m/%d/%Y"))).must_equal(@date)
    end
  end

  describe "mm/dd/yy" do
    describe "with no arguments" do
      it "formats the current date" do
        (mm/dd/yy).to_s.must_equal(Date.today.strftime("%m/%d/%y"))
      end
    end

    it "formats an instance of Date" do
      (mm/dd/yy(@date)).must_equal(@date.strftime("%m/%d/%y"))
    end

    it "parses a String date" do
      (mm/dd/yy(@date.strftime("%m/%d/%y"))).must_equal(@date)
    end
  end

  describe "mm-dd-yy" do
    describe "with no arguments" do
      it "formats the current date" do
        (mm-dd-yy).to_s.must_equal(Date.today.strftime("%m-%d-%y"))
      end
    end

    it "formats an instance of Date" do
      (mm-dd-yy(@date)).must_equal(@date.strftime("%m-%d-%y"))
    end

    it "parses a String date" do
      (mm-dd-yy(@date.strftime("%m-%d-%y"))).must_equal(@date)
    end
  end

  describe "mm.dd.yy" do
    describe "with no arguments" do
      it "formats the current date" do
        (mm.dd.yy).to_s.must_equal(Date.today.strftime("%m.%d.%y"))
      end
    end

    it "formats an instance of Date" do
      mm.dd.yy(@date).must_equal(@date.strftime("%m.%d.%y"))
    end

    it "parses a String date" do
      mm.dd.yy(@date.strftime("%m.%d.%y")).must_equal(@date)
    end
  end

  describe "mm-yy" do
    describe "with no arguments" do
      it "formats the current date" do
        (mm-yy).to_s.must_equal(Date.today.strftime("%m-%y"))
      end
    end

    it "formats an instance of Date" do
      (mm-yy(@date)).must_equal(@date.strftime("%m-%y"))
    end

    it "parses a String date" do
      result = mm-yy(@date.strftime("%m-%y"))
      result.day.must_equal(1) # no day in parsed string defaults to 1
      result.month.must_equal(@date.month)
      result.year.must_equal(@date.year)
    end
  end

  describe "ymd" do
    it "parses an Fixnum date" do
      # Must use leading 0 else Date.strptime can't do it
      ymd(100102).must_equal(@date)
    end

    it "parses a String date" do
      ymd("100102").must_equal(@date)
    end

    it "formats an instance of Date" do
      ymd(@date).must_equal("1012")
    end
  end

  describe "yyyymmdd" do
    it "parses an Fixnum date" do
      yyyymmdd(20100102).must_equal(@date)
    end

    it "parses a String date" do
      yyyymmdd("20100102").must_equal(@date)
    end

    it "formats an instance of Date" do
      yyyymmdd(@date).must_equal("20100102")
    end
  end
end
