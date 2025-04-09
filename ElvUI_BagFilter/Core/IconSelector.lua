local E, EL, V, P, G = unpack(ElvUI); -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule('Skins');

local _, U = ...;
local L = U.L;

BagFilterPopupFrameMixin = {}

function BagFilterPopupFrameMixin:OnLoad()
    self.editBoxHeaderText = L['Enter filter name (Max 30 characters):'];
    self.BorderBox.IconSelectorEditBox:SetMaxLetters(30);
    IconSelectorPopupFrameTemplateMixin.OnLoad(self);
end

function BagFilterPopupFrameMixin:Initialize()
    local frame = E:Config_GetWindow();
    if frame and not frame.InitElvUI_BagFilter then
        frame.InitElvUI_BagFilter = true;

        self:SetParent(frame);
        self:ClearAllPoints();
        self:SetPoint('CENTER', frame, 'CENTER');
        self:SetFrameLevel(frame:GetFrameLevel() + 500);

        frame:HookScript('OnHide', function() self:Hide() end);

        hooksecurefunc(E.Libs.AceConfigDialog, 'ConfigTableChanged', function() self:Hide() end);
    end

    self.origIcon = U.GetFilterIcon(self.group);
    self.origName = U.GetFilterName(self.group);
end

function BagFilterPopupFrameMixin:OnShow()
    IconSelectorPopupFrameTemplateMixin.OnShow(self);
    self.BorderBox.IconSelectorEditBox:SetFocus();

    self:Initialize();

    self.iconDataProvider = CreateAndInitFromMixin(IconDataProviderMixin, IconDataProviderExtraType.None);
    self:SetIconFilter(IconSelectorPopupFrameIconFilterTypes.All);
    self:Update();
    self.BorderBox.IconSelectorEditBox:OnTextChanged();

    local function OnIconSelected(selectionIndex, icon)
        self.BorderBox.SelectedIconArea.SelectedIconButton:SetIconTexture(icon);

        -- Index is not yet set, but we know if an icon in IconSelector was selected it was in the list, so set directly.
        self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription:SetText(ICON_SELECTION_CLICK);
        self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription:SetFontObject(GameFontHighlightSmall);
    end
    self.IconSelector:SetSelectedCallback(OnIconSelected);

    if self.isSkinned then
        return
    end

    S:HandleIconSelectionFrame(self);
end

function BagFilterPopupFrameMixin:OnHide()
    IconSelectorPopupFrameTemplateMixin.OnHide(self);

    if self.iconDataProvider then
        self.iconDataProvider:Release();
        self.iconDataProvider = nil;
    end
end

function BagFilterPopupFrameMixin:Update()
    self.BorderBox.IconSelectorEditBox:SetText(U.GetFilterName(self.group));
    self.BorderBox.IconSelectorEditBox:HighlightText();

    self.IconSelector:SetSelectedIndex(self:GetIndexOfIcon(U.GetFilterIcon(self.group)));
    self.BorderBox.SelectedIconArea.SelectedIconButton:SetIconTexture(U.GetFilterIcon(self.group));

    local getSelection = GenerateClosure(self.GetIconByIndex, self);
    local getNumSelections = GenerateClosure(self.GetNumIcons, self);
    self.IconSelector:SetSelectionsDataProvider(getSelection, getNumSelections);
    self.IconSelector:ScrollToSelectedIndex();

    self:SetSelectedIconText();
end

function BagFilterPopupFrameMixin:OkayButton_OnClick()
    IconSelectorPopupFrameTemplateMixin.OkayButton_OnClick(self);

    local iconTexture = self.BorderBox.SelectedIconArea.SelectedIconButton:GetIconTexture();
    local text = self.BorderBox.IconSelectorEditBox:GetText();

    U.SetFilterIcon(self.group, iconTexture);
    U.SetFilterName(self.group, text);

    if iconTexture ~= self.origIcon or text ~= self.origName then
        E.ShowPopup = true;
    end
    E.Libs.AceConfigRegistry:NotifyChange('ElvUI');
end