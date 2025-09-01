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
function Scrollbar.new (w, h, ratio, min, max)
	local self = setmetatable ({ }, Scrollbar);
	self.state = false;

	self.w, self.h = (w or 10), (h or 100);
	self.ratio, self.offset = (ratio or 30), 0;

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
	local percent = (self.offset * (self.max - self.min) / (self.h - self.ratio));
	percent = (self.min + percent);

	return tonumber (('%.1f'):format (percent));
end

function Scrollbar:set (value)
	local valueType = type (value);
	if (valueType ~= 'number') then
		return false;
	end

	local max = (self.max - self.min);
	value = math.max (0, math.min (value, max));

	local total = (self.h - self.ratio);
	self.offset = math.max (0, math.min (((value - self.min) * total / max), total));

	return true;
end

function Scrollbar:draw (x, y, color, postGUI)
	local w, h, ratio = self.w, self.h, self.ratio;
	self.hover = false;

	local inScroll = isCursorOnElement (x, y + self.offset, w, ratio);
	if (inScroll) then
		self.hover = true;
	end

	local state = self.state;
	if (state) then
		local _, cursorY = getCursorPosition ();
		cursorY = (cursorY - (y + (self.lastY - y)));

		local total = (h - ratio);
		self.offset = math.max (0, math.min (cursorY, total));
	end

	dxDrawRectangle (x, y, w, h, color.background, postGUI);
	dxDrawRectangle (x, y + self.offset, w, ratio, ((state or inScroll) and color.effect or color.default), postGUI);
	return true;
end

function Scrollbar:toggle (state, lastY)
	local current = self.state;
	if (current == state) then
		return false;
	end

	self.state, self.lastY = state, lastY;
	if (not self.state) and (self.lastY) then
		self.lastY = nil;
	end
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
function onClick (button, state, x, y)
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

				item:toggle (true, (y - item.offset));
				break
			end
		end

		return true;
	end

	return false;
end