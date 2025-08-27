local scrolls = {
	Scrollbar.new (10, 150, 30, 0, 100),
	Scrollbar.new (10, 150, 30, 0, 100),
}

addEventHandler ('onClientRender', root,
	function ()
		for _, scroll in ipairs (scrolls) do
			scroll:draw (500 + (_ * 15), 500, { default = { 255, 0, 0, 255 }, background = { 255, 255, 255, 255 }, effect = { 0, 0, 255, 255 } });
		end

		return true;
	end
);