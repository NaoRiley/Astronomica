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

-- ast.mod_score = function(score_mod) --thanks again aiko
--     ast.simple_event_add(
--         function()
--             score_mod = score_mod or {}
--             local hyper = score_mod.arrow or 1
--             local pow = score_mod.pow or 1
--             local mult = score_mod.mult or 1
--             local add = score_mod.add or 0
--             local score_cal = score_mod.set or G.GAME.chips
--             score_cal = (to_big(score_cal)):arrow(arrow, hyper)
--             score_cal = score_cal ^ pow
--             score_cal = score_cal * mult
--             score_cal = score_cal + add
--             if Talisman then
--                 score_cal = to_big(score_cal)
--             end
--             G.GAME.chips = score_cal
--             G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
--             play_sound('gong')
--             return true
--         end, 0
--     )
-- end

local null_mult = mod_mult
mod_mult = function(mult)
	if G.GAME.mult_disabled == true then
		return (to_big(1))
	end
  return null_mult(mult)
end

local null_chips = mod_chips
mod_chips = function(chips)
	if G.GAME.chips_disabled == true then
		return (to_big(1))
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

local ref_get_pool = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append, ...)
    local pool, pool_key = ref_get_pool(_type, _rarity, _legendary, _append, ...)

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

--ty thewintercomet for the pool hook

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

-- local wg = win_game --makes anomaly FUCKING WORK since hidden cards IGNORE POOLS FOR SOME FUCKING REASON grahhhhhhhhhhhhhhh
-- win_game = function()
--   wg()
--   G.P_CENTERS['c_ast_anomaly'].soul_rate = 0.2
-- end

local fakestart = Game.start_run
function Game:start_run(args)
    fakestart(self, args)

    if not args.savetext then
        for i,center in pairs(G.P_CENTERS) do
            if center.oldrarity then
                local rarity = center.rarity
                local oldrarity = center.oldrarity
                SMODS.remove_pool(G.P_JOKER_RARITY_POOLS[rarity], center.key)
                SMODS.insert_pool(G.P_JOKER_RARITY_POOLS[oldrarity], center, true)
                center.rarity = oldrarity
            end
        end
    end
end

local fakestart2 = Game.start_run
function Game:start_run(args)
    fakestart2(self, args)

    if args.savetext and G.GAME.modified_rarities then --run is being continued, make every joker in table common
        local table = G.GAME.modified_rarities
        for k, v in pairs(table) do
        local center = G.P_CENTERS[k]
        local rarity = center.rarity
        SMODS.remove_pool(G.P_JOKER_RARITY_POOLS[rarity], center.key)
        SMODS.insert_pool(G.P_JOKER_RARITY_POOLS[1], center, true)
        center.rarity = 1
        end
    end

end

local dollarsspent = ease_dollars
ease_dollars = function(mod, instant)
    G.GAME.dollars_spent = G.GAME.dollars_spent or 0
    if (to_big(mod)) < (to_big(0)) then
        G.GAME.dollars_spent = G.GAME.dollars_spent - mod
    end
    return dollarsspent(mod, instant)
end

function table:astcontains(table, value) --i genuinely forgot what this does
    for i,j in ipairs(table) do
        if (j == value) then return true end
    end
    return false
end

local to_big_old = to_big
function to_big(x)
    if G and G.GAME and G.GAME.talisman_debuffed == true then
        return to_number(x)
    else
        return to_big_old(x)
    end
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

-- SMODS.calculation_keys[#SMODS.calculation_keys+1] = "fmult"
-- SMODS.calculation_keys[#SMODS.calculation_keys+1] = "fchips"
-- -- MUST HAVE THIS, WILL NOT WORK WITHOUT ADDING NEW CALC KEYS

-- local calceff = SMODS.calculate_individual_effect
-- function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    
--     if key == "fmult" then
--         if effect.card then juice_card(effect.card) end
--         mult = mod_mult((to_big(ast.pi * 2)*to_big(mult)):pow(0.5)*(to_big(mult)/to_big(ast.euler))^to_big(mult))
--         update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
--         if not effect.remove_default_message then
--             card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "Mult".."!", colour =  G.C.EDITION, edition = true})
--         end
--         return true
--     end

--     if key == "fchips" then 
--         if effect.card then juice_card(effect.card) end
--         hand_chips = mod_chips((to_big(ast.pi * 2)*to_big(hand_chips)):pow(0.5)*(to_big(hand_chips)/to_big(ast.euler))^to_big(hand_chips))
--         update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
--         if not effect.remove_default_message then
--             card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "Chips".."!", colour =  G.C.EDITION, edition = true})
--         end
--         return true
--     end

--     calceff(effect, scored_card, key, amount, from_edition)
    

-- end

local quadratic_ante_scaling = get_blind_amount
get_blind_amount = function(ante)
    if G.GAME.quadratic_ante_scaling == true then
        return ante * ante * 100
    end
    return quadratic_ante_scaling(ante)
end

function ante_scaling(formula) --ineffectual

    G.GAME.ante_formula = formula
    
end

local arbitrary_ante_scaling = get_blind_amount --ineffectual
get_blind_amount = function(ante)
    if G.GAME.ante_formula then
        return G.GAME.ante_formula
    end
    return arbitrary_ante_scaling(ante)
end

-------------OPERATOR STUFF



-- function ast_chipmult_op(operator)
--     if operator == -1 then
--         G.GAME.ast_chipmult_op = -1
--         G.HUD:get_UIE_by_ID("chipmult_op").config.text = "+"
--         G.HUD:get_UIE_by_ID("chipmult_op").config.colour = G.C.CHIPS
--         G.HUD:recalculate()
--     elseif operator == 0 then
--         G.GAME.ast_chipmult_op = 0
--         G.HUD:get_UIE_by_ID("chipmult_op").config.text = "X"
--         G.HUD:get_UIE_by_ID("chipmult_op").config.colour = G.C.MULT
--         G.HUD:recalculate()
--     elseif operator == 1 then
--         G.GAME.ast_chipmult_op = 1
--         G.HUD:get_UIE_by_ID("chipmult_op").config.text = "^"
--         G.HUD:get_UIE_by_ID("chipmult_op").config.colour = G.C.DARK_EDITION
--         G.HUD:recalculate()
--     end
-- end

ast.score_cache = {}
function ast.get_chipmult_score(hand_chips, mult)
    local operator = math.max(ast_get_final_operator(), -1)
    if ast.score_cache[number_format(hand_chips).."x"..number_format(mult)] then return ast.score_cache[number_format(hand_chips).."x"..number_format(mult)] end
    if operator <= -2 then return to_big(1) / to_big(0)
    elseif operator == -2 then hand_chips=to_big(mult); return hand_chips
    elseif operator == -1 then return to_big(hand_chips)+to_big(mult) 
    elseif operator == 0 then return to_big(hand_chips)*to_big(mult) end
    local ret = (operator and to_big(hand_chips):arrow(operator, to_big(mult)) or to_big(hand_chips)*to_big(mult))
    ast.score_cache[number_format(hand_chips).."x"..number_format(mult)] = ret
    return ret
end

if not Entropy then
    function update_operator_display()
        local ast_aoperator = ast_get_final_operator()
        local colours = {
            [-1] = G.C.CHIPS,
            [0] = G.C.MULT,
            [1] = G.C.DARK_EDITION,
            [2] = G.C.DARK_EDITION,
            [3] = G.C.DARK_EDITION,
            [4] = G.C.DARK_EDITION,
        }
        local txt = ast.FormatArrowMult(ast_aoperator, "")
        local operator = G.HUD:get_UIE_by_ID('chipmult_op')
        if operator then
            operator.config.text = txt
            operator.config.text_drawable:set(txt)
            if ast_aoperator > 1 and ast_aoperator < 6 then
                operator.config.scale = 0.3 + 0.5 / ast_aoperator
            else
                operator.config.scale = 0.8
            end
            local col = colours[math.min(math.max(ast_aoperator, -1), 4)]
            operator.UIBox:recalculate()
            operator.config.colour = col
        end
    end
end

local orig_final = ast_get_final_operator
function ast_get_final_operator()
    local op = 0
    if orig_final then
        op = op + orig_final() - 1
    end
    return op + (G.GAME.ast_operator or 0)
end
function get_chipmult_sum(chips, mult)
    return ast.get_chipmult_score(chips, mult)
end

local ast_gsr = Game.start_run
function Game:start_run(args)
    ast_gsr(self, args)
    G.GAME.ast_operator = G.GAME.ast_operator or 0
    update_operator_display()
    ast.safe_pointer = false
end

-- local ast_gsr = Game.start_run
-- function Game:start_run(args)
--     ast_gsr(self, args)
-- end

function ease_operator(operator)

    G.GAME.ast_operator = G.GAME.ast_operator + operator
    update_operator_display()
    play_sound('highlight2', 0.685, 0.2)
    play_sound('generic1')
    
end

function set_operator(operator)

    G.GAME.ast_operator = operator
    update_operator_display()
    play_sound('highlight2', 0.685, 0.2)
    play_sound('generic1')

end

-------------------------------------------------------------

local astscie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if next(SMODS.find_card('j_ast_muspelheim')) then
        if key == "hypermult" or key == "hyperchips" or key == "hypermult_mod" or key == "hyperchip_mod" or key == "hyper_mult" or key == "hyper_chips" then
            amount[1] = amount[1] + 1
        elseif key == "eee_mult" or key == "eeemult" then
            key = "hypermult"
            amount = {4, amount}
        elseif key == "eee_chips" or key == "eeechips" then
            key = "hyperchips"
            amount = {4, amount}
        elseif key == "EEEmult_mod" then
            key = "hypermult_mod"
            amount = {4, amount}
        elseif key == "EEEchip_mod" then
            key = "hyperchip_mod"
            amount = {4, amount}
        else
            key = ({
                ["mult"] = "xmult",
                ["mult_mod"] = "x_mult_mod",
                ["chips"] = "x_chips",
                ["chip_mod"] = "Xchip_mod",
                ["x_chips"] = "echips",
                ["xchips"] = "echips",
                ["Xchip_mod"] = "Echip_mod",
                ["x_mult"] = "emult",
                ["xmult"] = "emult",
                ["x_mult_mod"] = "Emult_mod",
                ["Xmult_mod"] = "Emult_mod",
                ['e_mult'] = "ee_mult",
                ['e_chips'] = "ee_chips",
                ['ee_mult'] = "eee_mult",
                ['ee_chips'] = "eee_chips",
                --'eee_mult', 
                --'eee_chips'
                ['emult'] = "ee_mult",
                ['echips'] = "ee_chips",
                ['eemult'] = "eee_mult",
                ['eechips'] = "eee_chips",
                --'eeemult', 
                --'eeechips'
                ['Emult_mod'] = "EEmult_mod",
                ['Echip_mod'] = "EEchip_mod",
                ['EEmult_mod'] = "EEEmult_mod", 
                ['EEchip_mod'] = "EEEchip_mod", 
                --'EEEmult_mod', 
                --'EEEchip_mod'
            })[key] or key
            --TARGET: patch in custom effects here
        end
    end
    return astscie(effect, scored_card, key, amount, from_edition)
end

local ast_flip = Card.flip
function Card:flip()
    if not self.ability.perma_flipped then
        ast_flip(self)
    end
end

-- flip_benefit = function()
--     if G.GAME.flip_benefit = true then
--         if card.facing == 'back' then

--         end
--     end
-- end

SMODS.Gradient{
	key = 'echips',
	colours = {
		HEX('009dff'), --chips
		HEX('0040ff'), --dark blue
		HEX('89e4ff'), --light blue
	},
	cycle = 6,
	interpolation = 'trig',
}

SMODS.Gradient{
	key = 'emult',
	colours = {
		HEX('FE5F55'), --mult
		HEX('d70d00'), --dark red
		HEX('ff968f'), --light red
	},
	cycle = 6,
	interpolation = 'trig',
}

SMODS.Gradient{
	key = 'escore',
	colours = {
		HEX('8867a5'), --score
		HEX('6700c1'), --dark score
		HEX('e270ff'), --light score
	},
	cycle = 6,
	interpolation = 'trig',
}


SMODS.Gradient{
	key = 'evalues',
	colours = {
		HEX('3dd622'), --green
		HEX('1a7509'), --dark green
		HEX('91fa7d'), --light green
	},
	cycle = 6,
	interpolation = 'trig',
}

SMODS.Gradient{
	key = 'yggdrasil',
	colours = {
		HEX('3dd622'), --green
		HEX('3dd622'), --green
	},
	cycle = 99999999999,
	interpolation = 'trig',
}

SMODS.Consumable:take_ownership("cry_gateway",{
	use = function(self, card, area, copier)
		if not Entropy.DeckOrSleeve("doc") and (#SMODS.find_card("j_jen_saint") + #SMODS.find_card("j_jen_saint_attuned")) <= 0 and (G.GAME.safe_gateway ~= true) then
			local deletable_jokers = {}
			for k, v in pairs(G.jokers.cards) do
				if not v.ability.eternal then
					deletable_jokers[#deletable_jokers + 1] = v
				end
			end
			local _first_dissolve = nil
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.75,
				func = function()
					for k, v in pairs(deletable_jokers) do
						if v.config.center.rarity == "cry_exotic" then
							check_for_unlock({ type = "what_have_you_done" })
						end
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
					return true
				end,
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_gateway")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    if Entropy.DeckOrSleeve("doc") then
      ease_entropy(-math.min(G.GAME.entropy, 5))
    end
	end
},true)

-- if ast.safe_pointer == true then
--     local midgard_pointer = Cryptid.inject_pointer_aliases
--     Cryptid.inject_pointer_aliases = function()
--         --print("[CRYPTID] Inserting Pointer Aliases")
--         local alify = Cryptid.pointeraliasify
--         for key, aliasesTable in pairs(aliases) do
--             for _, alias in pairs(aliasesTable) do
--                 alify(key, alias, nil)
--             end
--             alify(key, key, nil)
--         end
--         for _, group in pairs(G.localization.descriptions) do
--             if
--                 _ ~= "Back"
--                 and _ ~= "Content Set"
--                 and _ ~= "Edition"
--                 and _ ~= "Enhanced"
--                 and _ ~= "Stake"
--                 and _ ~= "Other"
--             then
--                 for key, card in pairs(group) do
--                     if G.P_CENTERS[key] then
--                         alify(key, type(card.name) == "table" and card.name[1] or card.name, nil)
--                         if G.P_CENTERS[key].name then
--                             alify(key, G.P_CENTERS[key].name, nil)
--                         end
--                         if G.P_CENTERS[key].original_key then
--                             alify(key, G.P_CENTERS[key].original_key, nil)
--                         end
--                     end
--                 end
--             end
--         end
--         return midgard_pointer
--     end
-- end

function jlann(txt, duration, size, col, snd, sndpitch, sndvol) --i took this basically verbatim from jenlib, jen, if this needs to be removed tell me and ill remove it
	if type(duration) == 'string' then
		duration = (tonumber(duration) or 0)*G.SETTINGS.GAMESPEED
	end
	G.E_MANAGER:add_event(Event({
		func = (function()
			if snd then play_sound(snd, sndpitch, sndvol) end
			attention_text({
				scale = size or 1.4, text = txt, hold = duration or 2, colour = col or G.C.WHITE, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
			})
		return true
	end)}))
end

-----------------------------------------------------scoremod stuff

if SMODS and SMODS.calculate_individual_effect then
	local scorescie = SMODS.calculate_individual_effect
	function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
		local ret = scorescie(effect, scored_card, key, amount, from_edition)
		if ret then
		  return ret
		end
		-- ! score operations should be done on context.after
		if (key == 'score' or key == 'score_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):add(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_addscore(scored_card or effect.card or effect.focus, 'ast_addscore', amount, percent)
			end
			return true
		end
		if (key == 'x_score' or key == 'Xscore_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):mul(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.4, 0.4)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_xscore(scored_card or effect.card or effect.focus, 'ast_xscore', amount, percent)
			end
			return true
		end
		if (key == 'e_score' or key == 'Escore_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(1, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.5, 0.5)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_escore(scored_card or effect.card or effect.focus, 'ast_escore', amount, percent)
			end
			return true
		end
		if (key == 'ee_score' or key == 'EEscore_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(2, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.6, 0.6)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eescore(scored_card or effect.card or effect.focus, 'ast_eescore', amount, percent)
			end
			return true
		end
		if (key == 'eee_score' or key == 'EEEscore_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(3, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.7, 0.7)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eeescore(scored_card or effect.card or effect.focus, 'ast_eeescore', amount, percent)
			end
			return true
		end
		if key == 'hyper_score' then 
			local e = card_eval_status_text
			-- dont know who or what this would save but hhhhhh
			if type(amount) ~= 'table' then
				local operand = amount
				amount = {3, operand}
			end
			card_eval_status_text = function() end
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(amount[1], amount[2])
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.4 + (amount[1] * 0.1), 0.7)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.4 + (amount[1] * 0.1), 0.7)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_hyper_score(scored_card or effect.card or effect.focus, 'ast_eeescore', amount, percent)
			end
			return true
		end
		if (key == 'eq_score' or key == 'EQscore_mod') then 
			local e = card_eval_status_text
			card_eval_status_text = function() end
			 G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.2, 0.2)
			return true end}))
			card_eval_status_text = e
			if not Talisman.config_file.disable_anims then
				card_eval_status_text_eqscore(scored_card or effect.card or effect.focus, 'ast_eqscore', amount, percent)
			end
			return true
		end
    end
    for _, v in ipairs({
		'score', 'score_mod',
		'x_score', 'Xscore_mod',
		'e_score', 'Escore_mod',
		'ee_score', 'EEscore_mod',
		'eee_score', 'EEEscore_mod',
		'hyper_score',
		'eq_score', 'EQscore_mod',
	}) do
        table.insert(SMODS.calculation_keys, v)
    end
end

function card_eval_status_text_addscore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'ast_addscore'
	amt = amt
	text = '+'..amt..' Score'
	colour = G.C.PURPLE
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_xscore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'ast_xscore'
	amt = amt
	text = 'X'..amt..' Score'
	colour = G.C.PURPLE
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_escore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'ast_escore'
	amt = amt
	text = '^'..amt..' Score'
	colour = G.C.PURPLE
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.8
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eescore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'ast_eescore'
	amt = amt
	text = '^^'..amt..' Score'
	colour = G.C.PURPLE
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.9
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eeescore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'ast_eescore'
	amt = amt
	text = '^^^'..amt..' Score'
	colour = G.C.PURPLE
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.min(30, math.log(amt, 500))
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_hyper_score(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'ast_eescore'
	amt = amt
	text = (amt[1] > 5 and ('{' .. tostring(amt[1]) .. '}') or string.rep('^', amt[1])) .. tostring(amt[2])..' Score'
	colour = G.C.PURPLE
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	amt = amt[2]
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.min(40, math.log(amt, 500))
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

SMODS.Sound({key = 'eqscore', path = 'EqualsScore.ogg'})
SMODS.Sound({key = 'addscore', path = 'AdditiveScore.ogg'})
SMODS.Sound({key = 'xscore', path = 'MultiplicativeScore.ogg'})
SMODS.Sound({key = 'escore', path = 'ExponentialScore.ogg'})
SMODS.Sound({key = 'eescore', path = 'TetrationalScore.ogg'})


----------------------------------------------------------------end of scoremod
