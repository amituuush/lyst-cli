class Item
  attr_accessor :title, :description
  attr_reader :deadline, :done

  def initialize(title, deadline, description = "")
    @title = title
    @description = description
    @done = false

    if self.class.valid_date?(deadline)
      @deadline = deadline
    else
      raise StandardError, "invalid date format, must be yyyy-mm-dd"
    end
  end

  def self.valid_date?(date_str)
    split_date = date_str.split("-")
    year, month, day = split_date

    return false if split_date.length != 3
    return false if year.length != 4
    return false if month.to_i <= 0 || month.to_i > 12
    return false if day.to_i <= 0 || day.to_i > 31
    true
  end

  def deadline=(deadline)
    if self.class.valid_date?(deadline)
      @deadline = deadline
    else
      raise StandardError, "invalid date format, must be yyyy-mm-dd"
    end
  end

  def toggle
    @done = !@done
  end
end