--[[
  * * * * prog2.lua * * * *
Digital Image Process Program #2: This program does a multitude of neighborhood processes to a given image. 

Authors: Forrest Miller and Katie MacMillan
Class: CSC442/542 Digital Image Processing
Date: 3/14/2017
--]]

-- LuaIP image processing routines
require "ip"
local viz = require "visual"
local il = require "il"

-- our lua routines
local ranks = require "rankFilters"

-- Weiss's Functions
local histo = require "il.histo"
local threshold = require "il.threshold"
local minmax = require "il.minmax"
local median = require "il.median"
local smooth = require "il.smooth"
local utils = require "il.utils"
local edge = require "il.edge"
-----------
-- menus --
-----------
imageMenu("Point Processes",
  {
    {"Grayscale", il.grayscaleYIQ},
    {"Binary Threshold", il.threshold,
      {{name = "threshold", type = "number", displaytype = "slider", default = 128, min = 0, max = 255}}},
  })

-- histogram processes
imageMenu("Histogram Processes",
  {
    {"Display Histogram", il.showHistogram,
      {{name = "Color Mode", type = "string", default = "rgb"}}},
     {"Contrast Stretch", histo.stretchSpecify, hotkey = "C-H",
      {{name = "lp", type = "number", displaytype = "spin", default = 1, min = 0, max = 100},
       {name = "rp", type = "number", displaytype = "spin", default = 99, min = 0, max = 100}}},
     {"Histogram Equalize", il.equalize,
      {{name = "color model", type = "string", default = "yiq"}}},
  })

imageMenu("Noise",
  {
    {"Gaussian noise", il.gaussianNoise,
      {{name = "sigma", type = "number", displaytype = "textbox", default = "16.0"}}},
    {"Impulse Noise", il.impulseNoise,
      {{name = "probability", type = "number", displaytype = "slider", default = 64, min = 0, max = 1000}}},
  })

-- neighborhood processes menu
imageMenu("Neighborhood Processes",
  {
    {"3x3 Smoothing", ranks.smooth},
    {"3x3 Sharpening", ranks.sharpen},
    {"Minimum Filter", ranks.minFilter,
      {{name = "N", type = "number", displaytype = "slider", default = 3, min = 0, max = 255}}},
    {"Maximum Filter", ranks.maxFilter,
      {{name = "N", type = "number", displaytype = "slider", default = 3, min = 0, max = 255}}},
    {"Range Filter", ranks.rangeFilter,
      {{name = "N", type = "number", displaytype = "slider", default = 3, min = 0, max = 255}}},
    {"Meidan Filter", ranks.medianFilter,
      {{name = "N", type = "number", displaytype = "slider", default = 3, min = 0, max = 255}}},
    {"Mean Filter", ranks.meanFilter,
      {{name = "N", type = "number", displaytype = "slider", default = 3, min = 0, max = 255}}},
  })


-- Weiss Processes for testing purposes
imageMenu("Weiss's Processes",
  {
    {"Minimum", minmax.minimum},
    {"Maximum", minmax.maximum},
    {"Range", edge.range},
    {"Median", utils.timed(median.median), {{name = "w", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Mean", smooth.mean, {{name = "w", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
  }
)

-- help menu
imageMenu("Help",
  {
    {"Help", viz.imageMessage("Help", "Really good help.")},
    {"About", viz.imageMessage("Lua Image Neighborhood Processing" .. viz.VERSION, "Authors: Forrest Miller and Katie MacMillan\nClass: CSC442 Digital Image Processing\nDate: March 14th, 2017")},
  }
)

start()