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

  def weapons
    query = { platform: 3, displayName: 'samort7'}
    headers["TRN-Api-Key"] = Rails.application.credentials.trn_api_key

    results = HTTParty.post(
        "https://battlefieldtracker.com/bf1/api/Progression/GetWeapons",
        :query => query,
        :headers => headers
    )

    results = JSON.parse(results.body)

    weapon_array = {}

    results['result'].each do |result|
      result['weapons'].each do |weapon|
        name = weapon['name']
        id = weapon['guid']
        weapon_array[name] = id
      end
    end

    weapon_array

  end
end
