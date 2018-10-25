module StaticPagesHelper

  def player_kit(origin_search_user)
    player_kits = retrieve_player_kits(origin_search_user)
    return ['User either doesn\'t exist or has no BattleField 1 data'] unless player_kits['successful']

    item_list = retrieve_item_list

    kl = KitList.new(origin_user: origin_search_user)

    player_kits['result']['kits'].each do |kit_num, kit|
      unless kit[0].empty?
        k = kl.kits.new(number: kit_num, name: find_kit_name(kit_num))
        kit[0].each do |slot, item_id|
          unless slot == 'name'
            k.items.create(name: find_item_name(item_id, item_list), image: find_item_image(item_id, item_list), slot: slot)
          end
        end
        k.save
      end
    end
    kl.save
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

  def retrieve_item_list
    query = { platform: 3}
    headers["TRN-Api-Key"] = Rails.application.credentials.trn_api_key

    results = HTTParty.post(
        "https://battlefieldtracker.com/bf1/api/Loadout/GetItems",
        :query => query,
        :headers => headers
    )

    results = JSON.parse(results.body)

    item_hash = {}
    image_prefix = 'https://eaassets-a.akamaihd.net/battlelog/battlebinary'

    results['result'].each do |item_id, value|
      original_image_url = value['images']['Small']
      new_image_url = image_prefix + original_image_url.delete_prefix("[BB_PREFIX]") unless original_image_url.nil?
      item_hash[item_id] = {item_name: value['name'], item_image: new_image_url}
    end

    # Add missing weapons
    item_hash['AF3F421B-F68B-401D-94B4-B982EE6C8A91'] = {item_name: 'Hellfighter 1911', item_image: 'https://eaassets-a.akamaihd.net/battlelog/battlebinary/gamedata/tunguska/63/73/U_M1911_Preorder_Hellfighter-c1b76d33.png'}
    item_hash['B97A8C29-A567-437F-9B6C-9E1E8FD86BF9'] = {item_name: 'Red Baron\'s P08', item_image: 'https://eaassets-a.akamaihd.net/battlelog/battlebinary/gamedata/tunguska/84/13/UIWepLugerP08_Preorder-ac0d1360.png'}
    item_hash
  end

  def find_item_name(item_id, item_list)
    if item_list.key?(item_id)
      item_list[item_id][:item_name]
    else
      item_id
    end
  end

  def find_item_image(item_id, item_list)
    if item_list.key?(item_id)
      item_list[item_id][:item_image]
    else
      item_id
    end
  end

  def find_kit_name(kit_num)
    case kit_num
    when '0'
      'Assault'
    when '1'
      'Medic'
    when '2'
      'Support'
    when '3'
      'Scout'
    when '13'
      'Attack Plane'
    when '15'
      'Artillery Truck'
    when '16'
      'Bomber'
    when '18'
      'Fighter'
    when '19'
      'Horse'
    when '21'
      'Heavy Bomber'
    end
  end

end
