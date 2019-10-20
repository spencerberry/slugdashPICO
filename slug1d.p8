pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

function _init()
	slug = init_slug()
end

function _update60()
	if btn(4) then
		slug.x += slug.speed
	end
 slug.update()
end

function _draw()
	cls()
	slug.draw()
 print(tostr(slug.muscles[1].x).." "..tostr(slug.muscles[2].x))
end

function init_slug()
	local slug = {}
	slug.x = 1
 slug.y = 110
	slug.speed = .3

	slug.head = init_head(slug)
 -- slug.muscles = {init_muscle(slug.head)}
 -- add(slug.muscles, init_muscle(slug.muscles[1]))
 -- add(slug.muscles, init_muscle(slug.muscles[1]))
 slug.muscles = {}
 local last_muscle = init_muscle(slug.head)

 for i = 1, 6, 1 do
  local parent_muscle = last_muscle
  add(slug.muscles, last_muscle)
  last_muscle = init_muscle(parent_muscle)
 end

 slug.update = function()
  slug.head.update()
  for muscle in all(slug.muscles) do
   muscle.update()
  end
 end

	slug.draw = function()
		slug.head.draw()
		for muscle in all(slug.muscles) do
			muscle.draw()
		end
  pset(slug.x, slug.y, 1)

	end
	return slug
end

function init_head(parent)
	local head = {}

	head.width = 3
	head.height = 3
 head.x = parent.x
 head.y = parent.y

 head.update = function()
  head.x = parent.x
  head.y = parent.y
 end

	head.draw = function()
  spr(1, head.x, head.y)
	end

	return head

end
function init_muscle(parent)
	local muscle = {}

	muscle.parent = parent

	muscle.color = 11
 muscle.width = 4
 muscle.x = parent.x - muscle.width
 muscle.y = parent.y
 muscle.height = 5
 muscle.min_width = 1
	muscle.max_width = 8
 muscle.old_x = parent.x

 muscle.update = function()
  if parent.x > muscle.old_x then
   muscle.color = 4

   local new_width = parent.x - muscle.x
   if new_width <= muscle.max_width then
     muscle.width = new_width
   else
     muscle.width = muscle.max_width
     muscle.x = parent.x - muscle.width
   end

  else
   muscle.color = 3
   if muscle.width >= muscle.min_width then
    muscle.color = 2
    muscle.width -= .1
    muscle.x = parent.x - muscle.width
   end
  end
  muscle.height = 3 + 2/muscle.width
  muscle.old_x = parent.x
 end

 muscle.draw = function()
  rectfill(
   muscle.x,
   muscle.y + 8 - muscle.height,
   muscle.x + muscle.width,
   muscle.y + 7,
   muscle.color
  )
 end

	return muscle
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000a80a800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000aa0aa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000b00b0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bb0b0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbbbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bb3b5b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000b3bbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
