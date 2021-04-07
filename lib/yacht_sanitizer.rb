
require "pry"

class YachtSanitizer

  def initialize(data)

    @data = data
    # @year = year,
    # @loa = loa,
    # @boa = boa,
    # @condition_key = condition


  end
  
  def getTax
    tax = @data[:price].split(' ').last
    case tax
      when 'ttc'
        return 1
      else
        0
    end
  end

  def cleanPrice
    @data[:price].tr('^0-9', '')
  end

  def getUnitsOfMeasurement
    @data[:loa].tr('0-9\.', '')
  end

  def cleanDimensions
    @data[:loa].tr('^0-9', '')
  end

end
