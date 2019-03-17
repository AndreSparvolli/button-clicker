function love.load()
  button = {};
  button.x = 0;
  button.y = 0;
  button.size = 50;

  randomizeButtonPosition();

  score = 0;
  timer = 10;
  gameState = 1;

  myFont = love.graphics.newFont( 40 );
end

function love.update(dt)
  if gameState == 2 then
    if timer > 0 then
      timer = timer - dt;
    end

    if timer < 0 then
      timer = 0;
      gameState = 1;
      score = 0;
    end
  end
end

function love.draw()
  if gameState == 2 then
    love.graphics.setColor( 1, 0, 0 );
    love.graphics.circle( "fill", button.x, button.y, button.size );
  end

  love.graphics.setFont( myFont );
  love.graphics.setColor( 1, 1, 1 );
  love.graphics.print( "Score: " .. score );

  love.graphics.print( "Time: " .. math.ceil( timer ), 300, 0 );

  if gameState == 1 then
    love.graphics.printf( "Click anywhere to begin!", 0, (love.graphics.getHeight() / 2), love.graphics.getWidth(), "center" );
  end
end

function love.mousepressed( x, y, mouseButton, isTouch )
  if mouseButton == 1 and gameState == 2 then
    if getDistance(  button.x, button.y, love.mouse.getX(), love.mouse.getY() ) < button.size then
      score = score + 1;
      randomizeButtonPosition()
    end
  end

  if gameState == 1 then
    gameState = 2;
    timer = 10;
  end
end

function getDistance( x1, y1, x2, y2 )
  return math.sqrt( ( y2 - y1 )^2 + ( x2 - x1 )^2 );
end

function randomizeButtonPosition()
  button.x = math.random( button.size, love.graphics.getWidth() - button.size );
  button.y = math.random( button.size, love.graphics.getHeight() - button.size );
end
