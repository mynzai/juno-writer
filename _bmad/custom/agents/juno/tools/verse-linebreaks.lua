-- verse-linebreaks.lua
-- Pandoc Lua filter for verse formatting in exports.
--
-- Two fixes:
--   1. Blockquote verse: consecutive `> ` lines collapse into a single
--      paragraph — convert SoftBreak to LineBreak so each line renders.
--   2. Inline verse citations: quoted text containing " / " is extracted
--      from the prose paragraph into a standalone indented BlockQuote,
--      with slashes replaced by line breaks.

-- 1. Preserve line breaks in blockquote verse
function BlockQuote(el)
  return el:walk {
    SoftBreak = function()
      return pandoc.LineBreak()
    end
  }
end

-- Check if an inline list contains the verse slash pattern: Space "/" Space
local function has_verse_slashes(inlines)
  for i = 1, #inlines - 2 do
    if inlines[i].t == "Space"
      and inlines[i + 1].t == "Str"
      and inlines[i + 1].text == "/"
      and inlines[i + 2].t == "Space"
    then
      return true
    end
  end
  return false
end

-- Replace Space + "/" + Space with LineBreak
local function convert_verse_slashes(inlines)
  local result = pandoc.List()
  local i = 1
  while i <= #inlines do
    if i + 2 <= #inlines
      and inlines[i].t == "Space"
      and inlines[i + 1].t == "Str"
      and inlines[i + 1].text == "/"
      and inlines[i + 2].t == "Space"
    then
      result:insert(pandoc.LineBreak())
      i = i + 3
    else
      result:insert(inlines[i])
      i = i + 1
    end
  end
  return result
end

-- Trim trailing Space elements
local function trim_trailing(inlines)
  while #inlines > 0 and inlines[#inlines].t == "Space" do
    inlines:remove(#inlines)
  end
  return inlines
end

-- Trim leading Space elements
local function trim_leading(inlines)
  while #inlines > 0 and inlines[1].t == "Space" do
    inlines:remove(1)
  end
  return inlines
end

-- 2. Extract inline verse citations into standalone BlockQuotes
function Para(el)
  -- Quick check: does this paragraph contain any verse Quoted nodes?
  local found = false
  for _, item in ipairs(el.content) do
    if item.t == "Quoted" and has_verse_slashes(item.content) then
      found = true
      break
    end
  end

  if not found then
    return el
  end

  -- Split the paragraph around each verse citation
  local blocks = pandoc.List()
  local current = pandoc.List()

  for _, item in ipairs(el.content) do
    if item.t == "Quoted" and has_verse_slashes(item.content) then
      -- Flush accumulated prose as a paragraph
      local pre = trim_trailing(current)
      if #pre > 0 then
        blocks:insert(pandoc.Para(pre))
      end

      -- Convert verse slashes to line breaks and wrap in BlockQuote
      local verse = convert_verse_slashes(item.content)
      blocks:insert(pandoc.BlockQuote({pandoc.Para(verse)}))

      -- Reset accumulator for post-quote prose
      current = pandoc.List()
    else
      current:insert(item)
    end
  end

  -- Flush any remaining post-quote prose
  local post = trim_leading(current)
  if #post > 0 then
    blocks:insert(pandoc.Para(post))
  end

  return blocks
end
