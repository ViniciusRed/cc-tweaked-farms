os.loadAPI('FarmsApi')

local cliArgs = {...}
local length = tonumber(cliArgs[1])
local width = tonumber(cliArgs[2])

 -- display "usage" info
if length == nil or width == nil or cliArgs[1] == '?' then
   print('Usage: farm <length> <width>')
  return
end

print('Hold Ctrl-T to stop.')

if not FarmsApi.findBlock('minecraft:chest') then
  error('Must start next to a chest.')
end
 
-- face field
 turtle.turnLeft()
 turtle.turnLeft()

function checkCrop()
  local result, block = turtle.inspectDown()
 
  local state = block['state'];

  if not result then
    turtle.digDown() -- till the soil
    plantWheatSeed()
  elseif block ~= nil and block['name'] == block['name'] and state.age == 7 then
    -- collect wheat and replant
    turtle.digDown()
    print('Collected.')
    plantWheatSeed()
  end
end

function plantWheatSeed()
  if not FarmsApi.selectItem('minecraft:carrot') then
    print('Warning: Low on seeds.')
  else
    FarmsApi.selectAndPlaceDown() -- plant a seed
    print('Planted seed.')
  end
end

function store()
  -- face the chest
  if not FarmsApi.findBlock('minecraft:chest') then
    error('Could not find chest.')
  end
 
  -- store wheat in chest
  while FarmsApi.selectItem('minecraft:carrot') do
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
  FarmsApi.sweepField(length, width, checkCrop)
  store()
 
  print('Sleeping for 10 minutes...')
  os.sleep(60)
end
return