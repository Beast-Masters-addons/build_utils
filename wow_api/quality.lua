loadfile('mixin.lua')()
loadfile('Color.lua')()

_G['ITEM_QUALITY0_DESC'] = 'Poor'
_G['ITEM_QUALITY1_DESC'] = 'Common'
_G['ITEM_QUALITY2_DESC'] = 'Uncommon'
_G['ITEM_QUALITY3_DESC'] = 'Rare'
_G['ITEM_QUALITY4_DESC'] = 'Epic'
_G['ITEM_QUALITY5_DESC'] = 'Legendary'
_G['ITEM_QUALITY6_DESC'] = 'Artifact'
_G['ITEM_QUALITY7_DESC'] = 'Heirloom'
_G['ITEM_QUALITY8_DESC'] = 'WoW Token'

local item_colors = {
    [0] = { ["b"] = 0.615686274509804, ["g"] = 0.615686274509804, ["r"] = 0.615686274509804, },
    [1] = { ["b"] = 1, ["g"] = 1, ["r"] = 1, },
    [2] = { ["b"] = 0, ["g"] = 1, ["r"] = 0.11764706671238, },
    [3] = { ["b"] = 0.8666666666666667, ["g"] = 0.4392156862745098, ["r"] = 0, },
    [4] = { ["b"] = 0.9333333333333333, ["g"] = 0.2078431372549019, ["r"] = 0.6392156862745098, },
    [5] = { ["b"] = 0, ["g"] = 0.5019607843137255, ["r"] = 1, },
    [6] = { ["b"] = 0.5019607843137255, ["g"] = 0.8, ["r"] = 0.9019607843137255, },
    [7] = { ["b"] = 1, ["g"] = 0.8, ["r"] = 0, },
    [8] = { ["b"] = 1, ["g"] = 0.8, ["r"] = 0, },
}

function _G.GetItemQualityColor(quality)
    return item_colors[quality]['r'], item_colors[quality]['g'], item_colors[quality]['b']
end

ITEM_QUALITY_COLORS = { };
for i = 0, 8 do
    local r, g, b = GetItemQualityColor(i);
    local color = CreateColor(r, g, b, 1);
    ITEM_QUALITY_COLORS[i] = { r = r, g = g, b = b, hex = color:GenerateHexColorMarkup(), color = color };
end
