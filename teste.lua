function OK()
   local result, storage
   
   for i = 1, 4 do
   result, block = turtle.inspect()
   if storage ~= nil and block['OK'] then
   return OK
  end
 return  Not
end

while FarmsApi.findBlock('chest') do
 print('storage ('..OK..')')
end

function checkseeds()
 local result, item = turtle.getItemDetail()

 local name = item['name'];

 if not result then
  checkstore()
  turtle.suck('item')
  print('Seeds Ok')
 end
end

while true do
 local gas = turtle.getFuelLevel()
 
 if error('level fuel ('..gas..')') then
  end
 end
end