local color = require "il.color"
--[[
  Function Name: meanFilter
  
  Author: Katie MacMillan
  
  Description: meanFilter evaluates a neighborhood of nxn
        pixels around a target pixel and sets the target
        pixel to the mean of all of the values in the 
        neighborhood
  
  Params: img - the image to be processed
            n - the size of the neighborhood
  
  Returns: the new filtered image
--]]
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

--[[
  Function Name: smooth
  
  Author: Forrest Miller
  
  Description: 
  
  Params: img - the image to be processed
  
  Returns: the new smoothed image
--]]
local function smooth( img )
  local nrows, ncols = img.height, img.width
  local filter = {1, 2, 1, 2, 4, 2, 1, 2, 1}

  img = color.RGB2YIQ(img)
  local res = img:clone()

  for r = 1, nrows - 2 do
    for c = 1, ncols - 2 do
      local sum = 0

      for i = 0, 2 do
        for j = 0, 2 do
          index = (i * 3) + j
          multiplier = filter[index + 1]
          sum = sum + multiplier*img:at(r+(i-1), c+(j-1)).y
        end
      end

      sum = sum / 16

      if sum > 255 then sum = 255 end
      if sum < 0 then sum = 0 end

      res:at(r, c).y = sum
    end
  end

  return color.YIQ2RGB(res)
end

--[[
  Function Name: sharpen
  
  Author: Forrest Miller
  
  Description: 
  
  Params: img - the image to be processed
  
  Returns: the new sharpened image
--]]
local function sharpen( img )
  local nrows, ncols = img.height, img.width
  local filter = {0, -1, 0, -1, 5, -1, 0, -1, 0}

  img = color.RGB2YIQ(img)
  local res = img:clone()

  for r = 1, nrows - 2 do
    for c = 1, ncols - 2 do
      local sum = 0

      for i = 0, 2 do
        for j = 0, 2 do
          index = (i * 3) + j
          multiplier = filter[index + 1]
          sum = sum + multiplier*img:at(r+(i-1), c+(j-1)).y
        end
      end
      -- am i supposed to rescale differently...?
      if sum > 255 then sum = 255 end
      if sum < 0 then sum = 0 end

      res:at(r, c).y = sum
    end
  end

  return color.YIQ2RGB(res)
end

return {
  meanFilter = meanFilter,
  smooth = smooth,
  sharpen = sharpen,
}
