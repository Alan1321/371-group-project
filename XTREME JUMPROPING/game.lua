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
local t
local t2
local t3

local function projectilee()
    print("im in projectileee")
    -- Create projectile object
    local proj = display.newCircle( 10, 800, 24 )
    proj:setFillColor( 1,0.2,0.2 )
    proj.objType = "proj"
    proj.gravityScale = 0
    --sceneGroup:insert(proj)
    -- Add physical body to object
    physics.addBody( proj, { bounce=0.5, density=0.0, radius=24 } )
 
    -- Apply velocity values to object
    local vx, vy = 300, -120
    proj:setLinearVelocity( vx, vy )
end

local function projectilee2()
    print("im in projectileee")
    -- Create projectile object
    local proj = display.newCircle( display.contentWidth - 50, 400, 24 )
    proj:setFillColor( 1,0.2,0.2 )
    proj.objType = "proj"
    proj.gravityScale = 0
    --sceneGroup:insert(proj)
    -- Add physical body to object
    physics.addBody( proj, { bounce=0.5, density=0.0, radius=24 } )
 
    -- Apply velocity values to object
    local vx, vy = -300, -120
    proj:setLinearVelocity( vx, vy )
end

local function projectilee3()
    print("im in projectileee")
    -- Create projectile object
    local proj = display.newCircle( 10, 100, 24 )
    proj:setFillColor( 1,0.2,0.2 )
    proj.objType = "proj"
    proj.gravityScale = 0
    --sceneGroup:insert(proj)
    -- Add physical body to object
    physics.addBody( proj, { bounce=0.5, density=0.0, radius=24 } )
 
    -- Apply velocity values to object
    local vx, vy = 300, -120
    proj:setLinearVelocity( vx, vy )
end

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
        if(event.other.objType == "ground") then
            print("ground collision")
            jump = 0
        elseif event.other.objType == "proj" then
            print('projectile collision')
            physics.pause()
            timer.pause(t)
            timer.pause(t2)
            timer.pause(t3)
        end
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

    local jumpButton = display.newRect( display.contentWidth/2, display.contentHeight - 100, 50, 50 )
    jumpButton.strokeWidth = 3
    jumpButton:setFillColor( 0.5 )
    jumpButton:setStrokeColor( 1, 0, 0 )
    jumpButton:addEventListener("tap", touchAction)
    sceneGroup:insert(jumpButton)


    
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
      t = timer.performWithDelay( 2000, projectilee, 0)
      t2 = timer.performWithDelay(4000, projectilee2, 0)
      t3 = timer.performWithDelay(6000, projectilee3, 0)
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