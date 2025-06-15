ast = {} --global variables
AST = {} --just dont think too hard about this one

if not AST then AST = ast end

ast.euler = 2.718281828459045 --this is for the factorial function

ast.pi = 3.14159265358979 --this is also for the factorial functuion

--print('before')
ast.start = love.timer.getTime() --gives some time
--print('after', start)

AST.start = love.timer.getTime() --fix compat

-- ast.idle = love.timer.getTime() --idle anticheat

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

ast.simple_event_add = function (func, delay, queue) --thanks aiko
    G.E_MANAGER:add_event(Event{
        trigger = 'after',
        delay = delay or 0.1,
        func = func
    }, queue)
end

ast.mod_score = function(score_mod) --thanks again aiko
    ast.simple_event_add(
        function()
            score_mod = score_mod or {}
            local hyper = score_mod.arrow or 1
            local pow = score_mod.pow or 1
            local mult = score_mod.mult or 1
            local add = score_mod.add or 0
            local score_cal = score_mod.set or G.GAME.chips
            score_cal = (to_big(score_cal)):arrow(arrow, hyper)
            score_cal = score_cal ^ pow
            score_cal = score_cal * mult
            score_cal = score_cal + add
            if Talisman then
                score_cal = to_big(score_cal)
            end
            G.GAME.chips = score_cal
            G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
            play_sound('gong')
            return true
        end, 0
    )
end

local null_mult = mod_mult
mod_mult = function(mult)
	if G.GAME.mult_disabled == true then
		return 1
	end
  return null_mult(mult)
end

local null_chips = mod_chips
mod_chips = function(chips)
	if G.GAME.chips_disabled == true then
		return 1
	end
  return null_chips(chips)
end

local congruentia_mult = mod_mult
mod_mult = function(mult_change)
    local result = congruentia_mult(mult_change)
    mult = mult or 0
    hand_chips = hand_chips or 0
    if next(SMODS.find_card('j_ast_congruentia')) then
        if (to_big(mult)) + (to_big(result)) > (to_big(hand_chips)) then
            hand_chips = (mult+result)-hand_chips
        end
    end
    return result
end

local congruentia_chips = mod_chips
mod_chips = function(chips_change)
    local result = congruentia_chips(chips_change)
    mult = mult or 0
    hand_chips = hand_chips or 0
    if next(SMODS.find_card('j_ast_congruentia')) then
        if (to_big(hand_chips)) + (to_big(result)) > (to_big(mult)) then
            mult = (hand_chips+result)-mult
        end
    end
    return result
end

local ref_get_pool = get_current_pool --ty thewintercomet
function get_current_pool(_type, _rarity, _legendary, _append)
    local pool, pool_key = ref_get_pool(_type, _rarity, _legendary, _append)

    if _type == 'Joker' and G.GAME.modifiers.no_modded_jokers then
        local new_pool = {}
        for i, v in ipairs(pool) do
            if v ~= 'UNAVAILABLE' and not G.P_CENTERS[v].original_mod then
                new_pool[#new_pool+1] = v
            end
        end
        pool = new_pool
    end

    return pool, pool_key
end

-- SMODS.Font{
--     key = "futhark",
--     path = "Futhark.ttf",
--     render_scale = 7,
--     TEXT_HEIGHT_SCALE = 0.65, 
--     TEXT_OFFSET = {x=0,y=0}, 
--     FONTSCALE = 2.4,
--     squish = 1, 
--     DESCSCALE = 1
-- }

SMODS.Font{
    key = "futhark2",
    path = "Futhark2.ttf",
    render_scale = 50,
    TEXT_HEIGHT_SCALE = 0.85, 
    TEXT_OFFSET = {x=0,y=0}, 
    FONTSCALE = 0.5,
    squish = 1, 
    DESCSCALE = 1
}

SMODS.Font{
    key = "m6x11mod",
    path = "m6x11Mod.ttf",
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

local fakestart = Game.start_run
function Game:start_run(args)
    fakestart(self, args)

    for i,center in pairs(G.P_CENTERS) do
        if center.oldrarity then

            -- remove from the old pool
            local pool = G.P_JOKER_RARITY_POOLS[center.rarity]
            for idx = #pool, 1, -1 do
                if pool[idx] == center.key then
                    table.remove(pool, idx)
                    break
                end
            end

            -- readd to it's original pool
            G.P_JOKER_RARITY_POOLS[center.oldrarity][center.key] = center

            center.rarity = center.oldrarity
        end
    end
end

function table:astcontains(table, value)
    for i,j in ipairs(table) do
        if (j == value) then return true end
    end
    return false
end

 --shoutout lily vallkarri

function disable_chips()

    G.GAME.chips_disabled = true
    G.HUD:get_UIE_by_ID("chipmult_op").UIT = 0
    G.HUD:get_UIE_by_ID("hand_chip_area").UIT = 0
    G.HUD:get_UIE_by_ID("hand_chips").UIT = 0
    G.HUD:get_UIE_by_ID("flame_chips").UIT = 0
    G.HUD:get_UIE_by_ID("flame_mult").UIT = 0
    G.HUD:get_UIE_by_ID("hand_chip_area").config.minw = 0
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minw = 4
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minh = 0
    G.HUD:get_UIE_by_ID("chipmult_op").scale = 0

    G.HUD:recalculate()

end

function disable_mult()

    G.GAME.mult_disabled = true
    G.HUD:get_UIE_by_ID("chipmult_op").UIT = 0
    G.HUD:get_UIE_by_ID("hand_mult_area").UIT = 0
    G.HUD:get_UIE_by_ID("hand_mult").UIT = 0
    G.HUD:get_UIE_by_ID("flame_chips").UIT = 0
    G.HUD:get_UIE_by_ID("flame_mult").UIT = 0
    G.HUD:get_UIE_by_ID("hand_chip_area").config.minw = 4
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minw = 0
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minh = 0
    G.HUD:get_UIE_by_ID("chipmult_op").scale = 0

    G.HUD:recalculate()

end

function enable_chips()

    G.GAME.chips_disabled = false
    G.HUD:get_UIE_by_ID("chipmult_op").UIT = 1
    G.HUD:get_UIE_by_ID("hand_chip_area").UIT = 3
    G.HUD:get_UIE_by_ID("hand_chips").UIT = 5
    G.HUD:get_UIE_by_ID("flame_chips").UIT = 5
    G.HUD:get_UIE_by_ID("flame_mult").UIT = 5
    G.HUD:get_UIE_by_ID("hand_chip_area").config.minw = 2
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minw = 2
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minh = 1
    G.HUD:get_UIE_by_ID("chipmult_op").scale = 1

    G.HUD:recalculate()

end

function enable_mult()

    G.GAME.mult_disabled = false
    G.HUD:get_UIE_by_ID("chipmult_op").UIT = 1
    G.HUD:get_UIE_by_ID("hand_mult_area").UIT = 3
    G.HUD:get_UIE_by_ID("hand_mult").UIT = 5
    G.HUD:get_UIE_by_ID("flame_chips").UIT = 5
    G.HUD:get_UIE_by_ID("flame_mult").UIT = 5
    G.HUD:get_UIE_by_ID("hand_chip_area").config.minw = 2
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minw = 2
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minh = 1
    G.HUD:get_UIE_by_ID("chipmult_op").scale = 1

    G.HUD:recalculate()

end

local fakeevalstatus = card_eval_status_text

function card_eval_status_text(card, eval_type, amt, percent, dir, extra)
    if G.GAME.mult_disabled and extra and (extra.mult_mod or extra.Xmult_mod or extra.Emult_mod or extra.EEmult_mod or extra.EEEmult_mod or extra.hypermult_mod) then
        return
    end

    if G.GAME.chips_disabled and extra and (extra.chips_mod or extra.Xchips_mod or extra.Echips_mod or extra.EEchips_mod or extra.EEEchips_mod or extra.hyperchips_mod) then
        return
    end

    fakeevalstatus(card, eval_type, amt, percent, dir, extra)

end