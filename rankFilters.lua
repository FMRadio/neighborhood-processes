local color = require "il.color"
local edge = require "edge"

--[[
  Function Name: sort
  
  Author: Katie MacMillan
  
  Description:  sort takes in a list of intensity
                values and sorts them in decending
                order
  Params: intensities - a list of intensity values
  
  Returns: a sorted list of the original intensity values
--]]
local function sort(intensities, left, right)
  local i = left
  local j = right
  local tmp
  local pivot = intensities[math.floor((left + right) / 2)]

  while i <= j do
    while intensities[i] < pivot do
      i = i + 1
    end

    while intensities[j] > pivot do
      j = j - 1
    end

    if i <= j then
      tmp = intensities[i]
      intensities[i] = intensities[j]
      intensities[j] = tmp
      i = i + 1
      j = j - 1
    end
  end

  if left < j then
    intensities = sort(intensities, left, j)
  end
  if i < right then
    intensities = sort(intensities, i, right)
  end
 
  return intensities
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
      pixels = sort(pixels, 1, table.getn(pixels))
      local mid = math.floor((table.getn(pixels)/2)+0.5)
      if mid == 0 then
        mid = 1
      end

      cpy:at(r,c).y = pixels[mid]
    end
  end

  return color.YIQ2RGB(cpy)
end

--[[
  Function Name: medianPlusFilter
  
  Author: Forrest Miller
  
  Description: medianPlusFilter evaluates the neighborhood
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

  for r = 1, nrows - 2 do
    for c = 1, ncols - 2 do
      local pixels = {}
      local sum = 0

      for i = 0, 2 do
        for j = 0, 2 do          
          if filter[(i*3) + j + 1] == 1 then
            table.insert(pixels, 1, img:at(r+(i-1), c+(j-1)).y)
          end
        end
      end

      pixels = sort(pixels)
      local mid = math.floor((table.getn(pixels)/2)+0.5)

      if mid == 0 then
        mid = 1
      end

      res:at(r, c).y = pixels[mid]
    end
  end

  return color.YIQ2RGB(res)
end

--[[
  Function Name: noiseFilter
  
  Author: Katie MacMillan
  
  Description: noiseFilter evaluates a the neighborhood of
        pixels around a target pixel, not including the target
        pixel, and compares the target pixel to the average of
        its neighbors. If the difference between the target
        pixel and the average of its neighbors exceeds a user
        defined threshold then the target pixel is set to the
        average of its neighbors, otherwise it is left as its
        original value.
  
  Params: img - the image to be processed
            n - the pixel-average difference threshold
  
  Returns: the new filtered image
--]]
local function noiseFilter( img, n )

  img = color.RGB2YIQ(img)
  local cpy = img:clone()
  local rows, cols = img.height, img.width

  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local curPixel = img:at(r,c).y
      local sum = 0
      local neighborhood = edge.getNeighborhood(img, r, c)
      sum = neighborhood[1][1] + neighborhood[1][2] + neighborhood[1][3] + 
      neighborhood[2][1] + neighborhood[2][3] +
      neighborhood[3][1] + neighborhood[3][2] + neighborhood[3][3]

      local avg = math.floor((sum/8)+0.5)
      local min = avg - n
      local max = avg + n
      if (curPixel > max or curPixel < min) then
        cpy:at(r,c).y = avg
      end

    end
  end

  return color.YIQ2RGB(cpy)

end

return {
  minFilter = minFilter,
  maxFilter = maxFilter,
  deviationFilter = deviationFilter,
  rangeFilter = rangeFilter,
  medianFilter = medianFilter,
  medianPlus = medianPlusFilter,
  noiseFilter = noiseFilter,
}
