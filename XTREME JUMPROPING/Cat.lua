local Bird = require("Bird")

Cat = Bird:new({tag="Obstacle"})

function Cat:spawn()
 self.opt =
  {
    frames = {
      { x = 387, y = 5, width = 26, height = 23}, --X = 387 Y = 5 Width = 26 Height = 23
      { x = 418, y = 5, width = 26, height = 23}, --X = 418 Y = 5 Width = 26 Height = 23
      { x = 451, y = 5, width = 26, height = 23} --X = 451 Y = 5 Width = 26 Height = 23
    }
  }
  self.sheet = graphics.newImageSheet( "cat.png", self.opt);



  self.seqData = {
    {name = "walk", start=1,count = 3, time=300, loopCount=0}
  }
  self.shape = display.newSprite (self.sheet, self.seqData);
  self.shape.anchorX = 0.5;
  self.shape.anchorY = 0.5;
  self.shape.x = -100
  self.shape.y = display.contentHeight - 200
  self.shape.xScale = 6;
  self.shape.yScale = 6;
  self.shape:setSequence("walk");
  self.shape.pp = self;  -- parent object
  self.shape.tag = self.tag; -- “Obstacle”
  physics.addBody(self.shape, "kinematic"); 
end

function Cat:forward ()   
  transition.to(self.shape, {x=800, y=self.shape.y,time=2000, 
  onComplete=function() 
    self.shape:removeSelf();
    self.shape=nil;
  end} );
end

return Cat
