# CS2D-Better-Image-Handler
Improves on the existing CS2D's image handler by wrapping it with safer to use functions.

This file consists of a couple functions made to replace the default image functions provided by CS2D.
Unless you have basic knowledge of Lua, this wont work for you!
I've included a couple example pictures [here](https://imgur.com/a/smL9QeW), but you should read the documentation below!

This file tracks the following stats of an image: `(Name = Value)`
```lua
sp.imgtbl[id] = { dir = dir, x = x, y = y, mode = mode, pl = (pl or 0), rot = 0, scale_x = 1, scale_y = 1, frame = 1, r = 255, g = 255, b = 255, alpha = 1, blend = 0, hitzone = { mode = false, x_offset = 0, y_offset = 0, width = 0, height = 0 } }
```

# List of Public Configuration Options
* Debug Functions?
Will show pretty much everything that the functions are doing!
You should leave this disabled unless you're looking for mistakes in your code!

* Debug Errors?
Shows user errors!
You should leave this enabled!

# List of Public Functions
`sp.image.exists`
     Description:
          Check if an ImageID is valid (exists).
          
     Parameters:
          ID: The image's ID.
          
     Returns:
          Image exists:
               true
          Image doesn't exist:
               false
          
          
`sp.image.get`
     Description:
          Get an image's property.
          
     Parameters:
          ID: The image's ID.
          Value: The requested value (dir, x, y, mode, pl, ETC.)
               Note that rot will return 'constant' when rotateconstantly is enabled.
               Note that hitzone.mode will return false when hitzone is not used.
          
     Returns:
          Value exists:
               [value].
          Value doesn't exist:
               false.
          
          
`sp.image.set`
     Description:
          Set an image's property normally or using tween.
          
     Parameters:
          ID: The image's ID.
          Mode: 'normal' or 'tween'.
          Variable: What do you want to change? ('alpha', 'scale', ...)
          Values: A table of values containing (by order) the values needed to change.
          
     Returns:
          Values applied:
               true.
          Values failed to apply:
               false.
               

`sp.image.add`
     Description:
          Adds an image.
          
     Parameters:
          Dir: The image's directory.
          X: The image's X position.
          Y: The image's Y position.
          Mode: The image's mode.
          [Pl]: Player(s) to see the image.
          
     Returns:
          Image created:
               ImageID
          Image wasn't created:
               false.


`sp.image.free`
     Description:
          Frees all images given.
          
     Parameters:
          ID: The image's ID or a table of ImageIDs.
          
     Returns:
          Table:
               Any image was freed:
                    true.
               No images were freed:
                    false.
          Not table:
               Image exists and freed:
                    true.
               Image doesn't exist:
                    false.
               
`sp.image.free_all`
     Description:
          Frees all images created by the image handler.
          
     Parameters:
     
     Returns:
     


**You must add the `mt.NoReload.lua` script to the `autorun` folder or the `server.lua` file, otherwise it will not execute.**
