module StaticPagesHelper

  def player_kit
    query = { platform: 3, displayName: 'samort7'}
    headers["TRN-Api-Key"] = Rails.application.credentials.trn_api_key

    results = HTTParty.post(
        "https://battlefieldtracker.com/bf1/api/Loadout/GetPresets",
        :query => query,
        :headers => headers
    )

    results = JSON.parse(results.body)

    results['result']['kits']['0'][0]['0']
  end


end
