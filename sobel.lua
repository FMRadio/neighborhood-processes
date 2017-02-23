local color = require "il.color"

local function sobelX(img, rows, cols, r, c)
  local x = 0
  if r > 0  and r < rows-1 then
    -- use all rows
    if c > 0 and c < cols-1 then
      -- use all cols
      x = (img:at(r - 1, c - 1).y * -1) + (img:at(r-1, c).y * 0) + (img:at(r-1, c + 1).y * 1)
      x = x + (img:at(r, c - 1).y * -2) + (img:at(r, c).y * 0) + (img:at(r, c + 1).y * 2)
      x = x + (img:at(r + 1, c - 1).y * -1) + (img:at(r + 1, c).y * 0) + (img:at(r + 1, c + 1).y * 1)
    elseif c == 0 then
      -- use all rows and cols c & c+1
      x = x + (img:at(r-1, c).y * 0) + (img:at(r-1, c + 1).y * 1)
      x = x + (img:at(r, c).y * 0) + (img:at(r, c + 1).y * 2)
      x = x + (img:at(r + 1, c).y * 0) + (img:at(r + 1, c + 1).y * 1)
    elseif c == cols-1 then
      -- use all rows and cols c-1 & c
      x = (img:at(r - 1, c - 1).y * -1) + (img:at(r-1, c).y * 0)
      x = x + (img:at(r, c - 1).y * -2) + (img:at(r, c).y * 0)
      x = x + (img:at(r + 1, c - 1).y * -1) + (img:at(r + 1, c).y * 0)
    end

  elseif r == 0 then
    -- use rows r-1 & r
    if c > 0 and c < cols-1 then
      -- use all cols
      x = (img:at(r, c - 1).y * -2) + (img:at(r, c).y * 0) + (img:at(r, c + 1).y * 2)
      x = x + (img:at(r + 1, c - 1).y * -1) + (img:at(r + 1, c).y * 0) + (img:at(r + 1, c + 1).y * 1)
    elseif c == 0 then
      -- use cols c & c+1
      x = (img:at(r, c).y * 0) + (img:at(r, c + 1).y * 2) + (img:at(r + 1, c).y * 0) + (img:at(r + 1, c + 1).y * 1)
    elseif c == cols-1 then
      -- use cols c-1 & c
      x = (img:at(r, c - 1).y * -2) + (img:at(r, c).y * 0) + (img:at(r + 1, c - 1).y * -1) + (img:at(r + 1, c).y * 0)
    end
  elseif r == rows-1 then
    -- use in rows r & r+1
    if c > 0 and c < cols-1 then
      -- use all cols
      x = (img:at(r - 1, c - 1).y * -1) + (img:at(r-1, c).y * 0) + (img:at(r-1, c + 1).y * 1)
      x = x + (img:at(r, c - 1).y * -2) + (img:at(r, c).y * 0) + (img:at(r, c + 1).y * 2)
    elseif c == 0 then
      -- use cols c & c+1
      x = (img:at(r-1, c).y * 0) + (img:at(r-1, c + 1).y * 1) + (img:at(r, c).y * 0) + (img:at(r, c + 1).y * 2)
    elseif c == cols-1 then
      -- use cols c-1 & c 
      x = (img:at(r - 1, c - 1).y * -1) + (img:at(r-1, c).y * 0) + (img:at(r, c - 1).y * -2) + (img:at(r, c).y * 0)
    end      
  end
  return x
end

local function magnitude( img )
  img = color.RGB2YIQ( img )
  local cpy = img:clone()
  local rows, cols = img.height, img.width
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local x = sobelX(img, rows, cols, r, c)
      cpy:at(r,c).y = x
    end
  end

  return color.YIQ2RGB(cpy)

end


local function direction (img, n)
end

return {
  magnitude = magnitude,
  direction = direction
}
