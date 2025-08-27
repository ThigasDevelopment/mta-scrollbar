local scroll = Scrollbar.new (100, 100, 0, 100);

addEventHandler ('onClientRender', root,
	function ()
		scroll:draw (500, 500);
	end
);