local color = require "il.color"

--[[
  Function Name: sobelX
  
  Description:  sobelX calculates the rate of change of
                a neighborhood of pixels in the X direction
  
  Params:  img - the image being evaluated
          rows - the number of rows of pixels in the image
          cols - the number of columns of pixels in the image
             r - the current row of the target pixel
             c - the current column of the target pixel
  
  Returns:  the change in intensities in the X direction for the
            neighborhood of the target pixel (r,c)
--]]
local function sobelX(img, rows, cols, r, c)
  local x = 0

  -- check for neighborhood row bounds
  if r > 0  and r < rows-1 then
    -- use all rows
    if c > 0 and c < cols-1 then
      -- use cols c-1 & c+1
      x = (-1 * img:at(r-1,c-1).y) + (1 * img:at(r-1,c+1).y)
      x = x + (-2 * img:at(r,c-1).y) + (2 * img:at(r,c+1).y)
      x = x + (-1 * img:at(r+1,c-1).y) + (1 * img:at(r+1,c+1).y)
      
    elseif c == 0 then
      -- use col c+1
      x = (1 * img:at(r-1,c+1).y) + (2 * img:at(r,c+1).y) + (1 * img:at(r+1,c+1).y)
    elseif c == cols-1 then
      -- use col c-1
      x = (-1 * img:at(r-1,c-1).y) + (-2 * img:at(r,c-1).y) + (-1 * img:at(r+1,c-1).y)
    end

  elseif r == 0 then
    -- use rows r & r+1
    if c > 0 and c < cols-1 then
      -- use cols c-1 & c+1
      x = (-2 * img:at(r,c-1).y) + (2 * img:at(r,c+1).y)
      x = x + (-1 * img:at(r+1,c-1).y) + (1 * img:at(r+1,c+1).y)
    elseif c == 0 then
      -- use col c+1      
      x = (2 * img:at(r,c+1).y) + (1 * img:at(r+1,c+1).y)
    elseif c == cols-1 then
      -- use cols c-1
      x = (-2 * img:at(r,c-1).y) + (-1 * img:at(r+1,c-1).y)
    end
  elseif r == rows-1 then
    -- use in rows r & r-1
    if c > 0 and c < cols-1 then
      -- use cols c-1 & c+1
      x = (-1 * img:at(r-1,c-1).y) + (1 * img:at(r-1,c+1).y)
      x = x + (-2 * img:at(r,c-1).y) + (2 * img:at(r,c+1).y)
    elseif c == 0 then
      -- use col c+1
      x = (1 * img:at(r-1,c+1).y) + (2 * img:at(r,c+1).y)
    elseif c == cols-1 then
      -- use col c-1
      x = (-1 * img:at(r-1,c-1).y) + (-2 * img:at(r,c-1).y)
    end      
  end
  
  return x
end

--[[
  Function Name: sobelY
  
  Author: Katie MacMillan
  
  Description:  sobelY calculates the rate of change of
                a neighborhood of pixels in the Y direction
  
  Params:  img - the image being evaluated
          rows - the number of rows of pixels in the image
          cols - the number of columns of pixels in the image
             r - the current row of the target pixel
             c - the current column of the target pixel
  
  Returns:  the change in intensities in the Y direction for the
            neighborhood of the target pixel (r,c)
--]]
local function sobelY(img, rows, cols, r, c)
  local y = 0
  
  if r > 0  and r < rows-1 then
    -- use all rows r-1 & r+1
    if c > 0 and c < cols-1 then
      -- use all cols
      y = (1 * img:at(r-1,c-1).y)  + (2 * img:at(r-1,c).y)  + (1 * img:at(r-1,c+1).y)
      y = y + (-1 * img:at(r+1,c-1).y) + (-2 * img:at(r+1,c).y) + (-1 * img:at(r+1,c+1).y)
    elseif c == 0 then
      -- use cols c & c+1
      y = (2 * img:at(r-1,c).y)  + (1 * img:at(r-1,c+1).y)
      y = y + (-2 * img:at(r+1,c).y) + (-1 * img:at(r+1,c+1).y)
    elseif c == cols-1 then
      -- use cols c-1 & c
      y = (1 * img:at(r-1,c-1).y)  + (2 * img:at(r-1,c).y)
      y = y + (-1 * img:at(r+1,c-1).y) + (-2 * img:at(r+1,c).y)
    end
  elseif r == 0 then
    -- use row r+1
    if c > 0 and c < cols-1 then
      -- use all cols
      y = (-1 * img:at(r+1,c-1).y) + (-2 * img:at(r+1,c).y) + (-1 * img:at(r+1,c+1).y)
    elseif c == 0 then
      -- use cols c & c+1
      y = (-2 * img:at(r+1,c).y) + (-1 * img:at(r+1,c+1).y)
    elseif c == cols-1 then
      -- use cols c-1 & c
      y = (-1 * img:at(r+1,c-1).y) + (-2 * img:at(r+1,c).y)
    end
  elseif r == rows-1 then
    -- use row r-1
    if c > 0 and c < cols-1 then
      -- use cols c-1 & c+1
      y = (1 * img:at(r-1,c-1).y) + (2 * img:at(r-1,c).y)  + (1 * img:at(r-1,c+1).y)
    elseif c == 0 then
      -- use cols c & c+1
      y = (2 * img:at(r-1,c).y) + (1 * img:at(r-1,c+1).y)
    elseif c == cols-1 then
      -- use cols c-1 & c
      y = (1 * img:at(r-1,c-1).y) + (2 * img:at(r-1,c).y)
    end

  end

  
  return y
end

--[[
  Function Name: magnitude
  
  Author: Katie MacMillan
  
  Description: magnitude calculates the magnitude
          of change of pixel intensities, using
          the Sobel filters, and sets the
          magnitude of change around each pixel
          as the value for that pixel  
  
  Params: img - the image to be processed
  
  Returns: the new magnitude based image
--]]
local function magnitude( img )
  local cpy = img:clone()
  img = color.RGB2YIQ( img )
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
      cpy:at(r,c).r = val
      cpy:at(r,c).g = val
      cpy:at(r,c).b = val
    end
  end

  return cpy
end


--[[
  Function Name: direction
  
  Author: Katie MacMillan
  
  Description: direction calculates the theta angle of the
          direction of the change in pixel intensities for a
          target pixel, using the Sobel filters. It then scales
          the theta value to map from 0 to 255 and uses this
          value as the intensity value for all color chanels
          in the target pixel
  
  Params: img - the image to be processed
  
  Returns: the new directional based image
--]]
local function direction( img )
  local cpy = img:clone()
  img = color.RGB2YIQ( img )
  local rows, cols = img.height, img.width
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local x = sobelX(img, rows, cols, r, c)
      local y = sobelY(img, rows, cols, r, c)

      local dir = math.atan2(y,x)
      if dir < 0 then
        dir = dir + (2*math.pi)
      end
      dir = dir * (255/(2*math.pi))
      cpy:at(r,c).r = dir
      cpy:at(r,c).g = dir
      cpy:at(r,c).b = dir
    end
  end

  return cpy
end



return {
  magnitude = magnitude,
  direction = direction
}
