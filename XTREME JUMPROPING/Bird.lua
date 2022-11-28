local Bird = {tag="Obstacle"}

function Bird:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Bird:spawn()
 self.opt =
  {
    frames = {
      { x = 0, y = 168, width = 160, height = 152}, --X = 0 Y = 168 Width = 160 Height = 152
      { x = 160, y = 168, width = 160, height = 152}, --X = 160 Y = 168 Width = 160 Height = 152
      { x = 320, y = 168, width = 160, height = 152}, --X = 320
      { x = 480, y = 168, width = 160, height = 152}, --X = 480
      { x = 640, y = 168, width = 160, height = 152}, --X = 640
      { x = 800, y = 168, width = 160, height = 152}, --X = 800
    }
  }
  self.sheet = graphics.newImageSheet( "birdsprite.png", self.opt);



  self.seqData = {
    {name = "fly", start=1,count = 5, time=500, loopCount=0}
  }
  self.shape = display.newSprite (self.sheet, self.seqData);
  self.shape.anchorX = 0.5;
  self.shape.anchorY = 0.5;
  self.shape.x = 700
  self.shape.y = math.random(100, 400)
  self.shape.xScale = 1;
  self.shape.yScale = 1;
  self.shape:setSequence("fly");
  self.shape.pp = self;  -- parent object
  self.shape.tag = self.tag; -- “Obstacle”
  physics.addBody(self.shape, "kinematic"); 
end

function Bird:animate()
  self.shape:play()
end

function Bird:forward ()   
  transition.to(self.shape, {x=-100, y=self.shape.y,time=2000, 
  onComplete=function() 
    self.shape:removeSelf();
    self.shape=nil;
  end} );
end

function Bird:move ()	
	self:forward()
  self:animate()
end

return Bird
