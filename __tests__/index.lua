local scrolls = {
	Scrollbar.new (10, 150, 30, 0, 100),
	Scrollbar.new (10, 150, 30, 0, 100),
}

addEventHandler ('onClientRender', root,
	function ()
		for _, scroll in ipairs (scrolls) do
			local x = (500 + (_ * 50));

			local current = math.floor (scroll:get ());
			dxDrawText (current, x, 480);

			scroll:draw (x, 500, { default = { 255, 0, 0, 255 }, background = { 255, 255, 255, 255 }, effect = { 0, 0, 255, 255 } });
		end

		return true;
	end
);