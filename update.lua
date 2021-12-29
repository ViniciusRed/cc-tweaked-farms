function delete()
 local args = {"rm farm")
    
 return shell.run(unpack(args))
end

function update()
    return shell.run("pastebin get 74Qazz3x farm")
end

delete()
update()