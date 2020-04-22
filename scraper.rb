require 'scraperwiki'
require './scraper'

$: << "#{File.dirname(__FILE__)}/.."

Bundler.require :development, :test

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!
end

describe "#scrape_icon_rest_xml", :vcr do
  context "feed without address" do
    it "should not error" do
      scrape_icon_rest_xml("http://epb.swan.wa.gov.au/Pages/XC.Track/SearchApplication.aspx", "d=thisweek&k=LodgementDate&t=282,281,283&o=xml")
    end
  end
end
