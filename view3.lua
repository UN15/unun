-----------------------------------------------------------------------------------------
--
-- view3.lua
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

	local life = 3
	local showLife = display.newText("x"..life, display.contentWidth*0.95, display.contentHeight*0.1)
	showLife:setFillColor(0)
	showLife.size = 50

	local floor1 = display.newRect(display.contentWidth/2, display.contentHeight*0.95, display.contentWidth, display.contentHeight*0.2)
	floor1:setFillColor(0)
	floor1.name = 'floor1'
	physics.addBody(floor1, 'static')

	--첫째 줄 
	local floor2 = display.newRect(display.contentWidth*0.08, display.contentHeight*0.65, 500, 5)
	floor2:setFillColor(0.5)
	floor2.name = 'floor2'
	physics.addBody(floor2, 'static')

	local floor3 = display.newRect(display.contentWidth*0.75, display.contentHeight*0.65, 800, 5)
	floor3:setFillColor(0.5)
	floor3.name = 'floor3'
	physics.addBody(floor3, 'static')

	--둘째 줄 
	local floor4 = display.newRect(display.contentWidth*0.08, display.contentHeight*0.45, 300, 5)
	floor4:setFillColor(0.5)
	floor4.name = 'floor4'
	physics.addBody(floor4, 'static')

	local floor5 = display.newRect(display.contentWidth*0.4, display.contentHeight*0.45, 300, 5)
	floor5:setFillColor(0.5)
	floor5.name = 'floor5'
	physics.addBody(floor5, 'static')

	local floor6 = display.newRect(display.contentWidth*0.8, display.contentHeight*0.45, 500, 5)
	floor6:setFillColor(0.5)
	floor6.name = 'floor3'
	physics.addBody(floor6, 'static')

	--셋째 줄 
	local floor7 = display.newRect(display.contentWidth*0.9, display.contentHeight*0.25, 300, 5)
	floor7:setFillColor(0.5)
	floor7.name = 'floor7'
	physics.addBody(floor7, 'static')

	local floor8 = display.newRect(display.contentWidth*0.1, display.contentHeight*0.25, 600, 5)
	floor8:setFillColor(0.5)
	floor8.name = 'floor8'
	physics.addBody(floor8, 'static')

	local floor9 = display.newRect(display.contentWidth*0.55, display.contentHeight*0.25, 300, 5)
	floor9:setFillColor(0.5)
	floor9.name = 'floor9'
	physics.addBody(floor9, 'static')

	local apple = { }
	local appleGroup = display.newGroup()

	for i = 1, 5 do
		apple[i] = display.newImageRect(appleGroup, "image/apple.png", 40 , 40)
		physics.addBody(apple[i])
		apple[i].name='apple'
	end
	apple[1].x, apple[1].y= display.contentWidth*0.3, display.contentHeight*0.85	
	apple[2].x, apple[2].y= display.contentWidth*0.1, display.contentHeight*0.63
	apple[3].x, apple[3].y= display.contentWidth*0.7, display.contentHeight*0.63
	apple[4].x, apple[4].y= display.contentWidth*0.5, display.contentHeight*0.43
	apple[5].x, apple[5].y= display.contentWidth*0.8, display.contentHeight*0.23
	
	local banana = { }
	local bananaGroup = display.newGroup()

	for i = 1, 5 do
		banana[i] = display.newImageRect(bananaGroup, "image/banana.png", 40 , 40)
		physics.addBody(banana[i])
		banana[i].name='banana'
	end
	banana[1].x, banana[1].y= display.contentWidth*0.23, display.contentHeight*0.85	
	banana[2].x, banana[2].y= display.contentWidth*0.75, display.contentHeight*0.63
	banana[3].x, banana[3].y= display.contentWidth*0.4, display.contentHeight*0.43
	banana[4].x, banana[4].y= display.contentWidth*0.05, display.contentHeight*0.43
	banana[5].x, banana[5].y= display.contentWidth*0.6, display.contentHeight*0.23

	local gimlet = { }
	local gimletGroup = display.newGroup()

	for i = 1, 5 do
		gimlet[i] = display.newImageRect(gimletGroup, "image/gimlet.png", 40 , 40)
		physics.addBody(gimlet[i], "static")
		gimlet[i].name='gimlet'
	end
	gimlet[1].x, gimlet[1].y= display.contentWidth*0.75, display.contentHeight*0.84
	gimlet[2].x, gimlet[2].y= display.contentWidth*0.15, display.contentHeight*0.63
	gimlet[3].x, gimlet[3].y= display.contentWidth*0.8, display.contentHeight*0.43
	gimlet[4].x, gimlet[4].y= display.contentWidth*0.15, display.contentHeight*0.43
	gimlet[5].x, gimlet[5].y= display.contentWidth*0.48, display.contentHeight*0.23

	local snake = display.newImageRect("image/snake.png", 100, 80)
	snake.x, snake.y = display.contentWidth/2, display.contentHeight*0.6
	snake.name = 'snake'

	local ladder= display.newImageRect("image/ladder.png", 150, 147)
	ladder.x, ladder.y = display.contentWidth*0.6, display.contentHeight*0.76
	ladder.name='ladder'

	
	local function completeListener ( obj )
    	snake.xScale= snake.xScale*-1
    end

 
	transition.to(snake, {time =1000, x = 640 - 50, onComplete = completeListener})	
	transition.to(snake, {time = 2000, delay=1000, x = 640+50, onComplete = completeListener})


	local circle = display.newCircle(display.contentWidth*0.9, display.contentHeight*0.9, 25)
	circle:setFillColor(0.5, 0.8, 1)
	physics.addBody(circle)
	circle.name = 'circle'

	local function moveFirst()
		circle.x=display.contentWidth*0.9
		circle.y=display.contentHeight*0.9
	end

	local function onKeyEvent( event )
		if event.phase =="down" then
			if event.keyName =="right" then
				circle:setLinearVelocity(150, 0)
			elseif event.keyName == "left" then
				circle:setLinearVelocity(-150, 0)
			elseif event.keyName == "up" then
				circle:setLinearVelocity(0, -200)
			end
		end
	end


	local function onCollision(e)
		if e.other.name == 'apple' or e.other.name =='banana' then
			score = score + 1
			display.remove(e.other)
			showScore.text = score
			if score == 10 then
				composer.gotoScene("view2")
			end
		end
	end

	local function onCollision2(e)
		if e.other.name == 'gimlet' and e.phase =="ended" then
			life = life - 1
			timer.performWithDelay(200, function() moveFirst() end)
			showLife.text="x"..life
			if life == 0 then
				composer.gotoScene("view2")
			end
		end
	end


	Runtime:addEventListener( "key", onKeyEvent )
	circle:addEventListener("collision", onCollision)
	circle:addEventListener("collision", onCollision2)

	sceneGroup:insert(background)
	sceneGroup:insert(ladder)
	sceneGroup:insert(floor1)
	sceneGroup:insert(showScore)
	sceneGroup:insert(showLife)
	sceneGroup:insert(circle)
	sceneGroup:insert(snake)
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