module StaticPagesHelper

  def player_kit
    player_kits = retrieve_player_kits('samort7')
    weapon_list = create_weapon_list

    readable_kit_list = []
    player_kits['result']['kits'].each_value do |kit|
      unless kit[0].empty?
        readable_kit = []
        kit[0].each_value do |weapon_id|
          readable_kit.push(find_weapon_name(weapon_id, weapon_list))
        end
        readable_kit_list.push(readable_kit)
      end
    end
    readable_kit_list
  end

  def retrieve_player_kits(player)
    query = { platform: 3, displayName: player}
    headers["TRN-Api-Key"] = Rails.application.credentials.trn_api_key

    results = HTTParty.post(
        "https://battlefieldtracker.com/bf1/api/Loadout/GetPresets",
        :query => query,
        :headers => headers
    )

    JSON.parse(results.body)
  end

  def create_weapon_list
    query = { platform: 3}
    headers["TRN-Api-Key"] = Rails.application.credentials.trn_api_key

    results = HTTParty.post(
        "https://battlefieldtracker.com/bf1/api/Loadout/GetItems",
        :query => query,
        :headers => headers
    )

    results = JSON.parse(results.body)
    weapon_array = {}

    results['result'].each do |item_id, value|
      item_name = value['name']
      weapon_array[item_id] = item_name
    end
    weapon_array
  end

  def find_weapon_name(weapon_id, weapon_list)
    if weapon_list.key?(weapon_id)
      weapon_list[weapon_id]
    else
      weapon_id
    end
  end

end
