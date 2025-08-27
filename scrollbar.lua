-- class's lib's
Scrollbar = { };
Scrollbar.__mode, Scrollbar.__index = 'k', Scrollbar;

-- instance's lib's
local instance = { };
instance.current = false;

instance.hover, instance.state = false, false;
instance.total = 0;

-- util's lib's
local screenW, screenH = guiGetScreenSize ();

local function isCursorOnElement (x, y, w, h)
	if (not isCursorShowing ()) then
		return false;
	end

	local cursorX, cursorY = getCursorPosition ();
	cursorX, cursorY = (cursorX * screenW), (cursorY * screenH);

	return (
		cursorX >= x and cursorX <= (x + w) and
		cursorY >= y and cursorY <= (y + h)
	);
end


-- method's lib's
function Scrollbar.new (w, h, min, max, start)
	local self = setmetatable ({ }, Scrollbar);
	self.state = false;

	self.w, self.h = (w or 10), (h or 100);

	self.events = {
		['onValueChanged'] = { },
	};

	instance.total = (instance.total + 1);
	if (instance.total > 0) and (not instance.state) then
		addEventHandler ('onClientClick', root, onClick);

		instance.state = true;
	end

	return self;
end

function Scrollbar:draw (x, y)
	local w, h = self.w, self.h;
	instance.hover = false;

	local inScroll = isCursorOnElement (x, y, w, h);
	if (inScroll) then
		instance.hover = self;
	end

	dxDrawRectangle (x, y, w, h, tocolor (255, 255, 255, 255), false);
	dxDrawRectangle (x, y, w, 30, tocolor (255, 0, 0, 255), false);

	return true;
end

function Scrollbar:toggle (state)
	local current = self.state;
	if (current == state) then
		return false;
	end

	self.state = state;
	return true;
end

function Scrollbar:destroy ()
	instance.total = math.max (0, (instance.total - 1));
	if (instance.total < 1) and (instance.state) then
		removeEventHandler ('onClientClick', root, onClick);

		instance.state = false;
	end

	collectgarbage ();
	return true;
end

-- event's lib's
function onClick (button, state)
	local total = instance.total;
	if (total < 1) then
		return false;
	end

	if (button ~= 'left') then
		return false;
	end

	if (state == 'up') then
		local current = instance.current;
		if (not current) then
			return false;
		end
		instance.current = false;

		current:toggle (false);
		return true;
	end

	if (state == 'down') then
		local self = instance.hover;
		if (not self) then
			return false;
		end

		local current = instance.current;
		if (current) then
			return false;
		end
		instance.current = self;

		self:toggle (true);
		return true;
	end

	return false;
end