local composer = require("composer")
local physics = require("physics")
local Bird = require("Bird")
local Cat = require("Cat")
local Dodgeball = require("Dodgeball")
local scene = composer.newScene()
-------------------------------------------------------------------------------------------
local multiplier = 1
local highScore = 0
local spawnTime = 5000
local score = 0
-------------------------------------------------------------------------------------------
local crowSound = audio.loadSound("Crow.wav")
local ballSound = audio.loadSound("DodgeballHit.wav") 
local catSound = audio.loadSound("Meow.wav")
local jumpSound = audio.loadSound("jumpSound.wav")
local hitSound = audio.loadSound("hitSound.wav")
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
   -------------------------------------------------------------------------------------------
   local image = display.newImageRect("background.png", 640, 1140)
   image.x = display.contentCenterX
   image.y = display.contentCenterY
   sceneGroup:insert(image)
   -------------------------------------------------------------------------------------------
   physics.start()

   scoreText = display.newText("Score: ", 450, 100, native.systemFontBold, 35)
   scoreText:setFillColor(100,0,0)
   sceneGroup:insert(scoreText)
   scoreValue = display.newText(score, 550, 100, native.systemFontBold, 35)
   scoreValue:setFillColor(100,0,0)
   sceneGroup:insert(scoreValue)

   local ground = display.newImage("ground.png", display.contentCenterX, display.contentHeight-60)
   sceneGroup:insert(ground)

   ropeGroup = display.newGroup( )

   ropeLength = display.newRect(0, -150, 20, 300)
   ropeLength:setFillColor(0.8, 0, 0)
   ropeLength.strokeWidth = 2
   ropeLength:setStrokeColor( 1, 1, 1)
   ropeGroup:insert(ropeLength)

   rope = display.newCircle(0, -300, 10)
   rope.tag = "Obstacle"
   rope:setFillColor(1, 0, 0)
   rope.strokeWidth = 2
   rope:setStrokeColor( 1, 1, 1)
   physics.addBody(rope, "static", {radius = 10})
   sceneGroup:insert(rope)
   

   ropeGroup.x = display.contentCenterX
   ropeGroup.y = display.contentHeight-440

   sceneGroup:insert(ropeGroup)

   ropeGroup.rotation = 0
   -------------------------------------------------------------------------------------------
   local options = {
      
      frames = {
      {x = 48, y = 0, width = 16, height = 16},
      {x = 0, y = 80, width = 16, height = 15},
      {x = 16, y = 80, width = 16, height = 15},
      {x = 32, y = 80, width = 16, height = 15},
      {x = 48, y = 80, width = 16, height = 15},
      {x = 0, y = 0, width = 16, height = 16}
      }
   }

   local sheet = graphics.newImageSheet("player.png", options)

   local playerSeq = {
      {name = "jump", start=1,count = 6, time=800, loopCount=1}
   }

   player = display.newSprite(sheet, playerSeq)

   player:setSequence( "jump" )

   player.x = display.contentCenterX
   player.y = display.contentHeight-180

   player.xScale = 10
   player.yScale = 10


   physics.addBody(ground, "static", {bounce = 0})

   physics.addBody(player, "dynamic", {bounce=0, density=20, shape={-50, -70, 50, -70, 50, 70, -50, 70}})

   sceneGroup:insert(player)

   function jump(event)
      if event.phase == "began" then
         if player.y > 900 then
            player:applyForce( 0, -250000, player.x, player.y)
            audio.play(jumpSound)
            player:play()
         end
      end
   end
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase

   params = event.params
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).

      ropeGroup.rotation = 0
      player.rotation = 0
      player:setLinearVelocity( 0, 0 )
      score = 0
      spawnTime = 5000
      player.x = display.contentCenterX
      player.y = display.contentHeight - 180


      ropeGroup.speed = params.startSpeed
      multiplier = params.multiplier
      highScore = 0

   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      function scoreUpdate ()
         score = score + 5
         scoreValue.text = score
      end

      function hitObstacle (event)
         if event.other.tag == "Obstacle" then
            audio.play(hitSound)
            Runtime:removeEventListener( "touch", jump)
            player:removeEventListener( "collision", hitObstacle )
            timer.cancel( updateTimer )
            timer.cancel( ropeTimer )
            timer.cancel( spawner )
            score = score * multiplier
            gameoverText = display.newText ("GAME OVER", display.contentCenterX, display.contentCenterY, native.systemFontBold, 100)
            gameoverText:setFillColor(100,0,0)
            sceneGroup:insert(gameoverText)
            scoreFinalText = display.newText("Score: ", display.contentCenterX-100, display.contentCenterY-100, native.systemFontBold, 50)
            scoreFinalText:setFillColor(100,0,0)
            sceneGroup:insert(scoreFinalText)
            scoreFinalValue = display.newText(score, display.contentCenterX+100, display.contentCenterY-100, native.systemFontBold, 50)
            scoreFinalValue:setFillColor(100,0,0)
            sceneGroup:insert(scoreFinalValue)

            buttonBack2 = display.newImageRect("backbutton.png", 400, 80)
            buttonBack2.x = display.contentCenterX
            buttonBack2.y = display.contentCenterY - 200
            sceneGroup:insert(buttonBack2);
            backText = display.newText ("Back To Main Menu", buttonBack2.x, buttonBack2.y, native.systemFontBold, 30)
            backText:setFillColor(100, 100, 100)
            sceneGroup:insert(backText)


            local options = {
               effect = "slideRight",
               time = 500
            }
            local function back (event)
               composer.gotoScene("scene1", options);
            end
            buttonBack2:addEventListener("tap", back);  
         end
      end

      function ropeRotation ()
         ropeGroup.rotation = ropeGroup.rotation + ropeGroup.speed
         rope.x = 300 * math.cos((ropeGroup.rotation - 90) * math.pi / 180) + display.contentCenterX
         rope.y = 300 * math.sin((ropeGroup.rotation - 90) * math.pi / 180) + (display.contentHeight - 440)
      end
      -------------------------------------------------------------------------------------------
      local function spawn()
         local pick = math.random(1, 3)
         if pick == 1 then
            bd = Bird:new()
            audio.play(crowSound)
            bd:spawn()
            bd:move()
         end

         if pick == 2 then
            ct = Cat:new()
            audio.play(catSound)
            ct:spawn()
            ct:move()
         end

         if pick == 3 then
            db = Dodgeball:new()
            audio.play(ballSound)
            db:spawn()
            db:move()
         end

         if spawnTime > 100 then
            spawnTime = spawnTime - 50
         end
      end

      function startGame ()
         -- PLAY GO SOUND
         updateTimer = timer.performWithDelay( 16.67, scoreUpdate, 0)
         ropeTimer = timer.performWithDelay( 16.67, ropeRotation, 0)
         spawner = timer.performWithDelay( spawnTime, spawn, 0)
         Runtime:addEventListener( "touch", jump )
         player:addEventListener( "collision", hitObstacle )
      end

      startGame()
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

      gameoverText.text = ""

      scoreFinalText.text = " "

      scoreFinalValue.text = " "

      backText.text = " "

      buttonBack2:removeSelf()

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