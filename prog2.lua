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
    --{"Weighted Mean 1", smooth.meanW1, {{name = "w", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    --{"Weighted Mean 2", smooth.meanW2, {{name = "w", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    --{"Gaussian", smooth.meanW3, hotkey = "C-G", {{name = "sigma", type = "string", default = "2.0"}}},
  }
)

-- edge detection processes menu
imageMenu("Edge detection",
  {
    {"Sobel Edge Mag", edge.magnitudeSobel},
    {"Sobel Edge Dir", edge.directionSobel},
    {"Kirsch Edge Mag", edge.magnitudeKirsch},
    {"Kirsch Edge Dir", edge.directionKirsch},
    --{"Morph Gradient", edge.morphGradient},
    {"Range", edge.rangeFilter,
    {{name = "N", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
      --{"Variance", stat.variance, {{name = "w", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Standard Deviation", edge.deviationFilter, 
      {{name = "N", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Laplacian", edge.laplacian},
  }
)

-- Weiss Processes for testing purposes
imageMenu("Weiss's Processes",
  {
    {"Minimum", minmax.minimum},
    {"Maximum", minmax.maximum},
    {"Range", edge2.range},
    {"Median+", median.medianPlus},
    {"Median", utils.timed(median.median), {{name = "w", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Sobel Edge Mag", edge2.sobelMag},
    {"Sobel Edge Dir", il.sobel},
    {"Kirsch Edge Mag/Dir", il.kirsch},

    {"Mean", smooth.mean, {{name = "w", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Std Dev", stat.stdDev, {{name = "w", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Noise Clean", il.noiseClean, 
      {{name = "threshold", type = "number", displaytype = "slider", default = 64, min = 0, max = 256}}},    
    {"Emboss", il.emboss},
    {"Laplacian", il.laplacian},
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