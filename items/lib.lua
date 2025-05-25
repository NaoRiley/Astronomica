ast = {} --global variables
AST = {} --just dont think too hard about this one

ast.euler = 2.718281828459045 --this is for the factorial function

ast.pi = 3.14159265358979 --this is also for the factorial functuion

--print('before')
ast.start = love.timer.getTime() --gives some time
--print('after', start)

ast.idle = love.timer.getTime() --idle anticheat

ast.context_counts={}

-- UTIL_TABLE = {} 
-- function UTIL_TABLE.factorial(n) --for factorial bullshit
-- 	print(type(n), n, to_number(n))
--     local res = to_big(1)
-- 	print(type(n), n)
--     for i = 2, to_number(n) do --try approximation
--         res = res * to_big(i)
-- 		print(n, i, res)
--     end
--     return res
-- end

UTIL_TABLE = {} 
function UTIL_TABLE.small_factorial(n) --exact computation factorial (for smaller numbers)
	--print(type(n), n, to_number(n))
    local res = to_big(1)
	local i = to_big(1)
	while i:lt(to_big(n)) or i:eq(to_big(n)) do
		res = res * to_big(i)
		i = to_big(i) + to_big(1)
		--print(n, i, res)
	end
    return res
end
 
function UTIL_TABLE.additive_factorial(n) --additive factorial
	return (to_big(n)*(to_big(n)+1)/2)
end

function UTIL_TABLE.factorial(n) --multiplicative factorial
    return (to_big(ast.pi * 2)*to_big(n)):pow(0.5)*(to_big(n)/to_big(ast.euler))^to_big(n)
end

function UTIL_TABLE.efactorial(n) --exponential factorial
    return (to_big(ast.pi * 2)*to_big(n^(n-1))):pow(0.5)*(to_big(n^(n-1))/to_big(ast.euler))^to_big(n^(n-1))
end

-- if (key == 'p_score' or key == 'pscore' or key == 'pscore_mod') and amount ~= 1 then --i dont fucking know how to do this
-- 	G.E_MANAGER:add_event(Event({
-- 		func = function() 
-- 			G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.pscore))
-- 			G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
-- 			play_sound('multhit1')
-- 			play_sound('chips1')
-- 			return true
-- 		end,
-- 	}))
-- end

local null_mult = mod_mult
mod_mult = function(mult)
	if G.GAME.blind.config.blind.key == "bl_ast_torrent" then
		return 1
	end
  return null_mult(mult)
end

local null_chips = mod_chips
mod_chips = function(chips)
	if G.GAME.blind.config.blind.key == "bl_ast_inferno" then
		return 1
	end
  return null_chips(chips)
end

--horrible:
---@meta

---@class AST.Font: AST.GameObject
---@field obj_table? table<string, AST.Font|table> Table of objects registered to this class. 
---@field super? AST.GameObject|table Parent class. 
---@field path? string Name of the font file, including the extension. 
---@field render_scale? number Determine the font size the text is being rendered after multiplying by `G.TILESIZE`. This is usually set to a high number for better font readability. The default font's value is `10`.
---@field TEXT_HEIGHT_SCALE? number Determines line spacing. The default font's value is `0.83`.
---@field TEXT_OFFSET? table|{x: number, y: number} Determines the offset that the font is rendered. You might need to adjust this if the font render in unexpected places. This one depends on how far the font is from expected place and is entirely up to the font itself so it is necessary to test which value works best.
---@field FONTSCALE? number Determines how big the font actually is rendered after scaling with `render_scale`. This is usually set to a lower number in inverse proportion to `render_scale` so that it renders at a proper size. The default font's value is `0.1`.
---@field squish? number Determines horizontal scaling factor of the font. Value less than 1 will result in fonts being squished together. All fonts in the base game has this value set to `1` by default.
---@field DESCSCALE? number Determines how big the description text should be in relation to normal text. Keep in mind that mobile UI makes this 1.5x bigger. The default font's value is `1`.
---@field __call? fun(self: AST.Font|table, o: AST.Font|table): nil|table|AST.Font
---@field extend? fun(self: AST.Font|table, o: AST.Font|table): table Primary method of creating a class. 
---@field check_duplicate_register? fun(self: AST.Font|table): boolean? Ensures objects already registered will not register. 
---@field check_duplicate_key? fun(self: AST.Font|table): boolean? Ensures objects with duplicate keys will not register. Checked on `__call` but not `take_ownership`. For take_ownership, the key must exist. 
---@field register? fun(self: AST.Font|table) Registers the object. 
---@field check_dependencies? fun(self: AST.Font|table): boolean? Returns `true` if there's no failed dependencies. 
---@field process_loc_text? fun(self: AST.Font|table) Called during `inject_class`. Handles injecting loc_text. 
---@field send_to_subclasses? fun(self: AST.Font|table, func: string, ...: any) Starting from this class, recusively searches for functions with the given key on all subordinate classes and run all found functions with the given arguments. 
---@field pre_inject_class? fun(self: AST.Font|table) Called before `inject_class`. Injects and manages class information before object injection. 
---@field post_inject_class? fun(self: AST.Font|table) Called after `inject_class`. Injects and manages class information after object injection. 
---@field inject_class? fun(self: AST.Font|table) Injects all direct instances of class objects by calling `obj:inject` and `obj:process_loc_text`. Also injects anything necessary for the class itself. Only called if class has defined both `obj_table` and `obj_buffer`. 
---@field inject? fun(self: AST.Font|table, i?: number) Called during `inject_class`. Injects the object into the game. 
---@field take_ownership? fun(self: AST.Font|table, key: string, obj: AST.Font|table, silent?: boolean): nil|table|AST.Font Takes control of vanilla objects. Child class must have get_obj for this to function
---@field get_obj? fun(self: AST.Font|table, key: string): AST.Font|table? Returns an object if one matches the `key`. 
---@overload fun(self: AST.Font): AST.Font
AST.Font = setmetatable({}, {
    __call = function(self)
        return self
    end
})

---@type table<string, AST.Font|table>
AST.Fonts = {} 

AST.Font{
    key = "futhark",
    path = "Futhark.ttf",
    render_scale = 7,
    TEXT_HEIGHT_SCALE = 0.65, 
    TEXT_OFFSET = {x=0,y=0}, 
    FONTSCALE = 0.12,
    squish = 1, 
    DESCSCALE = 1
}

AST.Font{
    key = "futhark2",
    path = "Futhark2.ttf",
    render_scale = 7,
    TEXT_HEIGHT_SCALE = 0.65, 
    TEXT_OFFSET = {x=0,y=0}, 
    FONTSCALE = 0.12,
    squish = 1, 
    DESCSCALE = 1
}

function ast.FormatArrowMult(arrows, chips)
    chips = number_format(chips)
    if to_big(arrows) < to_big(-1) then 
        return "="..chips 
    elseif to_big(arrows) < to_big(0) then 
        return "+"..chips 
    elseif to_big(arrows) < to_big(6) then 
        if to_big(arrows) < to_big(1) then
            return "X"..chips
        end
        local arr = ""
        for i = 1, to_big(arrows):to_number() do
            arr = arr.."^"
        end
        return arr..chips
    else
        return "{"..arrows.."}"..chips
    end
end

local wg = win_game --makes anomaly FUCKING WORK since hidden cards IGNORE POOLS FOR SOME FUCKING REASON grahhhhhhhhhhhhhhh
win_game = function()
  wg()
  G.P_CENTERS['c_ast_anomaly'].soul_rate = 0.2
end