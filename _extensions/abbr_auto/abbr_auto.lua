
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
local seen = {} -- Track which abbreviations have been expanded

function Str(el)
  local text = el.text
  -- Remove punctuation from start and end (commas, periods, colons, semicolons, etc.)
  local clean_text = text:gsub("^[%p]+", ""):gsub("[%p]+$", "")

  if abbreviations[clean_text] then
    local full = pandoc.utils.stringify(abbreviations[clean_text])
    if not seen[clean_text] then
      -- First occurrence: full term + abbreviation with <abbr>
      seen[clean_text] = true
      return pandoc.RawInline("html",
        full .. " (<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>)"
      )
    else
      -- Subsequent occurrences: just <abbr>
      return pandoc.RawInline("html",
        "<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>"
      )
    end
  end
end
