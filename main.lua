-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- main for OlympicQuiz example
--
-----------------------------------------------------------------------------------------

-- even though we only have one scene, we will use the composer library

require("lunatest") --import the test framework
require("Modules.functions") -- import the code to test
require("Tests.Mytest") -- import the tests and run them

local composer = require( "composer" )

-- Code to initialize the app can go here

-- Now load the opening scene

-- Assumes that "questionScene.lua" exists and is configured as a Composer scene
composer.gotoScene( "homeScreen" )