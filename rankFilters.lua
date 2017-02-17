local color = require "il.color"

local function sort(intensities)
  sorted = {}
  for i = 1, #intensities do
    if table.getn(sorted) == 0 then
      table.insert(sorted, 1, intensities[i])
    else
      local j = 1
      -- walk through sorted
      while j <= table.getn(sorted) and i < sorted[j] do
      -- see if i < sorted[j]
        j = j+1
      end
      -- insert i into sorted at j-1
      table.insert(sorted, j-1, intensities[i])

    end
  end
  return sorted
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
    if n < 3 then return img end
  if n%2 == 0 then n = n + 1 end
  
  img = color.RGB2YIQ(img)
  local cpy = img:clone()
  local rows, cols = img.height, img.width
  local offset = math.floor(n/2)
  
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      -- set up table to store pixel intensities
      local pixels = {}
      for i = -1 * offset, offset do
        for j = -1 * offset, offset do
          local curRow = r + i
          local curCol = c + j
          -- make sure index is within row and column bounds
          if ( curRow > -1 ) and (curCol > -1 ) 
          and ( curRow < rows - 1 ) and (curCol < cols - 1 ) then
            -- add each intensity to front of the array (table)
            table.insert(pixels, 1, img:at(curRow, curCol).y)
          end
        end
      end
      pixels = sort(pixels)
      local mid = math.floor((table.getn(pixels)/2)+0.5)
      if mid == 0 then
        mid = 1
      end
      
      print(mid)
      cpy:at(r,c).y = pixels[mid]
    end
  end
  
  return color.YIQ2RGB(cpy)
end
local function meanFilter( img, n )
  if n < 3 then return img end
  if n%2 == 0 then n = n + 1 end
  
  img = color.RGB2YIQ(img)
  local cpy = img:clone()
  local rows, cols = img.height, img.width
  local offset = math.floor(n/2)
  
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
    local sum = 0
    -- track how many pixels are being added up for division later
    local pixels = 0
      
      for i = -1 * offset, offset do
        for j = -1 * offset, offset do
          local curRow = r + i
          local curCol = c + j
          -- make sure index is within row and column bounds
          if ( curRow > -1 ) and (curCol > -1 ) 
          and ( curRow < rows - 2 ) and (curCol < cols - 2 ) then
            sum = sum + img:at(curRow, curCol).y
            -- track how many pixels are being added up for division later
            pixels = pixels + 1
          end
        end
    end
      cpy:at(r,c).y = math.floor((sum/pixels)+0.5)
    end
  end
  
  return color.YIQ2RGB(cpy)
  
end

local function rangeFilter( img, n )
  if n < 3 then return img end
  if n%2 == 0 then n = n + 1 end
  
  local cpy = img:clone()
  img = color.RGB2YIQ(img)
  local rows, cols = img.height, img.width
  local offset = math.floor(n/2)
  
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
    local max = 0
    local min = 255
      
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
            if intensity < min then
              min = intensity
            end
        end
      end
    end
      local range = max - min
      cpy:at(r,c).r = range
      cpy:at(r,c).g = range
      cpy:at(r,c).b = range
    end
  end
  
  return cpy
  
end

-- this is a filter with all 1's right now.
-- I messed something up trying to make it use other values
-- Will revisit after OS test.
local function smooth( img )
  local nrows, ncols = img.height, img.width
  
  img = color.RGB2YIQ(img)
  local res = img:clone()
  
  for r = 1, nrows - 2 do
    for c = 1, ncols - 2 do
      local sum = 0
      
      for i = -1, 1 do
        for j = -1, 1 do
          sum = sum + img:at(r + i, c + j).y
        end
      end
      
      res:at(r, c).y = sum / 9
    end
  end
  
  return color.YIQ2RGB(res)
end

-- same code as smooth right now...when I get smooth sharpen should be easier
local function sharpen( img )
  local nrows, ncols = img.height, img.width
  
  img = color.RGB2YIQ(img)
  local res = img:clone()
  
  for r = 1, nrows - 2 do
    for c = 1, ncols - 2 do
      local sum = 0
      
      for i = -1, 1 do
        for j = -1, 1 do
          --sum = sum + img:at(r + i, c + j).y
        end
      end
      
      --res:at(r, c).y = sum / 9
    end
  end
  
  return color.YIQ2RGB(res)
end

return {
  minFilter = minFilter,
  maxFilter = maxFilter,
  rangeFilter = rangeFilter,
  medianFilter = medianFilter,
  meanFilter = meanFilter,
  smooth = smooth,
  sharpen = sharpen,
  }

