local SettingsInbound = {};

SettingsInbound.AssignLayoutToCategoryAttribute = "assign-layout-to-category";
SettingsInbound.AssignTutorialToCategoryAttribute = "assign-tutorial-to-category";
SettingsInbound.CreateAddOnSettingAttribute = "create-add-on-setting";
SettingsInbound.CreateProxySettingAttribute = "create-proxy-setting";
SettingsInbound.CreateElementInitializerAttribute = "create-element-initializer";
SettingsInbound.CreateSettingInitializerAttribute = "create-setting-initializer";
SettingsInbound.CreatePanelInitializerAttribute = "create-panel-initializer";
SettingsInbound.OnSettingValueChangedAttribute = "on-setting-value-changed";
SettingsInbound.OpenToCategoryAttribute = "open-to-category";
SettingsInbound.RegisterCanvasLayoutCategoryAttribute = "register-canvas-layout-category";
SettingsInbound.RegisterCanvasLayoutSubcategoryAttribute = "register-canvas-layout-subcategory";
SettingsInbound.RegisterCategoryAttribute = "register-category";
SettingsInbound.RegisterInitializerAttribute = "register-initializer";
SettingsInbound.RegisterSettingAttribute = "register-setting";
SettingsInbound.RegisterVerticalLayoutCategoryAttribute = "register-vertical-layout-category";
SettingsInbound.RegisterVerticalLayoutSubcategoryAttribute = "register-vertical-layout-subcategory";
SettingsInbound.RepairDisplayAttribute = "repair-display";
SettingsInbound.SetCurrentLayoutAttribute = "set-current-layout";
SettingsInbound.SetKeybindingsCategoryAttribute = "set-keybindings-category";

local AttributeDelegate = CreateFrame("Frame");

Settings = {}

function Settings.RegisterCategory(category, group)
    local addon = false;
    return AttributeDelegate:SetAttribute(SettingsInbound.RegisterCategoryAttribute, { category, group, addon, });
end

function Settings.RegisterAddOnCategory(category)
    local addon = true;
    local group = nil;
    return Settings.RegisterCategory(category, group, addon);
end

function Settings.RegisterCanvasLayoutCategory(frame, name)
    return AttributeDelegate:SetAttribute(SettingsInbound.RegisterCanvasLayoutCategoryAttribute, { frame, name, });
end