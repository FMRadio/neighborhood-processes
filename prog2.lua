--[[
  * * * * prog2.lua * * * *
Digital Image Process Program #2: This program does a multitude of neighborhood
processes to a given image. This file is the main program which creates the menus.

Authors: Forrest Miller and Katie MacMillan
Class: CSC442/542 Digital Image Processing
Date: 3/16/2017
--]]

-- LuaIP image processing routines
require "ip"
local viz = require "visual"
local il = require "il"

-- our lua routines
local ranks = require "rankFilters"
local edge = require "edge"
local convolution = require "convolution"

-- Weiss's Functions
local histo = require "il.histo"
local threshold = require "il.threshold"
local minmax = require "il.minmax"
local median = require "il.median"
local smooth = require "il.smooth"
local utils = require "il.utils"
local edge2 = require "il.edge"
local stat = require "il.stat"

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
imageMenu("Rank Order Filters",
  {
    {"Minimum Filter", ranks.minFilter,
      {{name = "N", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Maximum Filter", ranks.maxFilter,
      {{name = "N", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Median Filter", ranks.medianFilter,
      {{name = "N", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Median Plus Filter", ranks.medianPlus},
    {"Noise Filter", ranks.noiseFilter, {{name="Threshold", type="number", displaytype="spin", default=64, min = 0, max = 128}}},
  })

-- convolution filter processes menu
imageMenu("Convolution filters",
  {
    {"3x3 Smooth", convolution.smooth},
    {"3x3 Sharpen", convolution.sharpen},
    {"Mean", convolution.meanFilter, 
      {{name = "N", type = "number", displaytype = "spin", default = 3, min = 0, max = 255}}},
    {"Emboss", convolution.emboss},
  }
)

-- edge detection processes menu
imageMenu("Edge detection",
  {
    {"Sobel Edge Mag", edge.magnitudeSobel},
    {"Sobel Edge Dir", edge.directionSobel},
    {"Kirsch Edge Mag", edge.magnitudeKirsch},
    {"Kirsch Edge Dir", edge.directionKirsch},
    {"Range", edge.rangeFilter,
    {{name = "N", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Standard Deviation", edge.deviationFilter, 
      {{name = "N", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Laplacian", edge.laplacian},
  }
)

-- help menu
imageMenu("Help",
  {
    {"Help", viz.imageMessage("Help", "Under the File menu a user can open a new image, save the current image or exit the program.\n\nBy right clicking on the image tab, the user can duplicate or reload the image. The user may also press Ctrl+D to duplicate an image or Crtl+R to reload it.\n\nThere are multiple menus from which to choose. You are able to do some preprocessing with a few point processes. Then edge detectors and other neighborhood processes which have been implemented may be run.\n\nThe user can also add noise to better show the effect of the noise cleaning filters.")},
    {"About", viz.imageMessage("Lua Image Neighborhood Processing" .. viz.VERSION, "Authors: Forrest Miller and Katie MacMillan\nClass: CSC442 Digital Image Processing\nDate: March 16th, 2017")},
  }
)

start()