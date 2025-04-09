local E, EL, V, P, G = unpack(ElvUI); -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local B = E:GetModule('Bags');
local EP = E.Libs.EP;

local AddOnName, U = ...;
local L = U.L;

local GetItemInfo = C_Item.GetItemInfo or GetItemInfo;

local function SetSlotFilter(self, bagID, slotID)
    local f = B:GetContainerFrame(bagID > (NUM_TOTAL_EQUIPPED_BAG_SLOTS or NUM_BAG_SLOTS) or bagID == BANK_CONTAINER);
    if not (f and f.BagFilter) then return end

    if f.BagFilter.active and self.Bags[bagID] and self.Bags[bagID][slotID] then
        local location = { bagID = bagID, slotIndex = slotID };
        local link;
        link = C_Container.GetContainerItemLink(bagID, slotID);
        if not link or f.BagFilter[f.BagFilter.active].filter(location, link, select(12, GetItemInfo(link))) then
            self.Bags[bagID][slotID].searchOverlay:Hide();
        else
            self.Bags[bagID][slotID].searchOverlay:Show();
        end
    end
end

local function SetFilter(self)
    local f = B:GetContainerFrame(self.isBank);
    if not (f and f.BagFilter) then return end

    for i = 1, U.numFilters do
        if i ~= self:GetID() then
            f.BagFilter[i]:SetChecked(nil);
        end
    end
    f.BagFilter.active = self:GetID();

    for i, bagID in ipairs(f.BagIDs) do
        if f.Bags[bagID] then
            for slotID = 1, f.Bags[bagID].numSlots do
                SetSlotFilter(f, bagID, slotID);
            end
        end
    end
end

local function ResetFilter(self)
    local f = B:GetContainerFrame(self.isBank);
    if not (f and f.BagFilter) then return end

    if f.BagFilter.active then
        f.BagFilter[f.BagFilter.active]:SetChecked(nil);
        f.BagFilter.active = nil;

        for i, bagID in ipairs(f.BagIDs) do
            if f.Bags[bagID] then
                for slotID = 1, f.Bags[bagID].numSlots do
                    if f.Bags[bagID][slotID] then
                        f.Bags[bagID][slotID].searchOverlay:Hide();
                    end
                end
            end
        end
    end
end

local function AddFilterButtons(f, isBank)
    local buttonSize = isBank and B.db.bankSize or B.db.bagSize;
    local buttonSpacing = E.Border * 2;
    local lastContainerButton;

    for i, filter in ipairs(U.Filters) do
        if not f.BagFilter[i] then
            local name, icon, func = unpack(filter);

            if E.Classic then
                f.BagFilter[i] = CreateFrame('CheckButton', nil, f.BagFilter);
            else
                f.BagFilter[i] = CreateFrame('CheckButton', nil, f.BagFilter, 'BackdropTemplate');
            end
            f.BagFilter[i]:SetTemplate('Default', true);
            f.BagFilter[i]:StyleButton();
            f.BagFilter[i]:SetNormalTexture('');
            f.BagFilter[i]:SetPushedTexture('');
            f.BagFilter[i].ttText = name;
            f.BagFilter[i].filter = func;
            f.BagFilter[i].isBank = isBank;
            f.BagFilter[i]:SetScript('OnEnter', B.Tooltip_Show);
            f.BagFilter[i]:SetScript('OnLeave', B.Tooltip_Hide);
            f.BagFilter[i]:SetScript('OnClick', SetFilter);
            f.BagFilter[i]:SetScript('OnHide', ResetFilter);
            f.BagFilter[i]:SetID(i);

            f.BagFilter[i].iconTexture = f.BagFilter[i]:CreateTexture();
            f.BagFilter[i].iconTexture:SetInside();
            f.BagFilter[i].iconTexture:SetTexCoord(unpack(E.TexCoords));
            f.BagFilter[i].iconTexture:SetTexture(icon);
        end

        f.BagFilter:Size(((buttonSize + buttonSpacing) * i) + buttonSpacing, buttonSize + (buttonSpacing * 2));

        f.BagFilter[i]:Size(buttonSize);
        f.BagFilter[i]:ClearAllPoints();
        if i == 1 then
            f.BagFilter[i]:SetPoint('BOTTOMLEFT', f.BagFilter, 'BOTTOMLEFT', buttonSpacing, buttonSpacing)
        else
            f.BagFilter[i]:SetPoint('LEFT', lastContainerButton, 'RIGHT', buttonSpacing, 0);
        end

        lastContainerButton = f.BagFilter[i];
    end
end

local function AddMenuButton(isBank)
    if E.private.bags.enable ~= true then return end
    local f = B:GetContainerFrame(isBank);

    if not f or f.BagFilter then return end
    if E.Classic then
        f.BagFilter = CreateFrame('Button', nil, f);
    else
        f.BagFilter = CreateFrame('Button', nil, f, 'BackdropTemplate');
    end
    f.BagFilter:Point('BOTTOMLEFT', f, 'TOPLEFT', 0, 1);
    f.BagFilter:SetTemplate('Transparent');
    f.BagFilter:Hide();

    if E.Classic then
        f.filterButton = CreateFrame('Button', nil, f.holderFrame);
    else
        f.filterButton = CreateFrame('Button', nil, f.holderFrame, 'BackdropTemplate');
    end
    f.filterButton:SetSize(20, 20);
    f.filterButton:SetTemplate();
    f.filterButton:SetPoint('RIGHT', f.sortButton, 'LEFT', -5, 0);
    f.filterButton:SetNormalTexture('Interface/AddOns/ElvUI_BagFilter/BagFilter');
    f.filterButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords));
    f.filterButton:GetNormalTexture():SetInside();
    f.filterButton:SetPushedTexture('Interface/AddOns/ElvUI_BagFilter/BagFilter');
    f.filterButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords));
    f.filterButton:GetPushedTexture():SetInside();
    f.filterButton:StyleButton(nil, true);
    f.filterButton.ttText = L.Filter;
    f.filterButton:SetScript('OnEnter', B.Tooltip_Show);
    f.filterButton:SetScript('OnLeave', B.Tooltip_Hide);
    f.filterButton:SetScript('OnClick', function()
        f.ContainerHolder:Hide();
        ToggleFrame(f.BagFilter);
    end);

    f.bagsButton:HookScript('OnClick', function()
        f.BagFilter:Hide();
    end);

    -- realign
    f.bagsButton:SetPoint('RIGHT', f.filterButton, 'LEFT', -5, 0);

    AddFilterButtons(f, isBank);
end

function U.Initialize()
    U.Filters = {
        { L.All, 'Interface/Icons/INV_Misc_EngGizmos_17',
          function(location, link, type, subType)
              return true;
          end
        },
        { L.Equipment, 'Interface/Icons/INV_Chest_Chain_04',
          function(location, link, type, subType)
              return type == Enum.ItemClass.Armor or
                     type == Enum.ItemClass.Weapon;
          end
        },
        { L.Consumable, 'Interface/Icons/INV_Potion_93',
          function(location, link, type, subType)
              return type == Enum.ItemClass.Consumable;
          end
        },
        { L.Quest, 'Interface/QuestFrame/UI-QuestLog-BookIcon',
          function(location, link, type, subType)
              return type == Enum.ItemClass.Questitem;
          end
        },
        { L.Tradegoods, 'Interface/Icons/INV_Fabric_Silk_02',
          function(location, link, type, subType)
              return type == Enum.ItemClass.Tradegoods or
                     type == Enum.ItemClass.Recipe or
                     type == Enum.ItemClass.Gem or
                     type == Enum.ItemClass.ItemEnhancement or
                     type == Enum.ItemClass.Glyph;
          end
        },
        { L.Miscellaneous, 'Interface/Icons/INV_Misc_Rune_01',
          function(location, link, type, subType)
              return type == Enum.ItemClass.Miscellaneous or
                     type == Enum.ItemClass.Container;
          end
        },
    };

    U.AddCustomFilters();

    U.numFilters = #U.Filters;

    hooksecurefunc(B, 'Layout', function(self, isBank)
        AddMenuButton(isBank);
    end);

    hooksecurefunc(B, 'UpdateSlot', function(self, frame, bagID, slotID)
        SetSlotFilter(frame, bagID, slotID);
    end);

    EP:RegisterPlugin(AddOnName, U.Options);
end

EP:HookInitialize(U, U.Initialize);
