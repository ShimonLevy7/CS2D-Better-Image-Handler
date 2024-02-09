-------------------------------------------------------------------------------
-- Internal Init
-------------------------------------------------------------------------------

if not sp then sp = { } end
if not sp.imgtbl then sp.imgtbl = { } end
if not sp.image then sp.image = { } end
if not sp.hooks then sp.hooks = { } end

addhook('startround_prespawn', 'sp.hooks.startround_prespawn')


-------------------------------------------------------------------------------
-- Public Config
-------------------------------------------------------------------------------

--Debug functions?
sp.debug_functions = false

--Debug errors?
sp.debug_errors = true


-------------------------------------------------------------------------------
-- Internal Functions
-------------------------------------------------------------------------------

function sp.print(text, title)
	if type(text) == 'table' then
		if sp.debug_functions then
			local str = ''
			
			for k, v in pairs(text) do
				str = str .. ' - [' .. tostring(k) .. ']: ' .. tostring(v)
			end
			
			text = str:sub(4)
		else
			return
		end
	end
	
	text = tostring(text)
	
	if not title then
		print(text)
	elseif title ~= 'Error' or (title == 'Error' and sp.debug_errors) then
		print('[' .. tostring(title) .. ']: ' .. text)
	end
end

function sp.valid_number(id)
	if not id or not tonumber(id) then
		return false
	end
	
	return true
end


-------------------------------------------------------------------------------
-- Public Functions
-------------------------------------------------------------------------------

function sp.image.exists(id)
	return (sp.imgtbl[id] and true) or false
end

function sp.image.get(id, value)
	return (sp.imgtbl[id] and sp.imgtbl[id][tostring(value)]) or false
end

function sp.image.set(id, mode, variable, values)
	if not sp.valid_number(id) then
		sp.print('Attempt to set image with invalid ID!', 'Error')
	elseif not sp.image.exists(id) then
		sp.print('Attempt to set image with non existent image ID!', 'Error')
	elseif type(values) ~= 'table' then
		sp.print('Attempt to set image with invalid values!', 'Error')
	else
		if mode == 'normal'	then
			if variable == 'alpha' then
				if sp.valid_number(values[1]) then
					sp.imgtbl[id].alpha = values[1]
					imagealpha(id, values[1])
					sp.print({ id = id, alpha = values[1] }, 'Set Normal Image Alpha')
					return true
				end
				
				sp.print('Attempt to set normal alpha with invalid opacity!', 'Error')
			elseif variable == 'blend' then
				if sp.valid_number(values[1]) then
					sp.imgtbl[id].blend = values[1]
					imageblend(id, values[1])
					sp.print({ id = id, blend = values[1] }, 'Set Normal Image Blend')
					return true
				end
				
				sp.print('Attempt to set normal blend with invalid mode!', 'Error')
			elseif variable == 'color' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) and sp.valid_number(values[3]) then
					sp.imgtbl[id].r = values[1]
					sp.imgtbl[id].g = values[2]
					sp.imgtbl[id].b = values[3]
					imagecolor(id, values[1], values[2], values[3])
					sp.print({ id = id, r = values[1], g = values[2], b = values[3] }, 'Set Normal Image Color')
					return true
				end
				
				sp.print('Attempt to set normal color with invalid values!', 'Error')
			elseif variable == 'frame' then
				if sp.valid_number(values[1]) then
					sp.imgtbl[id].frame = values[1]
					imageframe(id, values[1])
					sp.print({ id = id, frame = values[1] }, 'Set Normal Image Frame')
					return true
				end
				
				sp.print('Attempt to set normal frame with invalid frame!', 'Error')
			elseif variable == 'hitzone' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) and sp.valid_number(values[3]) and sp.valid_number(values[4]) and sp.valid_number(values[5]) then
					imagehitzone(id, values[1], values[2], values[3], values[4], values[5])
					sp.imgtbl[id].hitzone.mode = values[1]
					sp.imgtbl[id].hitzone.x_offset = values[2]
					sp.imgtbl[id].hitzone.y_offset = values[3]
					sp.imgtbl[id].hitzone.width = values[4]
					sp.imgtbl[id].hitzone.height = values[5]
					sp.print({ id = id, mode = values[1], x_offset = values[2], y_offset = values[3], width = values[4], height = values[5] }, 'Set Normal Image Hitzone')
					return true
				end
				
				sp.print('Attempt to set normal hitzone with invalid values!', 'Error')
			elseif variable == 'pos' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) and sp.valid_number(values[3]) then
					imagepos(id, values[1], values[2], values[3])
					sp.imgtbl[id].x = values[1]
					sp.imgtbl[id].y = values[2]
					sp.imgtbl[id].rot = values[3]
					sp.print({ id = id, x = values[1], y = values[2], rot = values[3] }, 'Set Normal Image Pos')
					return true
				end
				
				sp.print('Attempt to set normal hitzone with invalid values!', 'Error')
			elseif variable == 'scale' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) then
					imagescale(id, values[1], values[2])
					sp.imgtbl[id].scale_x = values[1]
					sp.imgtbl[id].scale_y = values[2]
					sp.print({ id = id, x = values[1], y = values[2] }, 'Set Normal Image Scale')
					return true
				end
				
				sp.print('Attempt to set normal scale with invalid values!', 'Error')
			else
				sp.print('Attempt to set normal image with invalid variable!', 'Error')
			end
		elseif mode == 'tween' then
			if variable == 'alpha' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) then
					sp.imgtbl[id].alpha = values[2]
					tween_alpha(id, values[1], values[2])
					sp.print({ id = id, time = values[1], alpha = values[2] }, 'Set Tween Image Alpha')
					return true
				end
				
				sp.print('Attempt to set tween alpha with invalid values!', 'Error')
			elseif variable == 'color' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) and sp.valid_number(values[3]) and sp.valid_number(values[4]) then
					tween_color(id, values[1], values[2], values[3], values[4])
					sp.imgtbl[id].r = values[2]
					sp.imgtbl[id].g = values[3]
					sp.imgtbl[id].b = values[4]
					sp.print({ id = id, time = values[1], r = values[2], g = values[3], b = values[4] }, 'Set Tween Image Color')
					return true
				end
				
				sp.print('Attempt to set tween color with invalid values!', 'Error')
			elseif variable == 'frame' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) then
					tween_frame(id, values[1], values[2])
					sp.imgtbl[id].frame = values[2]
					sp.print({ id = id, time = values[1], frame = values[2] }, 'Set Tween Image Frame')
					return true
				end
				
				sp.print('Attempt to set tween frame with invalid values!', 'Error')
			elseif variable == 'move' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) and sp.valid_number(values[3]) then
					if sp.valid_number(values[4]) then
						tween_move(id, values[1], values[2], values[3], values[4])
						sp.print({ id = id, time = values[1], x = values[2], y = values[3], pos = values[4] }, 'Set Tween Image Move')
						sp.imgtbl[id].rot = values[4]
					else
						tween_move(id, values[1], values[2], values[3])
						sp.print({ id = id, time = values[1], x = values[2], y = values[3]}, 'Set Tween Image Move')
					end
					
					sp.imgtbl[id].x = values[2]
					sp.imgtbl[id].y = values[3]
					
					return true
				end
				
				sp.print('Attempt to set tween move with invalid values!', 'Error')
			elseif variable == 'rotate' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) then
					tween_rotate(id, values[1], values[2])
					sp.print({ id = id, time = values[1], rot = values[2] }, 'Set Tween Image Rotate')
					sp.imgtbl[id].rot = values[2]
					return true
				end
				
				sp.print('Attempt to set tween rotate with invalid values!', 'Error')
			elseif variable == 'rotateconstantly' then
				if sp.valid_number(values[1]) then
					tween_rotateconstantly(id, values[1])
					sp.imgtbl[id].rot = 'constant'
					sp.print({ id = id, speed = values[1] }, 'Set Tween Image Rotateconstantly')
					return true
				end
				
				sp.print('Attempt to set tween rotateconstantly with invalid values!', 'Error')
			elseif variable == 'scale' then
				if sp.valid_number(values[1]) and sp.valid_number(values[2]) and sp.valid_number(values[3]) then
					tween_scale(id, values[1], values[2], values[3])
					sp.print({ id = id, time = values[1], x = values[2], y = values[3] }, 'Set Tween Image Scale')
					sp.imgtbl[id].scale_x = values[2]
					sp.imgtbl[id].scale_y = values[3]
					return true
				end
				
				sp.print('Attempt to set tween scale with invalid values!', 'Error')
			else
				sp.print('Attempt to set tween image with invalid variable!', 'Error')
			end
		else
			sp.print('Attempt to set image with invalid mode!', 'Error')
		end
	end
	return false
end

function sp.image.add(dir, x, y, mode, pl)
	local id
	
	if not dir then
		sp.print('Can\'t add an image without a valid directory!', 'Error')
	elseif not sp.valid_number(x) then
		sp.print('Can\'t add an image without a valid X position!', 'Error')
	elseif not sp.valid_number(y) then
		sp.print('Can\'t add an image without a valid Y position!', 'Error')
	elseif not tonumber(mode) then
		sp.print('Can\'t add an image without a valid mode!', 'Error')
	elseif pl ~= nil then
		if not sp.valid_number(pl) or not player(pl, 'exists') then
			sp.print('Invalid player stated!', 'Error')
		else
			id = image(dir, x, y, mode, pl)
			
			if sp.imgtbl[id] then
				sp.print('Attempt to create multiple images under the same ID!', 'Error')
			end
			
			sp.print({ id = id, dir = dir, x = x, y = y, mode = mode, pl = pl }, 'Add Image')
		end
	else
		id = image(dir, x, y, mode)
		
		if sp.imgtbl[id] then
			sp.print('Attempt to create multiple images under the same ID!', 'Error')
		end
		
		sp.print({ id = id, dir = dir, x = x, y = y, mode = mode }, 'Add Image')
	end
	
	sp.imgtbl[id] = { dir = dir, x = x, y = y, mode = mode, pl = (pl or 0), rot = 0, scale_x = 1, scale_y = 1, frame = 1, r = 255, g = 255, b = 255, alpha = 1, blend = 0, hitzone = { mode = false, x_offset = 0, y_offset = 0, width = 0, height = 0 } }
	
	return (sp.valid_number(id) and id) or false
end

function sp.image.free(id)
	if type(id) == 'table' then
		local caught = false
		
		for k, v in pairs(id) do
			if sp.imgtbl[v] then
				freeimage(v)
				sp.imgtbl[v] = nil
				sp.print({ id = v }, 'Remove Image')
				caught = true
			else
				sp.print('Attempt to free a non existent image! (' .. tostring(v) .. ')', 'Error')
			end
		end
		
		if not caught then
			sp.print('No images freed! (' .. tostring(id) .. ')', 'Error')
			return false
		end
		
		return true
	else
		id = tonumber(id)
	
		if sp.imgtbl[id] then
			freeimage(id)
			sp.imgtbl[id] = nil
			sp.print({ id = id }, 'Remove Image')
			return true
		end
		
		sp.print('Attempt to free a non existent image! (' .. tostring(id) .. ')', 'Error')
		return false
	end
end

function sp.image.free_all()
	for k, v in pairs(sp.imgtbl) do
		sp.image.free(k)
		sp.print({ id = k }, 'Remove All Images')
	end
	
	sp.imgtbl = { }
end


-------------------------------------------------------------------------------
-- Hooks
-------------------------------------------------------------------------------

function sp.hooks.startround_prespawn()
	sp.imgtbl = { }
end