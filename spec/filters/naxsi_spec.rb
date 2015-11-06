# encoding: utf-8
require 'spec_helper'
require "logstash/filters/naxsi"

describe LogStash::Filters::Naxsi do
  describe "Split into multiple events" do
    let(:config) do <<-CONFIG
      filter {
        naxsi {}
      }
    CONFIG
    end

    sample("message" => "some text", "id0" => "1", "id1" => "2") do
      insist { subject.length } == 2
      insist { subject[0]["id"] } == "1"
      insist { subject[1]["id"] } == "2"
    end

    sample("message" => "some text", "id0" => "1", "id1" => "2") do
      insist { subject.length } == 2
      insist { subject[0]["message"] } == "some text"
      insist { subject[1]["message"] } == "some text"
    end

    sample("message" => "some text", "id0" => "1", "id1" => "2", "cscore1" => "$SQL") do
      insist { subject[1]["cscore"] } == "$SQL"
    end
  end
end
