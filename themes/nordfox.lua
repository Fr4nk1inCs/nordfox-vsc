---Convert a color to hex.
---@param color number
local function to_hex(color)
  return string.format("#%06x", color)
end

local cache = {}
---Get the highlight group attribute.
---@param index string "hlgroup.attribute", hlgroup may contains dots as well
local function get_color(index)
  local hlgroup, attr = string.match(index, "^(.*)%.([^%.]+)$")
  assert(attr, "Invalid index: " .. index)
  if not cache[hlgroup] then
    local specs = vim.api.nvim_get_hl(0, { name = hlgroup })
    assert(specs ~= {}, "Invalid highlight group: " .. hlgroup)
    while specs.link do
      specs = vim.api.nvim_get_hl(0, { name = specs.link })
    end
    cache[hlgroup] = specs
  end
  if cache[hlgroup][attr] == nil then
    error("Invalid index: " .. index)
  end
  return to_hex(cache[hlgroup][attr])
end

local template_file = io.open("template.json", "r") or error("Could not open template.json for reading")
local theme = vim.json.decode(template_file:read("*a"))
template_file:close()

-- colors
for group, index in pairs(theme.colors) do
  theme.colors[group] = get_color(index)
end
-- semantic colors
for group, index in pairs(theme.semanticTokenColors) do
  theme.semanticTokenColors[group] = get_color(index)
end
-- tokenColors
for _, spec in ipairs(theme.tokenColors) do
  if spec.settings.foreground then
    spec.settings.foreground = get_color(spec.settings.foreground)
  end
end

-- terminal ansi colors
local palette = require("nightfox.palette").load("nordfox")
local colors = {
  "Black",
  "Blue",
  "Cyan",
  "Green",
  "Magenta",
  "Red",
  "White",
  "Yellow",
}
for _, color in ipairs(colors) do
  theme.colors["terminal.ansi" .. color] = palette[color:lower()].base
  theme.colors["terminal.ansiBright" .. color] = palette[color:lower()].bright
end

-- metadata
theme.name = "Nordfox"
theme.author = "Fr4nk1in"
theme.maintainers = { "sh.fu@outlook.com" }
theme.type = "dark"
theme.semanticHighlighting = true

local output_file = io.open("nordfox.json", "w") or error("Could not open nordfox.json for writing")
output_file:write(vim.json.encode(theme))
output_file:close()
