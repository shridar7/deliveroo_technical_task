module CronAttributeValidator

  include ParserConstants

  def valid_cron_string?
    raise "Invalid input type - string expected" unless cron_string.is_a?(String)
    raise "Invalid cron format" if cron_string.split(" ").size != ALLOWED_CRON_STRING_LIMIT
  end

  def valid?(attribute_name, values_to_validate)
    values_to_validate.each do |value|
      if value < Object.const_get("ParserConstants::#{attribute_name.upcase}_LOWER_LIMIT") ||
         value > Object.const_get("ParserConstants::#{attribute_name.upcase}_UPPER_LIMIT")
        raise "Invalid input #{value} for #{attribute_name} field"
      end
    end
    true
  end

  def valid_step_values?(attribute_name, values)
    unless values[0] == STAR_VALUE
      raise "Invalid input #{values[0]} for #{attribute_name} field"
    end
    valid?(attribute_name, [values[1].to_i])
  end

  def valid_integer?(attribute_name, value)
    raise "Invalid input #{value} for #{attribute_name} field" unless value.scan(/\D/).empty?
    valid?(attribute_name, [value.to_i])
  end
end
