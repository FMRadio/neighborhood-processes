--[[
  * * * * edge.lua * * * *
  
This file contains the getNeighborhood helper function as well as the edge
detection processes.
--]]

local color = require "il.color"

--[[
  Function Name: getNeighborhood
  
  Description:  getNeighborhood retrieves a 3x3 neighborhood
                of pixels based around an input row and
                column target pixel. If the target pixels is
                on an edge, the other side is reflected into
                the neighborhood as the missing edge.
  
  Params:  img - the image to extract the neighborhood from
             r - the current row of the target pixel
             c - the current column of the target pixel
  
  Returns:  a 2D table containing the 3x3 neighborhood of pixels
            surrounding the and including the target pixel.
--]]
local function getNeighborhood (img, r, c )
  local rows, cols = img.height, img.width
  -- check for neighborhood row bounds
  if r > 0  and r < rows-1 then
    -- use all rows
    if c > 0 and c < cols-1 then
      -- use all cols
      return {{img:at(r-1,c-1).y, img:at(r-1,c).y, img:at(r-1,c+1).y},
              {img:at(r,c-1).y,   img:at(r,c).y,   img:at(r,c+1).y},
              {img:at(r+1,c-1).y, img:at(r+1,c).y, img:at(r+1,c+1).y}}

    elseif c == 0 then
      -- no col c-1, reflect c+1
      return {{img:at(r-1,c+1).y, img:at(r-1,c).y, img:at(r-1,c+1).y},
              {img:at(r,c+1).y,   img:at(r,c).y,   img:at(r,c+1).y},
              {img:at(r+1,c+1).y, img:at(r+1,c).y, img:at(r+1,c+1).y}}
    else
      -- no col c+1 reflect c-1
      return {{img:at(r-1,c-1).y, img:at(r-1,c).y, img:at(r-1,c-1).y},
              {img:at(r,c-1).y,   img:at(r,c).y,   img:at(r,c-1).y},
              {img:at(r+1,c-1).y, img:at(r+1,c).y, img:at(r+1,c-1).y}}
    end

  elseif r == 0 then
    -- no row r-1, reflect row r+1
    if c > 0 and c < cols-1 then
      -- use all cols
      return {{img:at(r+1,c-1).y, img:at(r+1,c).y, img:at(r+1,c+1).y},
              {img:at(r,c-1).y,   img:at(r,c).y,   img:at(r,c+1).y},
              {img:at(r+1,c-1).y, img:at(r+1,c).y, img:at(r+1,c+1).y}}

    elseif c == 0 then
      -- no col c-1, reflect col c+1
      return {{img:at(r+1,c+1).y, img:at(r+1,c).y, img:at(r+1,c+1).y},
              {img:at(r,c+1).y,   img:at(r,c).y,   img:at(r,c+1).y},
              {img:at(r+1,c+1).y, img:at(r+1,c).y, img:at(r+1,c+1).y}}
    else
      -- no col c+1, reflect col c-1
      return {{img:at(r+1,c-1).y, img:at(r+1,c).y, img:at(r+1,c-1).y},
              {img:at(r,c-1).y,   img:at(r,c).y,   img:at(r,c-1).y},
              {img:at(r+1,c-1).y, img:at(r+1,c).y, img:at(r+1,c-1).y}}
    end
  else
    -- no row r+1, reflect row r-1
    if c > 0 and c < cols-1 then
      -- use all cols
      return {{img:at(r-1,c-1).y, img:at(r-1,c).y, img:at(r-1,c+1).y},
              {img:at(r,c-1).y,   img:at(r,c).y,   img:at(r,c+1).y},
              {img:at(r-1,c-1).y, img:at(r-1,c).y, img:at(r-1,c+1).y}}

    elseif c == 0 then
      -- no col c-1, reflect col c+1
       return {{img:at(r-1,c+1).y, img:at(r-1,c).y, img:at(r-1,c+1).y},
              {img:at(r,c+1).y,   img:at(r,c).y,   img:at(r,c+1).y},
              {img:at(r-1,c+1).y, img:at(r-1,c).y, img:at(r-1,c+1).y}}
   else
      -- no col c+1, reflect col c-1
      return {{img:at(r-1,c-1).y, img:at(r-1,c).y, img:at(r-1,c-1).y},
              {img:at(r,c-1).y,   img:at(r,c).y,   img:at(r,c-1).y},
              {img:at(r-1,c-1).y, img:at(r-1,c).y, img:at(r-1,c-1).y}}
    end
  end
end

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
local function sobelX(neighborhood)
  local x = 0
  local filter = {{-1, 0, 1},
                  {-2, 0, 2},
                  {-1, 0, 1}}

    for i = 1, 3 do
    for j = 1, 3 do
      x = x + (neighborhood[i][j] * filter[i][j])
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
local function sobelY(neighborhood)
  local y = 0
  local filter = {{1,   2,  1},
                  {0,   0,  0},
                  {-1, -2, -1}}
  for i = 1, 3 do
    for j = 1, 3 do
      y = y + (neighborhood[i][j] * filter[i][j])
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
      local neighborhood = getNeighborhood(img, r, c)
      local x = sobelX(neighborhood)
      local y = sobelY(neighborhood)
      local val = math.ceil((math.sqrt(( x * x ) + ( y * y ))))
      
      if val > 255 then val = 255
      elseif val < 0 then val = 0 end
      
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
      local neighborhood = getNeighborhood(img, r, c)
      local x = sobelX(neighborhood)
      local y = sobelY(neighborhood)

      local dir = math.atan2(y,x)
      if dir < 0 then dir = dir + (2*math.pi) end
      dir = dir * (255/(2*math.pi))
      
      cpy:at(r,c).r = dir
      cpy:at(r,c).g = dir
      cpy:at(r,c).b = dir
    end
  end

  return cpy
end

--[[
  Function Name: rotateKirsch
  
  Author: Katie MacMillan
  
  Description: rotateKirsch rotates the positions of an input
          3x3 filter counterclockwise by one position.
  
  Params: filter - the 3x3 filter to be rotated
  
  Returns: the newly rotated filter
--]]
local function rotateKirsch (filter)  
  return {{filter[1][2], filter[1][3], filter[2][3]},
    {filter[1][1], filter[2][2], filter[3][3]},
    {filter[2][1], filter[3][1], filter[3][2]}}
end

--[[
  Function Name: kirsch
  
  Author: Katie MacMillan
  
  Description: kirsch calculates the sum of a 
          neighborhood masked with a kirsch filter
          and returns the sum.
  
  Params: neighborhood - the 3x3 neighborhood of image pixels
          filter - the 3x3 filter to be rotated
  
  Returns: the sum of the neighborhood of pixels with the filter applied
--]]
local function kirsch (neighborhood, filter)
  local mag = 0
  
  for i = 1, 3 do
    for j = 1, 3 do
      mag = mag + (neighborhood[i][j] * filter[i][j])
    end
  end
  
  return mag
end

--[[
  Function Name: magnitudeKirsch
  
  Author: Katie MacMillan
  
  Description: magnitudeKirsch starts with a kirsch filter
            and for each target pixel the greatest kirsch
            reaction is stored and then divided by 3. These
            values are clipped to 255 if the value is greater
            than 255 and to 0 if the value is lower than 0.
            The final value is stored in each color channel
            of the corresponding position in a secondary 
            image, creating a grayscale image.
  
  Params: img - the imge to be filtered
  
  Returns: the newly created and modified image
--]]
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

--[[
  Function Name: directionKirsch
  
  Author: Katie MacMillan
  
  Description: directionKirsch starts with a kirsch filter
            and for each target pixel the greatest kirsch
            reaction is, and the rotation iteration are stored.
            The rotation iteration number indicates the multiple
            of 45 degrees from 0 for the direction of the 
            intensity change.
            
            The iteration is multiplied by 45
            and then 22.5 is subtracted to account for the +-22.5
            degrees.The degree direction is then multiplied by
            the number of pixel intensities divided by the total
            number of degrees (360) to get the final intensity. 
            This value is clipped to 255 if the value is greater
            than 255 and to 0 if the value is lower than 0.
            
            The final value is stored in each color channel
            of the corresponding position in a secondary 
            image, creating a grayscale image.
  
  Params: img - the imge to be filtered
  
  Returns: the newly created and modified image
--]]
local function directionKirsch( img )
  local cpy = img:clone()
  img = color.RGB2YIQ( img )
  local filter = {{-3, -3, -3},
                  {-3,  0,  5},
                  {-3,  5,  5}}
  local rows, cols = img.height, img.width
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local neighborhood = getNeighborhood(img, r, c)
      local maxMag = 0
      local dir = 0
      
      for i = 1, 8 do
        filter = rotateKirsch(filter)

        local mag = kirsch(neighborhood, filter)
          -- store which rotation contained the maximum reaction
        if mag > maxMag then 
          maxMag = mag
          dir = i
        end
      end
      
      -- get angle of change (+/- 22.5 degrees) and scale to 255 intensities
      local intensity = ((dir * 45) - 22.5) * (255/360)
      
      -- clip intensity
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

--[[
  Function Name: laplacian
  
  Author: Forrest Miller
  
  Description: The laplacian function uses the filter shown to calculate a sum.
  We then add the offset and clip before assigning the value to the r, g and b.
  
  Params: img - the image to be processed
  
  Returns: the new image
--]]
local function laplacian(img)
  local rows, cols = img.height, img.width
  local offset = 128
  local filter = {{0, -1, 0},
                  {-1, 4, -1},
                  {0, -1, 0}}
  
  local cpy = img:clone()
  img = color.RGB2YIQ(img)
  
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local sum = 0
      local neighborhood = getNeighborhood(img, r, c)
      
      for i = 1, 3 do
        for j = 1, 3 do
          -- perform laplacian with offset
          sum = sum + (neighborhood[i][j] * filter[i][j]);
        end
      end
      
      sum = sum + offset
      
      if sum < 0 then sum = 0
      elseif sum > 255 then sum = 255 end
      
      cpy:at(r, c).r = sum
      cpy:at(r, c).g = sum
      cpy:at(r, c).b = sum
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
  getNeighborhood = getNeighborhood,
  laplacian = laplacian,
}