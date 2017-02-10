--[[
  * * * * prog2.lua * * * *
Digital Image Process Program #2: This program does a multitude of neighborhood processes to a given image. 

Author: Forrest Miller
Class: CSC442/542 Digital Image Processing
Date: 3/14/2017
--]]

-- LuaIP image processing routines
require "ip"
local viz = require "visual"
local il = require "il"

-- our lua routines

-- Weiss's Functions
local histo = require "il.histo"
local threshold = require "il.threshold"

-----------
-- menus --
-----------
imageMenu("Point Processes",
  {
    {"Grayscale", il.grayscaleYIQ},
    
  })

-- neighborhood processes menu
imageMenu("Neighborhood Processes",
  {
    --{"Negate", myip.negate,
      --{{name = "Color Mode", type = "string", default = "rgb"}}},
    --{"Brighten/Darken", myip.brightDark,
      --{{name = "Offset", type = "number", displaytype = "slider", default = 0, min = -255, max = 255},
      --{name = "Color Mode", type = "string", default = "rgb"}}},
    --{"Adjust Contrast", myip.contrast,
        --{{name = "min", type = "number", displaytype = "spin", default = 64, min = 0, max = 255},
        --{name = "max", type = "number", displaytype = "spin", default = 191, min = 0, max = 255}}},
    --{"Grayscale", myip.grayscale},
    --{"Solarize", myip.solarize,
        --{{name = "Threshold", type = "number", displaytype = "slider", default = 128, min = 0, max = 255}}},
    --{"Binary Threshold", myip.binary,
      --{{name = "Threshold", type = "number", displaytype = "slider", default = 128, min = 0, max = 255}}},
    --{"Bit Plane Slicing", myip.bitPlane,
      --{{name = "Bit (0 is LSB)", type = "number", displaytype = "spin", default = 0, min = 0, max = 7}}},
    --{"Gamma", myip.gamma, {{name = "Gamma", type = "number", displaytype = "textbox", default = "1.0"}}},
    })
  
-- histogram processes
imageMenu("Histogram Processes",
  {
    {"Display Histogram", il.showHistogram,
      {{name = "Color Mode", type = "string", default = "rgb"}}},
    --{"Equalize - Specify", myHist.equalize,
      --{{name = "Clip %", type = "number", displaytype = "textbox", default = "1.0"}}},
    --{"Equalize - Auto", myHist.equalize},
    --{"Contrast Stretch - Specify", myHist.contrastStretch,
      --{{name = "Min Percent", type = "number", displaytype = "slider", default = 1, min = 0, max = 50},
      --{name = "Max Percent", type = "number", displaytype = "slider", default = 1, min = 0, max = 50}}},
    --{"Contrast Stretch - Auto", myHist.contrastStretch},
  })


-- help menu
imageMenu("Help",
  {
    {"Help", viz.imageMessage("Help", "Really good help.")},
    {"About", viz.imageMessage("Lua Image Neighborhood Processing" .. viz.VERSION, "Authors: Forrest Miller\nClass: CSC442 Digital Image Processing\nDate: March 14th, 2017")},
  }
)

start()