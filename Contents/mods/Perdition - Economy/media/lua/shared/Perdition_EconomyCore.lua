---@class Economy
Economy = {}
Economy.bills = {
    [10000] = "Base.10000bill",
    [5000] = "Base.5000bill",
    [1000] = "Base.1000bill",
    [100] = "Base.100bill",
    [50] = "Base.50bill",
    [20] = "Base.20bill",
    [10] = "Base.10bill",
    [5] = "Base.5bill",
    [1] = "Base.Money"
}

---@param cost int the "cost" to calculate
Economy.getBillsByCost = function(cost)
    local remainder = cost
    local result = {}
    for value, name in pairs(Economy.bills) do
        local bills = remainder // value -- get the total divisable
        remainder = remainder % value
        result[name] = bills
        print(getItemNameFromFullType(name), "s: ", bills)
    end
    return result
end

---@param item Item the iterated item
local function predicateMoney(item)
    for _, bill in pairs(Economy.bills) do
        -- TODO check if getFullName() actually gets the full type
        if item:getFullName() == bill then
            return true
        end
    end
    return false
end

---@param inv ItemContainer
Economy.getWorth = function(inv)
    -- TODO calculate full inventory worth by money
end