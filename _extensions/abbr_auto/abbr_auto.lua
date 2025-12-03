
-- Always load abbreviations.yml from project root
function read_abbreviations()
  local root = os.getenv("QUARTO_PROJECT_DIR") or "."
  local path = root .. "/abbreviations.yml"

  local file = io.open(path, "r")
  if not file then
    io.stderr:write("[abbr_auto] Could not find abbreviations.yml at: " .. path .. "\n")
    return {}
  end

  local content = file:read("*a")
  file:close()

  -- Parse YAML as Pandoc meta
  local doc = pandoc.read("---\n" .. content .. "\n---", "markdown")
  return doc.meta
end

local abbreviations = read_abbreviations()
local seen = {}

-- Normalize keys for case-insensitive lookup
local normalized_abbr = {}
for k, v in pairs(abbreviations) do
  normalized_abbr[k:lower()] = pandoc.utils.stringify(v)
end

function Str(el)
  local text = el.text
  -- Remove leading/trailing punctuation for clean match
  local clean_text = text:gsub("^[%p]+", ""):gsub("[%p]+$", "")
  local key = clean_text:lower()

  if normalized_abbr[key] then
    local full = normalized_abbr[key]
    if not seen[key] then
      seen[key] = true
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
