-- class's resource's
Scrollbar = { };
Scrollbar.__mode, Scrollbar.__index = 'k', Scrollbar;

-- instance's resource's
g_Scrolls = { };

-- method's resource's
function Scrollbar.new ()
	local self = setmetatable ({ }, Scrollbar);

	return self;
end