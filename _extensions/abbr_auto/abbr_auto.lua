
function read_abbreviations()
  local path = "abbreviations.yml"
  local file = io.open(path, "r")
  if not file then
    print("Could not find abbreviations.yml at: " .. path)
    return {}
  end
  local content = file:read("*a")
  file:close()
  local doc = pandoc.read("---\n" .. content .. "\n---", "markdown")
  return doc.meta
end

local abbreviations = read_abbreviations()
local seen = {}

function Str(el)
  local text = el.text
  local clean_text = text:gsub("^[%p]+", ""):gsub("[%p]+$", "")
  if abbreviations[clean_text] then
    local full = pandoc.utils.stringify(abbreviations[clean_text])
    if not seen[clean_text] then
      seen[clean_text] = true
      return pandoc.RawInline("html",
        full .. " (<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>)"
      )
    else
      return pandoc.RawInline("html",
        "<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>"
      )
    end
  end
end
