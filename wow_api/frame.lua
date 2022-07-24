---@class Frame
local frame = {}

---Create a Frame object
---https://wowpedia.fandom.com/wiki/API_CreateFrame
---@param frameType string Type of the frame; e.g. "Frame" or "Button".
---@param name string Globally accessible name to assign to the frame, or nil for an anonymous frame
---@param parent string Parent object to assign to the frame, or nil to be parentless; cannot be a string. Can also be set with Region:SetParent()
---@param template string Comma-delimited list of virtual XML templates to inherit; see also a complete list of FrameXML templates.
---@param id string ID to assign to the frame. Can also be set with Frame:SetID()
---@return Frame Frame object
function CreateFrame(frameType, name, parent, template, id)
    return frame
end

function frame:SetScript(callable)
    self.script = callable
end

function frame:GetScript()
    return self.script
end

---Hide the frame
function frame:Hide()

end

---Show the frame
function frame:Show()

end

---Event handler
---@param event string Event name
function frame:OnEvent(event, ...)

end

---Register an event on the frame
---@param event string Event name
function frame:RegisterEvent(event)

end

---Unregister an event from the frame
---@param event string Event name
function frame:UnRegisterEvent(event)

end

---Unregister all events from the frame
function frame:UnregisterAllEvents()

end

---@param point string Point on the current frame
---@param relativeTo string a frame the point should be relative to
---@param relativeToPoint string Point on the other frame
---@param x number Horizontal offset from the relative point
---@param y number Vertical offset from the relative point
function frame:SetPoint(point, relativeTo, relativeToPoint, x, y)

end

---@param width number Frame width
---@param height number Frame height
function frame:SetSize(width, height)

end

function frame:SetText(text)
    self.text = text
end

function frame:EnableMouse()

end

function frame:SetFrameStrata(strata)
    self.strata = strata
end

function frame:SetFrameLevel(level)
    self.level = level
end

function frame:SetBackdrop()

end

function frame:CreateFontString()
    return _G.WowText
end

function frame:SetNormalFontObject(GameFontNormal)

end

function frame:SetHighlightFontObject(GameFontHighlight)

end

---@return WowTexture
function frame:CreateTexture()
    return _G.WowTexture
end

function frame:SetNormalTexture(texture)
    ---@type WowTexture
    self.normalTexture = texture
end

---@return WowTexture
function frame:GetNormalTexture()
    --return self.normalTexture
    return _G.WowTexture
end

function frame:SetPushedTexture(texture)

end

---@return WowTexture
function frame:GetPushedTexture()
    --return self.normalTexture
    return _G.WowTexture
end

function frame:SetHighlightTexture(texture)

end

---@return WowTexture
function frame:GetHighlightTexture()
    --return self.HighlightTexture
    return _G.WowTexture
end

function frame:ClearAllPoints()

end

function frame:SetAllPoints(frame)

end

function frame:HasFixedFrameLevel()

end

function frame:HasFixedFrameStrata()

end

function frame:SetFixedFrameLevel(...)

end

function frame:SetFixedFrameStrata(...)

end