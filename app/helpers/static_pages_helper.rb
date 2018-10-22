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

    weapon_list = create_weapon_list('samort7')

    final = []
    # kit = results['result']['kits']['0'][0]['0']
    results['result']['kits'].each do |key, value|

      unless value[0].empty?
        kit = []
        value[0].each_value do |weapon_id|
          kit.push(find_weapon_name(weapon_id, weapon_list))
        end
        final.push(kit)
      end

    end

    final
  end

  def create_weapon_list(display_name)
    query = { platform: 3, displayName: (display_name)}
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

  def find_weapon_name(weapon_id, weapon_list)
    if weapon_list.key?(weapon_id.downcase)
      weapon_list[weapon_id.downcase]
    else
      weapon_id
    end
  end

end
