-- global's
local scrolls = { };

-- basic's test's
scrolls['basic'] = Scrollbar.new (10, 150, 30, 0, 100);

addEventHandler ('onClientRender', root,
	function ()
		scrolls['basic']:draw (500, 500, {
			effect = tocolor (0, 0, 255, 255),
			default = tocolor (255, 0, 0, 255),
			background = tocolor (255, 255, 255, 255),
		});

		local current = scrolls['basic']:get ();
		dxDrawText (current, 470, 500);
		dxDrawText (math.floor (current), 470, 520);

		return true;
	end
);

-- advanced's test's
local list = {
	'1',
	'2',
	'3',
	'4',
	'5',
	'6',
	'7',
	'8',
};

scrolls['advanced'] = Scrollbar.new (10, 150, 30, 0, (#list - 3));

addEventHandler ('onClientRender', root,
	function ()
		scrolls['advanced']:draw (520, 500, {
			effect = tocolor (255, 0, 0, 255),
			default = tocolor (0, 0, 255, 255),
			background = tocolor (255, 255, 255, 255),
		});

		local current = math.floor (scrolls['advanced']:get ());
		for i = 1, 3 do
			local value = list[i + current];
			if (value) then
				dxDrawText (value, 540, 500 + ((i - 1) * 20));
			end
		end

		return true;
	end
);