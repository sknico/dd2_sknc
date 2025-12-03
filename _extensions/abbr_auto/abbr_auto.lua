
function read_abbreviations()
  -- Get the project root from PANDOC_STATE or fallback to current working directory
  local root = PANDOC_STATE.input_files[1] and pandoc.path.directory(PANDOC_STATE.input_files[1]) or "."
  
  -- Move up until we find abbreviations.yml
  local path = pandoc.path.join({root, "abbreviations.yml"})
  local file = io.open(path, "r")

  -- If not found, try walking up directories
  while not file and root ~= "." do
    root = pandoc.path.directory(root)
    path = pandoc.path.join({root, "abbreviations.yml"})
    file = io.open(path, "r")
  end

  if not file then
    print("Could not find abbreviations.yml")
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
