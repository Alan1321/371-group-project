local composer = require("composer")
local physics = require( "physics" )
local scene = composer.newScene()
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"

local baseLevel = display.contentHeight - 270
local baseFooting = display.contentHeight - 200
local jump = 0

function scene:create( event )
 
    physics.start()
   local sceneGroup = self.view

   local image = display.newImageRect("background.png", 640, 1140)
   image.x = display.contentCenterX
   image.y = display.contentCenterY
   sceneGroup:insert(image)

   local ground = display.newRect( display.contentWidth/2, baseFooting, display.contentWidth, 1 )
   ground.strokeWidth = 3
   ground:setFillColor( 1 )
   ground:setStrokeColor( 1, 1, 1 )
   ground.objType = "ground"
   physics.addBody( ground, "static", { bounce=0.0, friction=0.3 } )   
   sceneGroup:insert(ground)    

   local player = display.newRect( display.contentWidth/2, baseLevel, 50, 150 )
   player.strokeWidth = 3
   player:setFillColor( 0.5 )
   player:setStrokeColor( 1, 0, 0 )
   
   physics.addBody( player, "dynamic",
        { density=1.0, bounce=0.0 },  -- Main body element
        { box={ halfWidth=30, halfHeight=10, x=0, y=60 }, isSensor=true }  -- Foot sensor element
    )
    player.isFixedRotation = true
    player.sensorOverlaps = 0

    local function sensorCollide( self, event )
        print('im in sensorCollide')
        -- Confirm that the colliding elements are the foot sensor and a ground object  
        jump = 0
    end

    player.collision = sensorCollide
    player:addEventListener( "collision" )

    sceneGroup:insert(player)
    
    local function touchAction( event )
        jump = jump + 1
        if(jump <= 2) then        
            local vx, vy = player:getLinearVelocity()
            player:setLinearVelocity( vx, -150 )
            player:applyLinearImpulse( nil, -75, player.x, player.y )
        end
    end

    local myRectangle = display.newRect( display.contentWidth/2, display.contentHeight - 100, 50, 50 )
    myRectangle.strokeWidth = 3
    myRectangle:setFillColor( 0.5 )
    myRectangle:setStrokeColor( 1, 0, 0 )
    myRectangle:addEventListener("tap", touchAction)
    sceneGroup:insert(myRectangle)

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