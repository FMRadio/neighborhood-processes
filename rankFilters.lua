local color = require "il.color"

local function sort(intensities)
  sorted = {}
  for i = 1, #intensities do
      -- sort intensities
  end
  
end

local function minFilter( img, n )
  if n < 3 then return img end
  if n%2 == 0 then n = n + 1 end
  
  img = color.RGB2YIQ(img)
  local cpy = img:clone()
  local rows, cols = img.height, img.width
  local offset = math.floor(n/2)
  
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
    local min = 255
      
      for i = -1 * offset, offset do
        for j = -1 * offset, offset do
          local curRow = r + i
          local curCol = c + j
          if ( curRow > -1 ) and (curCol > -1 ) 
          and ( curRow < rows - 2 ) and (curCol < cols - 2 ) then
            local intensity = img:at(curRow, curCol).y
            if intensity < min then
              min = intensity
            end
        end
      end
    end
      cpy:at(r,c).y = min
    end
  end
  
  return color.YIQ2RGB(cpy)
  
end
local function maxFilter( img, n )
  if n < 3 then return img end
  if n%2 == 0 then n = n + 1 end
  
  img = color.RGB2YIQ(img)
  local cpy = img:clone()
  local rows, cols = img.height, img.width
  local offset = math.floor(n/2)
  
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
    local max = 0
      
      for i = -1 * offset, offset do
        for j = -1 * offset, offset do
          local curRow = r + i
          local curCol = c + j
          if ( curRow > -1 ) and (curCol > -1 ) 
          and ( curRow < rows - 2 ) and (curCol < cols - 2 ) then
            local intensity = img:at(curRow, curCol).y
            if intensity > max then
              max = intensity
            end
        end
      end
    end
      cpy:at(r,c).y = max
    end
  end
  
  return color.YIQ2RGB(cpy)
  
end
local function medianFilter( img, n )
end
local function meanFilter( img, n )
end
local function rangeFilter( img, n )
end

return {
  minFilter = minFilter,
  maxFilter = maxFilter,
  }
