local E, EL, V, P, G = unpack(ElvUI); -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local AddOnName, U = ...;
local L = U.L;

local GetItemClassInfo = C_Item.GetItemClassInfo or GetItemClassInfo;
local GetItemSubClassInfo = C_Item.GetItemSubClassInfo or GetItemSubClassInfo;

U.Title = C_AddOns.GetAddOnMetadata(AddOnName, 'Title');
U.numCustomFilters = 5;

P.bagFilter = {};
for i = 1, U.numCustomFilters do
    P.bagFilter['custom' .. i] = { enable = false };
    for j, itemClass in ipairs(U.ItemClass) do
        P.bagFilter['custom' .. i]['itemClass' .. itemClass.id] = { enable = false };
        if itemClass.subClass then
            for k, itemSubClass in ipairs(itemClass.subClass) do
                P.bagFilter['custom' .. i]['itemClass' .. itemClass.id]['subClass' .. itemSubClass.id] = { enable = true };
            end
        end
    end
end

U.SetFilterIcon = function(index, texture)
    E.db.bagFilter['custom'..index].icon = texture;
end

U.GetFilterIcon = function(index)
    return E.db.bagFilter and E.db.bagFilter['custom'..index].icon or 134400;
end

U.SetFilterName = function(index, name)
    E.db.bagFilter['custom' .. index].name = name;
end

U.GetFilterName = function(index)
    return E.db.bagFilter and E.db.bagFilter['custom' .. index].name or L['Custom Filter'] .. ' #' .. index;
end

U.AddCustomFilters = function()
    for i = 1, U.numCustomFilters do
        local filter = E.db.bagFilter['custom' .. i];
        if filter.enable then
            local filterName = U.GetFilterName(i);
            local filterIcon = U.GetFilterIcon(i);

            local SetFilter = function(location, link, type, subType)
                if type and filter['itemClass' .. type] and filter['itemClass' .. type].enable then
                    return not filter['itemClass' .. type]['subClass' .. subType] or filter['itemClass' .. type]['subClass' .. subType].enable;
                end
                return false;
            end

            table.insert(U.Filters, { filterName, filterIcon, SetFilter });
        end
    end
end

U.Options = function()
    E.Options.args.bagFilter = {
        name = U.Title,
        type = 'group',
        childGroups = 'select',
        disabled = function() return not E.private.bags.enable end,
        args = {}
    };

    local group, subGroup;
    for i = 1, U.numCustomFilters do
        group = {
            name = function() return U.GetFilterName(i) end,
            type = 'group',
            order = i,
            childGroups = 'tab',
            get = function(info) return E.db.bagFilter['custom' .. i][info[#info]] end,
            set = function(info, value) E.db.bagFilter['custom' .. i][info[#info]] = value; E.ShowPopup = true end,
            args = {
                description = {
                    name = function() return U.GetFilterName(i) end,
                    image = function() return U.GetFilterIcon(i) end,
                    imageCoords = { 0.1, 0.9, 0.1, 0.9 },
                    type = 'description',
                    order = 1
                },
                spacer1 = {
                    type = 'description',
                    order = 2,
                    name = ' '
                },
                change = {
                    name = L['Change name/icon'],
                    type = 'execute',
                    order = 3,
                    func = function(info)
                        local f = BagFilterPopupFrame;
                        if f:IsShown() then
                            f:Hide();
                        else
                            f.group = i;
                            f:Show();
                        end
                    end
                },
                spacer2 = {
                    type = 'description',
                    order = 4,
                    name = ' '
                },
                enable = {
                    name = EL['Enable'],
                    type = 'toggle',
                    order = 5
                },
                spacer3 = {
                    type = 'description',
                    order = 6,
                    name = ' '
                }
            }
        };

        for j, itemClass in ipairs(U.ItemClass) do
            group.args['itemClass' .. itemClass.id] = {
                name = GetItemClassInfo(itemClass.id),
                type = 'group',
                order = j + 6,
                get = function(info) return E.db.bagFilter['custom' .. i]['itemClass' .. itemClass.id].enable end,
                set = function(info, value) E.db.bagFilter['custom' .. i]['itemClass' .. itemClass.id].enable = value end,
                args = {
                    enable = {
                        name = EL['Enable'],
                        type = 'toggle',
                        order = 1
                    }
                }
            };

            if itemClass.subClass then
                subGroup = group.args['itemClass' .. itemClass.id];
                subGroup.args.spacer = {
                    type = 'description',
                    order = 2,
                    name = ' '
                };

                for k, itemSubClass in ipairs(itemClass.subClass) do
                    subGroup.args['subClass' .. itemSubClass.id] = {
                        name = GetItemSubClassInfo(itemClass.id, itemSubClass.id),
                        type = 'toggle',
                        order = k + 2,
                        get = function(info) return E.db.bagFilter['custom' .. i]['itemClass' .. itemClass.id]['subClass' .. itemSubClass.id].enable end,
                        set = function(info, value) E.db.bagFilter['custom' .. i]['itemClass' .. itemClass.id]['subClass' .. itemSubClass.id].enable = value end
                    };
                end
            end
        end

        E.Options.args.bagFilter.args['custom' .. i] = group;
    end
end

ElvUI_BagFilter = {
    DumpClasses = function()
        for i = 0, 100 do
            local name = GetItemClassInfo(i);
            if (name) then
                print(i, name);
            end
        end
    end,
    DumpSubClasses = function(classID)
        for i = 0, 100 do
            local name = GetItemSubClassInfo(classID, i);
            if (name) then
                print(i, name);
            end
        end
    end
};