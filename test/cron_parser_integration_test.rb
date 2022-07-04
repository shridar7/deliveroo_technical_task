require 'minitest/autorun'
require_relative '../lib/parser_constants'
require_relative '../lib/cron_attribute_validator'
require_relative '../lib/cron_parser'
require_relative 'test_helper'

include TestHelper

describe "Cron parser test suite" do
  it "tests for input with all numbers" do
    result = CronParser.new("1 1 1 1 1 /usr/bin/find").parse_cron
    result.must_equal ALL_NUMBER_OUTPUT
  end

  it "tests for input with all *" do
    result = CronParser.new("* * * * * /usr/bin/find").parse_cron
    result.must_equal ALL_STAR_OUTPUT
  end

  it "tests input with step command" do
    result = CronParser.new("*/15 * * * * /usr/bin/find").parse_cron
    result.must_equal STEP_COMMAND_OUTPUT
  end

  it "tests input with step command and speific value" do
    result = CronParser.new("*/15 0 * * * /usr/bin/find").parse_cron
    result.must_equal STEP_SPECIFIC_OUTPUT
  end

  it "tests input with step and comma commands" do
    result = CronParser.new("*/15 0 1,15 * * /usr/bin/find").parse_cron
    result.must_equal STEP_COMMA_OUTPUT
  end

  it "tests input with step, comma and range commands" do
    result = CronParser.new("*/15 0 1,15 * 1-5 /usr/bin/find").parse_cron
    result.must_equal STANDARD_OUTPUT
  end

  it "tests no input" do
    proc { CronParser.new.parse_cron }.must_raise ArgumentError
  end

  it "tests input with integer data type" do
    result = CronParser.new(100).parse_cron
    result.must_equal "Invalid input type - string expected"
  end

  it "tests input with wrong number of attributes" do
    result = CronParser.new("/usr/bin/find").parse_cron
    result.must_equal "Invalid cron format"
  end

  it "tests input with invalid minute field" do
    result = CronParser.new("15,60 0 1,15 * 1-5 /usr/bin/find").parse_cron
    result.must_equal "Invalid input 60 for minute field"
  end

  it "tests input with invalid hour field" do
    result = CronParser.new("15 1000 1,15 * 1-5 /usr/bin/find").parse_cron
    result.must_equal "Invalid input 1000 for hour field"
  end
end
