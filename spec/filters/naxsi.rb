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
      insist { subject[0]["id"] } == 1
      insist { subject[1]["id"] } == 2
    end
  end
end
