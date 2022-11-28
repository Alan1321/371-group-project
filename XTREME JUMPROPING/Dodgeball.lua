local Bird = require("Bird")

Dodgeball = Bird:new({tag="Obstacle"})

function Dodgeball:spawn()
 self.opt =
  {
    frames = {
      { x = 0, y = 0, width = 250, height = 250}
    }
  }
  self.sheet = graphics.newImageSheet( "dodgeball.png", self.opt);



  self.seqData = {
    {name = "fly", start=1,count =1, time=800, loopCount=0}
  }
  self.shape = display.newSprite (self.sheet, self.seqData);
  self.shape.anchorX = 0.5;
  self.shape.anchorY = 0.5;
  self.shape.side = math.random(1, 2)
  if self.shape.side == 1 then
    self.shape.x = 700
    self.shape.xTo = -100
  end
  if self.shape.side == 2 then
    self.shape.x = -100
    self.shape.xTo = 700
  end
  self.shape.y = math.random(400, 900)
  self.shape.xScale = 0.25;
  self.shape.yScale = 0.25;
  self.shape:setSequence("fly");
  self.shape.pp = self;  -- parent object
  self.shape.tag = self.tag; -- “Obstacle”
  physics.addBody(self.shape, "kinematic", {shape={-10, -10, 10, -10, 10, 10, -10, 10}}); 
end

function Dodgeball:animate()

end

function Dodgeball:forward ()
  transition.to(self.shape, {x=self.shape.xTo, y=self.shape.y,time=1000, 
  onComplete=function() 
    self.shape:removeSelf();
    self.shape=nil;
  end} );
end

function Dodgeball:move () 
  self:forward()
end

return Dodgeball
