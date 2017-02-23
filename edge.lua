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
  Function Name: magnitudeSobel
  
  Author: Katie MacMillan
  
  Description: magnitudeSobel calculates the magnitude
          of change of pixel intensities, using
          the Sobel filters, and sets the
          magnitude of change around each pixel
          as the value for that pixel  
  
  Params: img - the image to be processed
  
  Returns: the new magnitude based image
--]]
local function magnitudeSobel( img )
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
  Function Name: directionSobel
  
  Author: Katie MacMillan
  
  Description: directionSobel calculates the theta angle of the
          direction of the change in pixel intensities for a
          target pixel, using the Sobel filters. It then scales
          the theta value to map from 0 to 255 and uses this
          value as the intensity value for all color chanels
          in the target pixel
  
  Params: img - the image to be processed
  
  Returns: the new directional based image
--]]
local function directionSobel( img )
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




local function rotateKirsch (filter)  
  return {{filter[1][2], filter[1][3], filter[2][3]},
    {filter[1][1], filter[2][2], filter[3][3]},
    {filter[2][1], filter[3][1], filter[3][2]}}
end

local function getNeighborhood (img, r, c )
  local rows, cols = img.height, img.width
  -- check for neighborhood row bounds
  if r > 0  and r < rows-1 then
    -- use all rows
    if c > 0 and c < cols-1 then
      -- use all cols
      return {{img:at(r-1,c-1).y, img:at(r-1,c).y, img:at(r-1,c+1).y},
        {img:at(r,c-1).y, img:at(r,c).y, img:at(r,c+1).y},
        {img:at(r+1,c-1).y, img:at(r+1,c).y, img:at(r+1,c+1).y}}

    elseif c == 0 then
      -- no col c-1
      return {{0, img:at(r-1,c).y, img:at(r-1,c+1).y},
        {0, img:at(r,c).y, img:at(r,c+1).y},
        {0, img:at(r+1,c).y, img:at(r+1,c+1).y}}
    else
      -- no col c+1
      return {{img:at(r-1,c-1).y, img:at(r-1,c).y, 0},
        {img:at(r,c-1).y, img:at(r,c).y, 0},
        {img:at(r+1,c-1).y, img:at(r+1,c).y, 0}}
    end

  elseif r == 0 then
    -- no row r-1
    if c > 0 and c < cols-1 then
      -- use all cols
      return {{0, 0, 0},
        {img:at(r,c-1).y, img:at(r,c).y, img:at(r,c+1).y},
        {img:at(r+1,c-1).y, img:at(r+1,c).y, img:at(r+1,c+1).y}}

    elseif c == 0 then
      -- no col c-1
      return {{0, 0, 0},
        {0, img:at(r,c).y, img:at(r,c+1).y},
        {0, img:at(r+1,c).y, img:at(r+1,c+1).y}}
    else
      -- no col c+1
      return {{0, 0, 0},
        {img:at(r,c-1).y, img:at(r,c).y, 0},
        {img:at(r+1,c-1).y, img:at(r+1,c).y, 0}}
    end
  else
    -- no row r+1
    if c > 0 and c < cols-1 then
      -- use all cols
      return {{img:at(r-1,c-1).y, img:at(r-1,c).y, img:at(r-1,c+1).y},
        {img:at(r,c-1).y, img:at(r,c).y, img:at(r,c+1).y},
        {0, 0, 0}}

    elseif c == 0 then
      -- no col c-1
      return {{0, img:at(r-1,c).y, img:at(r-1,c+1).y},
        {0, img:at(r,c).y, img:at(r,c+1).y},
        {0, 0, 0}}
    else
      -- no col c+1
      return {{img:at(r-1,c-1).y, img:at(r-1,c).y, 0},
        {img:at(r,c-1).y, img:at(r,c).y, 0},
        {0, 0, 0}}
    end
  end
end

local function kirsch (neighborhood, filter)
  local mag = 0
  
  for i = 1, 3 do
    for j = 1, 3 do
      mag = mag + (neighborhood[i][j] * filter[i][j])
    end
  end
  
  return mag

end

local function magnitudeKirsch( img )
  local cpy = img:clone()
  local rows, cols = img.height, img.width
  local filter = {{-3,  5,  5},
                  {-3,  0,  5},
                  {-3, -3, -3}}
  
  img = color.RGB2YIQ( img )
  
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local neighborhood = getNeighborhood(img, r, c)
      local maxMag = 0
      for i = 1, 8 do
        filter = rotateKirsch(filter)

        local mag = kirsch(neighborhood, filter)

        if mag > maxMag then maxMag = mag end
      end
      maxMag = maxMag/3

      if maxMag > 255 then maxMag = 255
      elseif maxMag < 0 then maxMag = 0 end
      cpy:at(r,c).r = maxMag
      cpy:at(r,c).g = maxMag
      cpy:at(r,c).b = maxMag

    end
  end

  return cpy
end
local function directionKirsch( img )
    local cpy = img:clone()
  img = color.RGB2YIQ( img )
  local filter = {{-3, 5, 5},
    {-3, 0, 5},
    {-3, -3, -3}}
  local rows, cols = img.height, img.width
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local neighborhood = getNeighborhood(img, r, c)
      local maxMag = 0
      local i = 0
      local dir = 0
      for i = 1, 8 do
        filter = rotateKirsch(filter)

        local mag = kirsch(neighborhood, filter)

        if mag > maxMag then 
          maxMag = mag
          dir = i
        end
      end
      dir = (dir * 45) - 22.5
      local intensity = dir * (360/255)
      if intensity > 255 then intensity = 255
      elseif intensity < 0 then intensity = 0 end
      cpy:at(r,c).r = intensity
      cpy:at(r,c).g = intensity
      cpy:at(r,c).b = intensity

    end
  end

  return cpy
end

--[[
  Function Name: deviationFilter
  
  Author: Katie MacMillan
  
  Description: deviationFilter evaluates a neighborhood of nxn
        pixels around a target pixel and sets the target
        pixel to the value of the standard deviation for all
        of the pixel values in the neighborhood
  
  Params: img - the image to be processed
            n - the size of the neighborhood
  
  Returns: the new filtered image
--]]
local function deviationFilter( img, n )

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
      local mean = math.floor((sum/pixels)+0.5)
      sum = 0
      for i = -1 * offset, offset do
        for j = -1 * offset, offset do
          local curRow = r + i
          local curCol = c + j
          -- make sure index is within row and column bounds
          if ( curRow > -1 ) and (curCol > -1 ) 
          and ( curRow < rows - 2 ) and (curCol < cols - 2 ) then
            local diff = (img:at(curRow, curCol).y - mean)
            sum = sum + (diff * diff)
          end
        end
      end
      cpy:at(r,c).y = math.floor((math.sqrt(sum/pixels))+0.5)
    end
  end

  return color.YIQ2RGB(cpy)

end


--[[
  Function Name: rangeFilter
  
  Author: Katie MacMillan
  
  Description: rangeFilter evaluates a neighborhood of nxn
        pixels around a target pixel and sets the target
        pixel to the difference between the largest pixel 
        value and smallest pixel value in the neighborhood
  
  Params: img - the image to be processed
            n - the size of the neighborhood
  
  Returns: the new filtered image
--]]
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


return {
  magnitudeSobel = magnitudeSobel,
  directionSobel = directionSobel,
  magnitudeKirsch = magnitudeKirsch,
  directionKirsch = directionKirsch,
  deviationFilter = deviationFilter,
  rangeFilter = rangeFilter,
}
