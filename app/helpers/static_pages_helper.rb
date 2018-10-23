module StaticPagesHelper

  def player_kit(player)
    image_source = 'https://eaassets-a.akamaihd.net/battlelog/battlebinary'

    player_kits = retrieve_player_kits(player)
    return ['User either doesn\'t exist or has no BattleField 1 data'] unless player_kits['successful']

    weapon_list = create_weapon_list

    readable_kit_list = []
    player_kits['result']['kits'].each_value do |kit|
      unless kit[0].empty?
        readable_kit = []
        kit[0].each do |slot, weapon_id|
          unless slot == 'name'
            readable_kit.push([slot, find_weapon_name(weapon_id, weapon_list), weapon_id] )
          end
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
      item_image = value['images']['small']
      weapon_array[item_id] = [item_name, item_image]
      # TODO: CHANGE PLAYERS_KIT METHOD TO ACCESS ARRAYS INSTEAD OF SINGLE VARIABLE
    end

    # Add missing weapons
    # TODO: ADD IMAGES FOR THESE ITEMS
    weapon_array['AF3F421B-F68B-401D-94B4-B982EE6C8A91'] = 'Hellfighter 1911'
    weapon_array['B97A8C29-A567-437F-9B6C-9E1E8FD86BF9'] = 'Red Baron\'s P08'
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
