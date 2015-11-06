# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::Naxsi < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   naxsi {}
  # }
  #
  config_name "naxsi"

  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)

    event_hash = event.to_hash()

    # Get all of your idN keys from the event
    ids = event_hash.keys.select { |a| /id\d+/ =~ a }

    ids.each do |id|

      new_event = LogStash::Event.new()

      # Copy all the keys that are not tied to the exceptions
      event_hash.keys.each do |key|
        next if /id\d+|score\d+|var_name\d+|zone\d+|cscore\d+/ =~ key
        new_event[key] = event[key]
      end

      exception_num = id[-1,1]

      new_event["exception_num"] = exception_num

      # Add the properties for the exception
      ["id","score","var_name","zone","cscore"].each do |prop|
        next unless event_hash.has_key?(prop + exception_num)
        new_event[prop] = event_hash[prop + exception_num]
      end

      # Create the new event
      yield new_event
    end

    # Cancel the original event
    event.cancel

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Naxsi
