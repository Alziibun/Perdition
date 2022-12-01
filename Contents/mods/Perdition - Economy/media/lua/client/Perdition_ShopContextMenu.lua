---@class ShopMenu
ShopMenu = {}

---@param player IsoPlayer
---@param context ISContextMenu
---@param worldobjects KahluaTable
---@param test boolean
ShopMenu.doShopMenu = function(player, context, worldobjects, test)
    local player = getSpecificPlayer(player)
    local square = player:getSquare()
    local region = square:getIsoWorldRegion()
    if region:isEnclosed() then
        local building = Building:get(square:getX(), square:getY(), square:getZ())
        local containers = building:getContainers(region:getID())
        local shop = nil
        for _, container in pairs(containers) do
            local modData = container:getModData()
            if modData['ShopID'] then
                shop = modData['ShopID']
                break
            end
        end
        local option = context:addOption("Shop", nil, nil)
        local submenu = ISContextMenu:getNew(context)
        context:addSubMenu(option, submenu)
        if not shop then
            local setup = submenu:addOption("Setup Shop", nil, ShopMenu.setupShop, player, region)
        else
            local goToRegister = submenu:addOption("Go to Register", nil, ShopMenu.walkToRegister, player, building)
        end
    end
end

ShopMenu.goToRegister = function(_, player, building)
    local register = nil
    for room_id, _ in pairs(building.rooms) do
        local containers = building:getContainers(room_id)
        for _, container in pairs(containers) do
            local modData = container:getModData()
            if modData["ShopID"] then
                if modData['ShopComponent'] == Shop.component.core then
                    luautils.walkToContainer(container, getSpecificPlayer(player))
                    break
                end
            end
        end
    end
end

ShopMenu.setupShop = function(worldobjects, player, region)
    local shop = Shop:new(player, region, false)
end

function sendShopMenu(worldobjects, player)
    print(ShopUI)
    local ui = ShopUI:new(50, 50, 500, 150, player)
    ui:initialise()
    ui:addToUIManager()
end
Events.OnFillWorldObjectContextMenu.Add(ShopMenu.doShopMenu)