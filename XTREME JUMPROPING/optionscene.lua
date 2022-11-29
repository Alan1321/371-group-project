local composer = require("composer")
local scene = composer.newScene()
local touchOn = false; 
local themeSound = audio.loadSound("theme.wav")
 
-- "scene:create()"
function scene:create( event )
 
  local sceneGroup = self.view
  -------------------------------------------------------------------------------------------
  local image = display.newImageRect("background.png", 640, 1140)
  image.x = display.contentCenterX
  image.y = display.contentCenterY
  sceneGroup:insert(image)
  -------------------------------------------------------------------------------------------
  local music = display.newText ("Music", display.contentCenterX, display.contentCenterY - 250, native.systemFontBold, 100)
  music:setFillColor (0,100,0)
  sceneGroup:insert(music)
  -------------------------------------------------------------------------------------------
  local circleButton = widget.newButton(
   {
       onEvent = handleButtonEvent,
       emboss = false,
       shape = "roundedRect",
       width = 300,
       height = 250,
       cornerRadius = 20,
       fillColor = {default={100,100,100}, over={0,0,0}},
       strokeColor = {default={0,100,0}, over={0,0,0}},
       strokeWidth = 5
   }
)
  circleButton.x = display.contentCenterX
  circleButton.y = display.contentCenterY
  sceneGroup:insert(circleButton)
  -------------------------------------------------------------------------------------------
  local function onSwitchPressOn(event)
      touchOn = true;
      audio.play(themeSound)
   end
   local function onSwitchPressOff(event)
      touchOn = false;
      audio.pause(themeSound)
   end

   --Touch button
   local onButton = widget.newSwitch(
      {
         x = display.contentCenterX - 80,
         y = display.contentCenterY - 50,
         style = "radio",
         id = "onButton",
         initialSwitchState = false,
         onPress = onSwitchPressOn

      }
   )
   onButton.width = 100
   onButton.height = 100
   sceneGroup:insert(onButton)
   local offButton = widget.newSwitch(
      {
         x = display.contentCenterX - 80,
         y = display.contentCenterY + 50,
         style = "radio",
         id = "offButton",
         initialSwitchState = false,
         onPress = onSwitchPressOff
      }
   )
   offButton.width = 100
   offButton.height = 100
   sceneGroup:insert(offButton)
   -------------------------------------------------------------------------------------------
   local onText = display.newText ("On", onButton.x + 120, onButton.y, native.systemFont, 70);
   onText:setFillColor (0,100,0);
   sceneGroup:insert(onText)
   local offText = display.newText ("Off", offButton.x + 120, offButton.y, native.systemFont, 70); 
   offText:setFillColor (0,100,0); 
   sceneGroup:insert(offText)
   -------------------------------------------------------------------------------------------
   buttonBack2 = display.newImageRect("backbutton.png", 400, 80)
   buttonBack2.x = display.contentCenterX
   buttonBack2.y = 100
   sceneGroup:insert(buttonBack2);
   backText = display.newText ("Back To Main Menu", buttonBack2.x, buttonBack2.y, native.systemFontBold, 30)
   backText:setFillColor(100, 100, 100)
   sceneGroup:insert(backText)

  local options = {
      effect = "slideDown",
      time = 500
  }
  local function back (event)
      composer.gotoScene("scene1", options);
  end
  buttonBack2:addEventListener("tap", back);    

 
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