# 🚀 MTA Scrollbar

Uma biblioteca moderna e eficiente para criar barras de rolagem customizadas em Lua para o Multi Theft Auto: San Andreas (MTA:SA). Ideal para interfaces dinâmicas, menus, listas e qualquer projeto que exija controle visual de rolagem.

---

## ✨ Recursos

- Integração fácil em qualquer resource do MTA:SA
- Customização total de cores, tamanhos e efeitos
- Suporte a múltiplas barras simultâneas
- Eventos nativos para interação com o cursor
- Código limpo, leve e otimizado

---

## 📦 Instalação

1. **Baixe ou clone este repositório** para sua pasta de resources:
   ```
   [github]/mta-scrollbar
   ```
2. **Adicione ao seu `meta.xml`:**
   ```xml
   <script src="scrollbar.lua" type="client" cache="false" />
   ```
3. **Certifique-se de que o arquivo `scrollbar.lua` está incluído no seu resource.**

---

## 🛠️ Como Usar

### Exemplo Básico

```lua
local scroll = Scrollbar.new (10, 150, 30, 0, 100);

addEventHandler ('onClientRender', root,
	function ()
		scroll:draw (500, 500, {
			effect = tocolor (0, 0, 255, 255),
			default = tocolor (255, 0, 0, 255),
			background = tocolor (255, 255, 255, 255),
		});

		local current = scroll:get ();
		dxDrawText (current, 470, 500);
		dxDrawText (math.floor (current), 470, 520);

		return true;
	end
);
```

### Exemplo Avançado

```lua
local list = { };
list.items = { 1, 2, 3, 4, 5, 6, 7, 8 };
list.visible = 3;

local scroll = Scrollbar.new (10, 150, 30, 0, (#list.items - list.visible));

addEventHandler ('onClientRender', root,
	function ()
		scroll:draw (520, 500, {
			effect = tocolor (255, 0, 0, 255),
			default = tocolor (0, 0, 255, 255),
			background = tocolor (255, 255, 255, 255),
		});

		local current = math.floor (scroll:get ());
		for i = 1, list.visible do
			local value = list.items[i + current];
			if (value) then
				dxDrawText (tostring (value), 540, 500 + ((i - 1) * 20));
			end
		end

		return true;
	end
);
```

---

## ⚡ Principais Métodos

- `Scrollbar.new (w, h, size, min, max)`  
  Cria uma nova barra de rolagem.
- `scroll:get ()`  
  Retorna o valor atual da barra.
- `scroll:set (value)`  
  Define o valor da barra.
- `scroll:draw (x, y, colorTable, postGUI)`  
  Renderiza a barra na tela.
- `scroll:destroy ()`  
  Remove a barra e libera recursos.

---

## 🎨 Personalização

Altere as cores, tamanhos e efeitos conforme sua interface. Utilize os métodos para manipular o valor da barra conforme sua necessidade. Combine com outros elementos gráficos do MTA para criar interfaces únicas!

---

## 🤝 Contribua

Pull requests, sugestões e melhorias são bem-vindas! Sinta-se livre para abrir issues ou enviar PRs.

---

## 📄 Licença

MIT. Sinta-se livre para contribuir!
