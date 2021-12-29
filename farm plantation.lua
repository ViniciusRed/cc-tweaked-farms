os.loadAPI('harev6')

-- handle command line arguments
local cliArgs = {...}
local length = tonumber(cliArgs[1])
local width = tonumber(cliArgs[2])

-- display "usage" info
if length == nil or width == nil or cliArgs[1] == '?' then
  print('Usage: farmwheat <length> <width>')
  return
end

print('Hold Ctrl-T to stop.')

-- check that chest is there
if not harev6.findBlock('minecraft:chest') then
  error('Must start next to a chest.')
end

-- face field
 turtle.turnLeft()
 turtle.turnLeft()
  
-- checkWheatCrop() harvests mature wheat
-- and plants seeds
function checkWheatCrop()
  local result, block = turtle.inspectDown()

  local state = block['state'];
  
  print(block['name'])

  if not result then
    turtle.digDown() -- till the soil
    plantWheatSeed()
  elseif block ~= nil and block['name'] == block['name'] and state.age == 7 then
    -- collect wheat and replant
    turtle.digDown()
    print('Collected wheat.')
    plantWheatSeed()
  end
end


-- plantWheatSeed() attempts to plant
-- a wheat seed below the turtle
function plantWheatSeed()
  if not harev6.selectItem('minecraft:carrot') then
    print('Warning: Low on seeds.')
  else
    harev6.selectAndPlaceDown() -- plant a seed
    print('Planted seed.')
  end
end


-- storeWheat() puts all wheat into an
-- adjacent chest
function storeWheat()
  -- face the chest
  if not harev6.findBlock('minecraft:chest') then
    error('Could not find chest.')
  end

  -- store wheat in chest
  while harev6.selectItem('minecraft:carrot') do
    print('Dropping off ' .. turtle.getItemCount() .. ' wheat...')
    if not turtle.drop() then
      error('Wheat chest is full!')
    end
  end

  -- face field again
  turtle.turnLeft()
  turtle.turnLeft()
end

-- begin farming
while true do
        -- check fuel
  local needCoalAmount = (length * width + length + width)
  local coalRemain = needCoalAmount - turtle.getFuelLevel();
  if turtle.getFuelLevel() < coalRemain then
    error('Turtle needs more fuel! ('..coalRemain..')')
  end

  -- farm wheat
  print('Sweeping field...')
  harev6.sweepField(length, width, checkWheatCrop)
  storeWheat()

  print('Sleeping for 10 minutes...')
  os.sleep(30)
end
return