
-- Load abbreviations.yml from project root
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

-- Load abbreviations
local abbreviations = read_abbreviations()

-- Normalize keys for case-insensitive lookup
local normalized_abbr = {}
for k, v in pairs(abbreviations) do
  normalized_abbr[k:lower()] = pandoc.utils.stringify(v)
end

-- Persistent state file for seen abbreviations
local state_file = (os.getenv("QUARTO_PROJECT_DIR") or ".") .. "/docs/.abbr_seen"

-- Load seen abbreviations from file
local seen = {}
local f = io.open(state_file, "r")
if f then
  for line in f:lines() do
    seen[line] = true
  end
  f:close()
end

-- Append new seen abbreviation to file
local function save_seen(key)
  local f = io.open(state_file, "a")
  if f then
    f:write(key .. "\n")
    f:close()
  end
end

-- Pandoc filter: replace abbreviations
function Str(el)
  local text = el.text
  -- Remove leading/trailing punctuation for clean match
  local clean_text = text:gsub("^[%p]+", ""):gsub("[%p]+$", "")
  local key = clean_text:lower()

  if normalized_abbr[key] then
    local full = normalized_abbr[key]

    -- Debug log
    io.stderr:write("[abbr_auto] Found abbreviation: " .. clean_text .. "\n")

    if not seen[key] then
      seen[key] = true
      save_seen(key)
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
