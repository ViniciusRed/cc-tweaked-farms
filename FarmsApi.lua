function findBlock(name)
  local result, block
 
  for i = 1, 4 do
    result, block = turtle.inspect()
    if block ~= nil and block['name'] == name then
      return true
    end
    turtle.turnRight()
  end
  return false
end

function selectItem(name)
  -- check all inventory slots
  local item
  for slot = 1, 16 do
    item = turtle.getItemDetail(slot)
    if item ~= nil and item['name'] == name then
      turtle.select(slot)
      return true
    end
  end
 
  return false  -- couldn't find item
end

function selectAndPlaceDown()
 
  for slot = 1, 16 do
    if turtle.getItemCount(slot) > 0 then
      turtle.select(slot)
      turtle.placeDown()
      return
    end
  end
end

function sweepField(length, width, sweepFunc)
  local turnRightNext = true
 
  for x = 1, width do
    for y = 1, length do
      sweepFunc()
 
      if y ~= length then
        turtle.forward()
      end
    end
 
    if x ~= width then
      -- turn to the next column
      if turnRightNext then
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
      else
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
      end
 
      turnRightNext = not turnRightNext
    end
  end
 
  if width % 2 == 0 then
    turtle.turnRight()
  else
    for y = 1, length - 1 do
      turtle.back()
    end
    turtle.turnLeft()
  end
 
  for x = 1, width - 1 do
    turtle.forward()
  end
  turtle.turnRight()
 
  return true
end