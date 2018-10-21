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

    kit = results['result']['kits']['0'][0]['0']
    find_weapon_name(kit)
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
        weapon_array[id] = name
      end
    end

    weapon_array

  end

  def find_weapon_name(weapon_id)
    weapon_array = weapons
    weapon_array[weapon_id.downcase]
  end

end
