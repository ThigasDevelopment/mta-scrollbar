-- class's lib's
Scrollbar = { };
Scrollbar.__mode, Scrollbar.__index = 'k', Scrollbar;

-- instance's lib's
local instance = { };
instance.items, instance.total = { }, 0;

instance.current, instance.state = false, false;

-- util's lib's
local screenW, screenH = guiGetScreenSize ();

local _getCursorPosition = getCursorPosition;
function getCursorPosition ()
	if (not isCursorShowing ()) then
		return 0, 0;
	end

	local cursorX, cursorY = _getCursorPosition ();
	cursorX, cursorY = (cursorX * screenW), (cursorY * screenH);

	return cursorX, cursorY;
end

local function isCursorOnElement (x, y, w, h)
	if (not isCursorShowing ()) then
		return false;
	end

	local cursorX, cursorY = getCursorPosition ();
	return (
		cursorX >= x and cursorX <= (x + w) and
		cursorY >= y and cursorY <= (y + h)
	);
end


-- method's lib's
function Scrollbar.new (w, h, size, min, max, start)
	local self = setmetatable ({ }, Scrollbar);
	self.state = false;

	self.w, self.h = (w or 10), (h or 100);
	self.size, self.offset = (size or 30), 0;

	self.min, self.max = (min or 0), (max or 100);

	instance.total = (instance.total + 1);
	if (instance.total > 0) and (not instance.state) then
		addEventHandler ('onClientClick', root, onClick);

		instance.state = true;
	end

	instance.items[self] = true;
	return self;
end

function Scrollbar:get ()
	local percent = (self.offset * (self.max - self.min) / (self.h - self.size));
	percent = (self.min + percent);

	return tonumber (('%.1f'):format (percent));
end

function Scrollbar:draw (x, y, color, postGUI)
	local w, h = self.w, self.h;
	self.hover = false;

	local inScroll = isCursorOnElement (x, y, w, h);
	if (inScroll) then
		self.hover = true;
	end

	local state = self.state;
	if (state) then
		local _, cursorY = getCursorPosition ();
		cursorY = (cursorY - y);

		local total = (h - self.size);
		self.offset = (cursorY < 0 and 0 or cursorY > total and total or cursorY);
	end

	dxDrawRectangle (x, y, w, h, tocolor (unpack (color.background)), postGUI);
	dxDrawRectangle (x, y + self.offset, w, self.size, tocolor (unpack ((state and color.effect or color.default))), postGUI);
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
	instance[self] = nil;

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
		local current = instance.current;
		if (current) then
			return false;
		end

		local items = instance.items;
		for item in pairs (items) do
			if (item.hover) then
				instance.current = item;

				item:toggle (true);
				break
			end
		end

		return true;
	end

	return false;
end