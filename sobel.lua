local color = require "il.color"

local function sobelX(img, rows, cols, r, c)
  local x = 0

  -- check for neighborhood row bounds
  if r > 0  and r < rows-1 then
    -- use all rows
    if c > 0 and c < cols-1 then
      -- use all cols
      x = (-1 * img:at(r-1,c-1).y) + (1 * img:at(r+1,c-1).y)
      x = x + (-2 * img:at(r-1,c).y) + (2 * img:at(r+1,c).y)
      x = x + (-1 * img:at(r-1,c+1).y) + (1 * img:at(r+1,c+1).y)
    elseif c == 0 then
      -- use col c & c+1
      x = (-2 * img:at(r-1,c).y) + (2 * img:at(r+1,c).y) + (-1 * img:at(r-1,c+1).y)+ (1 * img:at(r+1,c+1).y)
    elseif c == cols-1 then
      -- use col c-1 & c
      x = (-1 * img:at(r-1,c-1).y) + (1 * img:at(r+1,c-1).y) + (-2 * img:at(r-1,c).y) + (2 * img:at(r+1,c).y)
    end

  elseif r == 0 then
    -- use rows r+1 & r
    if c > 0 and c < cols-1 then
      -- use all cols
      x = (1 * img:at(r+1,c-1).y) + (2 * img:at(r+1,c).y) + (1 * img:at(r+1,c+1).y)
    elseif c == 0 then
      -- use col c & c+1      
      x = (2 * img:at(r+1,c).y) + (1 * img:at(r+1,c+1).y)
    elseif c == cols-1 then
      -- use cols c-1 & c
      x =  (1 * img:at(r+1,c-1).y) + (2 * img:at(r+1,c).y)
    end
  elseif r == rows-1 then
    -- use in rows r & r-1
    if c > 0 and c < cols-1 then
      -- use all cols
      x = x + (-1 * img:at(r-1,c-1).y) + (-2 * img:at(r-1,c).y) + (-1 * img:at(r-1,c+1).y)
    elseif c == 0 then
      -- use col c & c+1
      x = (-2 * img:at(r-1,c).y) + (-1 * img:at(r-1,c+1).y)
    elseif c == cols-1 then
      -- use col c-1 & c
      x = (-1 * img:at(r-1,c-1).y) + (-2 * img:at(r-1,c).y)  
    end      
  end
  
  return x
end

local function sobelY(img, rows, cols, r, c)
  local y = 0
  if r > 0  and r < rows-1 then
    -- use all rows
    if c > 0 and c < cols-1 then
      -- use all cols
      y = (-1 * img:at(r-1,c-1).y) + (-2 * img:at(r,c-1).y) + (-1 * img:at(r+1,c-1).y)
      y = y + (1 * img:at(r-1,c+1).y) + (2 * img:at(r,c+1).y) + (1 * img:at(r+1,c+1).y)
    elseif c == 0 then
      -- use cols c & c+1
      y = (1 * img:at(r-1,c+1).y) + (2 * img:at(r,c+1).y) + (1 * img:at(r+1,c+1).y)
    elseif c == cols-1 then
      -- use cols c-1 & c
      y = (-1 * img:at(r-1,c-1).y) + (-2 * img:at(r,c-1).y) + (-1 * img:at(r+1,c-1).y)
    end
  elseif r == 0 then
    -- use row r+1
    if c > 0 and c < cols-1 then
      y = y + (-2 * img:at(r,c-1).y) + (-1 * img:at(r+1,c-1).y)
      y = y + (2 * img:at(r,c+1).y) + (1 * img:at(r+1,c+1).y)
      -- use all cols
    elseif c == 0 then
      -- use cols c & c+1
      y = y + (2 * img:at(r,c+1).y) + (1 * img:at(r+1,c+1).y)
    elseif c == cols-1 then
      -- use cols c-1 & c 
      y = y + (-2 * img:at(r,c-1).y) + (-1 * img:at(r+1,c-1).y)
    end
  elseif r == rows-1 then
    -- use row r-1
    if c > 0 and c < cols-1 then
      -- use all cols
      y = (-1 * img:at(r-1,c-1).y) + (-2 * img:at(r,c-1).y) + (1 * img:at(r-1,c+1).y) + (2 * img:at(r,c+1).y)
    elseif c == 0 then
      -- use cols c & c+1
      y = (1 * img:at(r-1,c+1).y) + (2 * img:at(r,c+1).y)
    elseif c == cols-1 then
      -- use cols c-1 & c
      y = (-1 * img:at(r-1,c-1).y) + (-2 * img:at(r,c-1).y)
    end

  end

  return y
end

local function magnitude( img )
  img = color.RGB2YIQ( img )
  local cpy = img:clone()
  local rows, cols = img.height, img.width
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local x = sobelX(img, rows, cols, r, c)
      local y = sobelY(img, rows, cols, r, c)
      local val = math.ceil((math.sqrt(( x * x ) + ( y * y ))))
      if val > 255 then
        val = 255
      elseif val < 0 then
        val = 0
      end
      
      cpy:at(r,c).y = val
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
