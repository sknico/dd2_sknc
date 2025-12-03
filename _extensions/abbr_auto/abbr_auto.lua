
-- Read abbreviations.yml from project root
local function read_abbreviations()
  local root = os.getenv("QUARTO_PROJECT_DIR") or "."
  local path = root .. "/abbreviations.yml"

  local file = io.open(path, "r")
  if not file then
    io.stderr:write("[abbr_auto] Could not find abbreviations.yml at: " .. path .. "\n")
    return {}
  end

  local content = file:read("*a")
  file:close()

  -- Parse YAML as Pandoc meta via Markdown front matter
  local doc = pandoc.read("---\n" .. content .. "\n---", "markdown")
  return doc.meta
end

-- Load and normalize abbreviations (case-insensitive keys)
local abbreviations = read_abbreviations()
local normalized_abbr = {}
for k, v in pairs(abbreviations) do
  normalized_abbr[k:lower()] = pandoc.utils.stringify(v)
end

-- Persistent state file inside docs/ (resets on full rebuild)
local state_file = (os.getenv("QUARTO_PROJECT_DIR") or ".") .. "/docs/.abbr_seen"

-- Load seen abbreviations from file
local seen = {}
do
  local f = io.open(state_file, "r")
  if f then
    for line in f:lines() do
      local key = line:match("^%s*(.-)%s*$")
      if key and key ~= "" then
        seen[key] = true
      end
    end
    f:close()
  end
end

-- Append newly seen abbreviation to the state file
local function save_seen(key)
  local f = io.open(state_file, "a")
  if f then
    f:write(key .. "\n")
    f:close()
  else
    io.stderr:write("[abbr_auto] WARN: Could not open state_file for append: " .. state_file .. "\n")
  end
end

-- Core replacement logic (returns HTML string or nil)
local function replace_if_abbreviation(text)
  -- Strip leading/trailing punctuation for matching, but keep the cleaned token for output
  local clean_text = text:gsub("^[%p]+", ""):gsub("[%p]+$", "")
  local key = clean_text:lower()

  local full = normalized_abbr[key]
  if not full then return nil end

  if not seen[key] then
    seen[key] = true
    save_seen(key)
    -- First occurrence globally: full text + abbr tag
    return full .. " (<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>)"
  else
    -- Subsequent occurrences: abbr tag only
    return "<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>"
  end
end

-- Recursively process inlines inside Para/Plain, but skip Links/Code/Math/Image/etc.
local function process_inlines(inlines)
  local new = pandoc.List()
  for _, il in ipairs(inlines) do
    if il.t == "Str" then
      local replacement = replace_if_abbreviation(il.text)
      if replacement then
        new:insert(pandoc.RawInline("html", replacement))
      else
        new:insert(il)
      end

    -- Recurse into common inline containers that represent *body text*
    elseif il.t == "Emph" or il.t == "Strong" or il.t == "Strikeout"
        or il.t == "Superscript" or il.t == "Subscript" or il.t == "SmallCaps"
        or il.t == "Span" or il.t == "Quoted" or il.t == "Cite" then
      il.content = process_inlines(il.content)
      new:insert(il)

    -- Do NOT recurse into these: we want to ignore them entirely
    elseif il.t == "Link" or il.t == "Code" or il.t == "Math"
        or il.t == "Image" or il.t == "Note" then
      new:insert(il)

    else
      -- Default: leave unchanged (Space, SoftBreak, LineBreak, etc.)
      new:insert(il)
    end
  end
  return new
end

-- Block-level handler: only process Para and Plain (ignore Headers, Tables, etc.)
local function process_block(block)
  if block.t == "Para" or block.t == "Plain" then
    block.content = process_inlines(block.content)
    return block
  end
  return block
end

-- Entry point: walk blocks and selectively transform paragraphs
function Pandoc(doc)
  local new_blocks = pandoc.List()
  for _, blk in ipairs(doc.blocks) do
    new_blocks:insert(process_block(blk))
  end
  doc.blocks = new_blocks
  return doc
end
