class CronParser

  include ParserConstants
  include CronAttributeValidator

  attr_accessor *CRON_ATTRIBUTES, :cron_string

  def initialize(string)
    @cron_string = string
  end

  def parse_cron
    valid_cron_string?
    assign_attributes
    output = ""
    CRON_ATTRIBUTES.each_with_index do |attribute, index|
      output << Object.const_get("#{attribute.upcase}_FORMAT")
      output << deconstruct_cron_attribute(attribute.to_s, instance_variable_get("@#{attribute}"), index)
      output << LINE_BREAK if index != LAST_ATTRIBUTE_INDEX
    end
    output
  rescue Exception => e
    e.message
  end

  private

    def assign_attributes
      split_cron_string = cron_string.split(" ")
      CRON_ATTRIBUTES.each_with_index do |attribute, index|
        instance_variable_set("@#{attribute}", split_cron_string[index])
      end
    end

    def deconstruct_cron_attribute(attribute_name, attribute_value, index)
      return attribute_value if index == LAST_ATTRIBUTE_INDEX

      case true
      when attribute_value.include?(COMMA_COMMAND)
        values_to_validate = attribute_value.split(COMMA_COMMAND).map(&:to_i)
        attribute_value.gsub(",", " ") if valid?(attribute_name, values_to_validate)

      when attribute_value.include?(RANGE_COMMAND)
        split_values = attribute_value.split(RANGE_COMMAND)
        (split_values[0]..split_values[1]).to_a.join(" ") if valid?(attribute_name, split_values.map(&:to_i))

      when attribute_value.include?(STEP_COMMAND)
        split_values = attribute_value.split(STEP_COMMAND)
        if valid_step_values?(attribute_name, split_values)
          output = ""
          Object.const_get("ParserConstants::#{attribute_name.upcase}_UPPER_LIMIT").times do |count|
            value = count*split_values[1].to_i
            if value <= Object.const_get("ParserConstants::#{attribute_name.upcase}_UPPER_LIMIT")
              output << "#{value.to_s} "
            else
              break
            end
          end
          output
        end

      when attribute_value == STAR_VALUE
        Object.const_get("ParserConstants::#{attribute_name.upcase}_ALL_VALUES")

      else
        attribute_value if valid_integer?(attribute_name, attribute_value)
      end
    end
end
