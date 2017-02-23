local color = require "il.color"
--[[
  Function Name: 
  
  Author: 
  
  Description: 
  Params: 
  
  Returns: 
--]]
local function sort(intensities)
  sorted = {}
  for i = 1, table.getn(intensities) do
    if table.getn(sorted) == 0 then
      table.insert(sorted, 1, intensities[i])
    else
      local j = 1
      -- walk through sorted
      local count = table.getn(sorted)
      local insertI = intensities[i]
      local compI = sorted[j]

      while (j <= count) and ((compI == insertI) or (compI > insertI)) do
        -- move j forwared until we find the end of sorted or an element larger than intensity
        j = j+1
        compI = sorted[j]
      end
      --if j < count then
      --  j = j+1
      --end

      -- insert intensity into the position of the larger intensity
      table.insert(sorted, j, insertI)
    end
  end
  return sorted
end

--[[
  Function Name: minFilter
  
  Author: Katie MacMillan
  
  Description: minFilter evaluates a neighborhood of nxn
        pixels around a target pixel and sets the target
        pixel to the smallest value in the neighborhood
  
  Params: img - the image to be processed
            n - the size of the neighborhood
  
  Returns: the new filtered image
--]]
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

--[[
  Function Name: maxFilter
  
  Author: Katie MacMillan
  
  Description: maxFilter evaluates a neighborhood of nxn
        pixels around a target pixel and sets the target
        pixel to the largest value in the neighborhood
  
  Params: img - the image to be processed
            n - the size of the neighborhood
  
  Returns: the new filtered image
--]]
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

--[[
  Function Name: medianFilter
  
  Author: Katie MacMillan
  
  Description: medianFilter evaluates a neighborhood of nxn
        pixels around a target pixel and sets the target
        pixel to the median value of all of the pixels in 
        the neighborhood
  
  Params: img - the image to be processed
            n - the size of the neighborhood
  
  Returns: the new filtered image
--]]
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

--[[
  Function Name: medianPlusFilter
  
  Author: Forrest Miller
  
  Description: medianPlusFilter evaluates a the neighborhood
        of pixels immediatly above, below and to either side 
        of a target pixel and sets the target pixel to the 
        median value of all of the pixels in the neighborhood
  
  Params: img - the image to be processed
  
  Returns: the new filtered image
--]]
local function medianPlusFilter( img )
  local nrows, ncols = img.height, img.width
  local filter = {0, 1, 0, 1, 1, 1, 0, 1, 0}

  img = color.RGB2YIQ(img)
  local res = img:clone()

  for r = 0, nrows - 1 do
    for c = 0, ncols - 1 do
      local pixels = {}
      local sum = 0

      for i = 0, 2 do
        for j = 0, 2 do
          if filter[(i*3) + j + 1] == 1 then
            --table.insert(pixels, 1, img:at(r+i, c+j).y)
          end
        end
      end

      --pixels = sort(pixels)
      --local mid = math.floor((table.getn(pixels)/2)+0.5)
      --if mid == 0 then
      --mid = 1
      --end

      --res:at(r, c).y = pixels[mid]
    end
  end

  return color.YIQ2RGB(res)
end

return {
  minFilter = minFilter,
  maxFilter = maxFilter,
  deviationFilter = deviationFilter,
  rangeFilter = rangeFilter,
  medianFilter = medianFilter,
  medianPlus = medianPlusFilter,
}
