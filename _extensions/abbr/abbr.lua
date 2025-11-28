function Span(el)
  if el.classes:includes("abbr") then
    local title = el.attributes["title"]
    if title then
      return pandoc.RawInline("html", "<abbr title=\"" .. title .. "\">" .. pandoc.utils.stringify(el.content) .. "</abbr>")
    end
  end
end
