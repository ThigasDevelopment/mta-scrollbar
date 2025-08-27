-- class's lib's
Scrollbar = { };
Scrollbar.__mode, Scrollbar.__index = 'k', Scrollbar;

-- instance's lib's
local instance = { };
instance.current = false;

instance.hover, instance.state = false, false;
instance.total = 0;

-- method's lib's
function Scrollbar.new (w, h, min, max, start)
	local self = setmetatable ({ }, Scrollbar);
	self.state = false;

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

	dxDrawRectangle (x, y, w, h, tocolor (255, 255, 255, 255), false);
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