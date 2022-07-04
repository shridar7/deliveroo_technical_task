require_relative 'parser_constants'
require_relative 'cron_attribute_validator'
require_relative 'cron_parser'
puts CronParser.new(ARGV[0]).parse_cron
