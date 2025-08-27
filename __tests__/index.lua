local scrolls = {
	Scrollbar.new (10, 150, 30, 75, 100, 85),
}

addEventHandler ('onClientRender', root,
	function ()
		for _, scroll in ipairs (scrolls) do
			local x = (500 + (_ * 50));

			local current = math.floor (scroll:get ());
			dxDrawText (current, x, 480);

			scroll:draw (x, 500, { default = tocolor (255, 0, 0, 255), background = tocolor (255, 255, 255, 255), effect = tocolor (0, 0, 255, 255) });
		end

		return true;
	end
);

local stage = 0;
bindKey ('arrow_u', 'down',
	function ()
		local scroll = scrolls[1];
		if (not scroll) then
			return false;
		end

		local values = {
			85
		};

		stage = (stage + 1);
		if (stage > #values) then
			stage = 1;
		end

		local value = values[stage];
		scroll:set (value);

		return true;
	end
);