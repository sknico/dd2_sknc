
-- Load abbreviations from abbreviations.yml
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

  -- Parse YAML using Pandoc's front matter parser
  local doc = pandoc.read("---\n" .. content .. "\n---", "markdown")
  return doc.meta
end

-- Normalize abbreviations (case-insensitive keys)
local abbreviations = read_abbreviations()
local normalized_abbr = {}
for k, v in pairs(abbreviations) do
  normalized_abbr[k:lower()] = pandoc.utils.stringify(v)
end

-- Track seen abbreviations per page
local seen = {}

-- Replace abbreviation if found
local function replace_if_abbreviation(text)
  -- Remove leading/trailing punctuation for matching
  local clean_text = text:gsub("^[%p]+", ""):gsub("[%p]+$", "")
  local key = clean_text:lower()
  local full = normalized_abbr[key]

  if not full then return nil end

  -- Special case: DD2 (always abbreviation only)
  if key == "dd2" then
    return "<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>"
  end

  -- Default: first occurrence per page shows full description
  if not seen[key] then
    seen[key] = true
    return full .. " (<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>)"
  else
    return "<abbr title=\"" .. full .. "\">" .. clean_text .. "</abbr>"
  end
end

-- Process inline elements recursively
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

    elseif il.t == "RawInline" then
      -- Skip comments
      new:insert(il)

    elseif il.t == "Emph" or il.t == "Strong" or il.t == "Strikeout"
        or il.t == "Superscript" or il.t == "Subscript" or il.t == "SmallCaps"
        or il.t == "Span" or il.t == "Quoted" or il.t == "Cite" then
      il.content = process_inlines(il.content)
      new:insert(il)

    elseif il.t == "Link" or il.t == "Code" or il.t == "Math"
        or il.t == "Image" or il.t == "Note" then
      -- Ignore these completely
      new:insert(il)

    else
      -- Leave other elements unchanged
      new:insert(il)
    end
  end
  return new
end

-- Process block-level elements (only paragraphs and plain text)
local function process_block(block)
  if block.t == "Para" or block.t == "Plain" then
    block.content = process_inlines(block.content)
    return block
  end
  return block
end

-- Entry point: apply transformations to document
function Pandoc(doc)
  seen = {} -- Reset per page
  for i, blk in ipairs(doc.blocks) do
    doc.blocks[i] = process_block(blk)
  end
  return doc
end
