local composer = require("composer")

local scene = composer.newScene()
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
  local sceneGroup = self.view

  local header = display.newText ("Game Creators:", display.contentCenterX, 200, native.systemFontBold, 50)
  header:setFillColor (100,0,0)
  sceneGroup:insert(header)
  
  local connor = display.newText ("Connor Bleisch", display.contentCenterX, 300, native.systemFontBold, 50)
  connor:setFillColor (100,0,0)
  sceneGroup:insert(connor)

  local ryan = display.newText ("Ryan Burton", display.contentCenterX, 400, native.systemFontBold, 50)
  ryan:setFillColor (100,0,0)
  sceneGroup:insert(ryan)

  local kennedy = display.newText ("Kennedy Kuria", display.contentCenterX, 500, native.systemFontBold, 50)
  kennedy:setFillColor (100,0,0)
  sceneGroup:insert(kennedy)

  local alan = display.newText ("Alan Subedi", display.contentCenterX, 600, native.systemFontBold, 50)
  alan:setFillColor (100,0,0)
  sceneGroup:insert(alan)


  
   local buttonBack1 = widget.newButton(
      {
          label = "Back to Main Menu",
          onEvent = handleButtonEvent,
          emboss = false,
          shape = "roundedRect",
          width = 400,
          height = 80,
          cornerRadius = 2,
          fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
          strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
          strokeWidth = 4
      }
  )
  buttonBack1.x = display.contentCenterX
  buttonBack1.y = 100
  sceneGroup:insert(buttonBack1);

  local options = {
      effect = "slideDown",
      time = 500
  }
  local function back (event)
      composer.gotoScene("scene1", options);
  end
  buttonBack1:addEventListener("tap", back);    

 
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene