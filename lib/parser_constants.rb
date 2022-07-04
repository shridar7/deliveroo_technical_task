module ParserConstants
  CRON_ATTRIBUTES = %i(minute hour day_of_month month day_of_week command).freeze
  CRON_ATTRIBUTES.each do |attribute|
    Object.const_set("#{attribute.upcase}_FORMAT", "#{attribute.to_s.gsub("_", " ").ljust(14)}")
  end
  
  MINUTE_LOWER_LIMIT = 0
  MINUTE_UPPER_LIMIT = 59
  HOUR_LOWER_LIMIT = 0
  HOUR_UPPER_LIMIT = 23
  DAY_OF_MONTH_LOWER_LIMIT = 1
  DAY_OF_MONTH_UPPER_LIMIT = 31
  MONTH_LOWER_LIMIT = 1
  MONTH_UPPER_LIMIT = 12
  DAY_OF_WEEK_LOWER_LIMIT = 0
  DAY_OF_WEEK_UPPER_LIMIT = 6


  MINUTE_ALL_VALUES = (MINUTE_LOWER_LIMIT..MINUTE_UPPER_LIMIT).to_a.join(" ").freeze
  HOUR_ALL_VALUES = (HOUR_LOWER_LIMIT..HOUR_UPPER_LIMIT).to_a.join(" ").freeze
  DAY_OF_MONTH_ALL_VALUES = (DAY_OF_MONTH_LOWER_LIMIT..DAY_OF_MONTH_UPPER_LIMIT).to_a.join(" ").freeze
  MONTH_ALL_VALUES = (MONTH_LOWER_LIMIT..MONTH_UPPER_LIMIT).to_a.join(" ").freeze
  DAY_OF_WEEK_ALL_VALUES = (DAY_OF_WEEK_LOWER_LIMIT..DAY_OF_WEEK_UPPER_LIMIT).to_a.join(" ").freeze

  ALLOWED_CRON_STRING_LIMIT = 6
  LAST_ATTRIBUTE_INDEX = 5
  LINE_BREAK = %(\n).freeze
  STAR_VALUE = %(*).freeze
  
  COMMA_COMMAND = %(,).freeze
  RANGE_COMMAND = %(-).freeze
  STEP_COMMAND = %(/).freeze
end
