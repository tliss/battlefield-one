class StaticPagesController < ApplicationController
  def home

    # https://ruby-doc.org/stdlib-2.5.1/libdoc/net/http/rdoc/Net/HTTP.html
    # https://battlefieldtracker.com/bf1/api/Loadout/GetPresets?platform=3&displayName=samort7

    query = {
        "platform"     => 3,
        "displayName"      => 'samort7'
    }
    headers = {
        "TRN-Api-Key"  => Rails.application.credentials.trn_api_key
    }

    @result = HTTParty.post(
        "https://battlefieldtracker.com/bf1/api/Loadout/GetPresets",
        :query => query,
        :headers => headers
    ).body

  end

  def results
  end
end