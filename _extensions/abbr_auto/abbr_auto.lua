
-- Read abbreviations.yml using Pandoc's YAML parser
function read_abbreviations()
  local file = io.open("abbreviations.yml", "r")
  if not file then return {} end
  local content = file:read("*a")
  file:close()
  local doc = pandoc.read("---\n" .. content .. "\n---", "markdown")
  return doc.meta
end

local abbreviations = read_abbreviations()

function Str(el)
  local text = el.text
  if abbreviations[text] then
    local full = pandoc.utils.stringify(abbreviations[text])
    return pandoc.RawInline("html", "<abbr title=\"" .. full .. "\">" .. text .. "</abbr>")
  end
end
