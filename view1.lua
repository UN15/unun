-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background:setFillColor(1)

	local score = 0
	local showScore = display.newText(score, display.contentWidth*0.9, display.contentHeight*0.1)
	showScore:setFillColor(0)
	showScore.size = 50

	local floor = display.newRect(display.contentWidth/2, display.contentHeight*0.9, display.contentWidth, display.contentHeight*0.2)
	floor:setFillColor(0)
	floor.name = 'floor'
	physics.addBody(floor, 'static')

	local cat = display.newImageRect("image/cat.png", 150, 200)
	cat.x, cat.y = display.contentWidth*0.4, display.contentHeight*0.8
	physics.addBody(cat, 'static')
	cat.name = 'cat'
	
	local objects = {"circle", "circle2", "circle3", "circle4", "circle5"}

	local function spawn()
		local objIdx = math.random(#objects)
		local objName = objects[objIdx]
		local object= display.newImage("image/" .. objName .. ".png")
		object.x = display.contentWidth*0.5 + math.random(-500, 500)
		object.y = 0
		physics.addBody(object)
		object.name='object'
	end
	
	local function onKeyEvent( event )
		if event.keyName =="right" then
			cat.x = cat.x + 15
		elseif event.keyName == "left" then
			cat.x = cat.x - 15
		end
	end

	local function onCollision(e)
		if e.other.name == 'object' then
			score = score + 1
			display.remove(e.other)
			showScore.text = score
			if score == 10 then
				composer.gotoScene("view2")
			end
		end
	end

	local function onCollision2(e)
		if e.other.name == 'object' then
			display.remove(e.other)
		end
	end

	Runtime:addEventListener( "key", onKeyEvent )
	cat:addEventListener("collision", onCollision)
	floor:addEventListener("collision", onCollision2)
	timer.performWithDelay(2000, spawn, 0)

	sceneGroup:insert(background)
	sceneGroup:insert(showScore)
	if object then
		sceneGroup:insert(object)
	end
	sceneGroup:insert(floor)
	sceneGroup:insert(cat)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene