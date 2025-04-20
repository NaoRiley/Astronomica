--- STEAMODDED HEADER
--- MOD_NAME: Astronomica
--- MOD_ID: ASTRONOMICA
--- MOD_AUTHOR: [naoriley]
--- MOD_DESCRIPTION: Extremely unbalanced Cryptid add-on which has no direct aim in mind, just trying to make silly stuff!
--- PREFIX: ast
----------------------------------------------
------------MOD CODE -------------------------


--Welcome to the source code for this mod! A few things:
--Firstly, I do not know what i am doing. Modding is hard.
--Secondly, this is all in a single lua file, sorry about that! i've made sure to make things as organized as possible.
--If you have any suggestions, complaints, fixes, etc. PLEASE come to me! i promise i'm approachable! 
--(just keep in mind that it might be hard for me to fix any bugs on my own, i do NOT KNOW HOW TO CODE!!! (YET.))

--4/15/2025: half my code is commented out this shit is HARD

-----------------------------------------------------------------------GLOBAL VARIABLES-----------------------------------------------------------------------

local euler = 2.718281828459045 --this is for the factorial function

local pi = 3.14159265358979 --this is also for the factorial functuion

--print('before')
local start = love.timer.getTime() --gives some time idk the specifics
--print('after', start)

context_counts={}

-----------------------------------------------------------------------PLACEHOLDER ATLASES-----------------------------------------------------------------------

SMODS.Atlas{
    key = 'j_placeholder', --Joker placeholder sprite
    path = 'j_placeholder.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'p_placeholder', --Planet placeholder sprite
    path = 'p_placeholder.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 's_placeholder', --Spectral placeholder sprite
    path = 's_placeholder.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 't_placeholder', --Tarot placeholder sprite
    path = 't_placeholder.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'v_placeholder', --Voucher placeholder sprite
    path = 'v_placeholder.png',
    px = 71,
    py = 95
}

-----------------------------------------------------------------------JOKER ATLASES-----------------------------------------------------------------------

SMODS.Atlas{
	key = 'exotic', --Exotic+ Jokers
	path = 'exotic.png',
	px = 71,
	py = 95
}

SMODS.Atlas{
	key = 'jokers', --Normal Jokers
	path = 'jokers.png',
	px = 71,
	py = 95
}

-- SMODS.Atlas{
--     key = 'evilblueprint', --Facsimile
--     path = 'evilblueprint.png',
--     px = 71,
--     py = 95
-- }

-- SMODS.Atlas{
--     key = 'centurio', --Centurio
--     path = 'exoticcreditcard.png',
--     px = 71,
--     py = 95
-- }

-----------------------------------------------------------------------FUNCTIONS-----------------------------------------------------------------------

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
    return (to_big(pi * 2)*to_big(n)):pow(0.5)*(to_big(n)/to_big(euler))^to_big(n)
end

function UTIL_TABLE.efactorial(n) --exponential factorial (inaccurate)
    return (to_big(pi * 2)*to_big(n^(n-1))):pow(0.5)*(to_big(n^(n-1))/to_big(euler))^to_big(n^(n-1))
end

-----------------------------------------------------------------------COLORS-----------------------------------------------------------------------

--this is some BULLSHIT WHY IS IT SO COMPLICATED TO ADD A NEW COLOR

multi_gradient = SMODS.Gradient{
	key = 'multicolor',
	colours = {
		HEX('FF0000'), --red
		HEX('FFA500'), --orange
		HEX('FFFF00'), --yellow
		HEX('00FF00'), --lime
		HEX('00FFFF'), --aqua
		HEX('FF00FF'), --purple
	},
	cycle = 10,
	interpolation = 'trig',
}

-----------------------------------------------------------------------RARITIES-----------------------------------------------------------------------

SMODS.Rarity{
	key = 'ascendant',
	loc_txt = {name = 'Ascendant'},
	badge_colour = multi_gradient, --calls the variable
}

-----------------------------------------------------------------------TAGS-----------------------------------------------------------------------

-- SMODS.Tag{ --yeah idek why this isnt working and idc either
-- 	key =  'cliptag',
-- 	loc_txt = {
-- 		name = 'Clip Tag',
-- 		text = {
-- 			'Disables effect of {C:attention}Boss Blind'
-- 		}
-- 	},
-- 	apply = function (self, tag, context)
-- 		if context.setting_blind and G.GAME.blind.boss and not context.blind.disabled then
-- 			tag:yep(
-- 				localize('ph_boss_disabled'),
-- 				G.C.GREEN,
-- 				function ()
-- 					G.GAME.blind:disable()
-- 					play_sound('timpani')
-- 					return true
-- 				end
-- 			)
-- 			tag.triggered = true
-- 		end
-- 	end
-- }

-----------------------------------------------------------------------JOKERS-----------------------------------------------------------------------

-- SMODS.Joker{
--     key = 'testjoker',
--     loc_txt = {
--         name = 'Test Joker',
--         text = {
--             'For Testing.',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- }

-- SMODS.Joker{
--     key = 'testjoker2',
--     loc_txt = {
--         name = 'Test Joker 2',
--         text = {
--             'For Testing.',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- }

-- SMODS.Joker {
-- 	key = 'optest',
-- 	loc_txt = {
-- 		name = 'Operator Test',
-- 		text = {
-- 			'{X:dark_edition,C:white,s:2}^^^2{C:black} Chips & Mult',
-- 		}
-- 	},
-- 	pos = { x = 0, y = 0 },
-- 	cost = 100,
-- 	rarity = 'cry_exotic',
-- 	unlocked = true,
-- 	discovered = true,
-- 	no_doe = false,
-- 	immutable = true,
-- 	blueprint_compat = true,
-- 	eternal_compat = true,
-- 	perishable_compat = false,
-- 	atlas = 'j_placeholder',
-- 	calculate = function(self, card, context)
-- 		if context.joker_main then
-- 			return {
-- 				message = '^^^2',
-- 				EEEmult_mod = 2,
--                 EEEchip_mod = 2,
-- 				colour = G.C.PURPLE,
-- 				card = card
-- 			}, true
-- 		end
-- 	end
-- }

SMODS.Joker{
    key = 'trickster',
    loc_txt = {
        name = 'Trickster',
        text = {
            '{C:purple}+#1# {C:black}Score',
        }
    },
	blueprint_compat = true,
    atlas = 'jokers',
    pos = {x = 2, y = 0},
	rarity = 1,
	config = {
		extra = {
			score = 400
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.score}
		}
	end,
	calculate = function(self, card, context)
		if context.after then
			G.E_MANAGER:add_event(Event({
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score))
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('multhit1')
					play_sound('chips1')
					return true
				end,
			}))
		end
		if context.after then
			return {
				message = "+" .. tostring(card.ability.extra.score),
				colour = G.C.PURPLE
			}
		end
	end
}

SMODS.Joker{
    key = 'stopwatch',
    loc_txt = {
        name = 'Stopwatch',
        text = {
            'Gives {C:chips}+#2# {C:black}chip for each ',
			'{C:attention}second {C:black}game has been open',
			'{C:inactive}(Currently {C:chips}#1# {C:inactive}chips)',
        }
    },
    atlas = 'jokers',
    pos = {x = 1, y = 0},
	rarity = 2,
	blueprint_compat = true,
	config = {
		extra = {
			chips = 0,
			chip_mod = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.chips, card.ability.extra.chip_mod}
		}
	end,
	update = function(self, card, dt)
		local time_elapsed = love.timer.getTime() - start
		card.ability.extra.chips = (math.floor(time_elapsed/1) * card.ability.extra.chip_mod) --/1 means per second, /60 would mean per minute
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
				chip_mod = card.ability.extra.chips,
				colour = G.C.CHIPS
			}
		end
	end
}

SMODS.Joker{
    key = 'warlock',
    loc_txt = {
        name = 'Warlock',
        text = {
            'This joker gains {X:purple,C:white}X#2#{C:black} Score',
			'per {C:attention}hand {C:black}played.',
			'Loses {X:purple,C:white}X#2#{C:black} Score per {C:attention}card {C:black}discarded',
			'{C:inactive}(Currently {X:purple,C:white}X#1#{C:inactive} Score)',
        }
    },
	blueprint_compat = true,
    atlas = 'jokers',
    pos = {x = 3, y = 0},
	rarity = 3,
	config = {
		extra = {
			score = 1,
			score_mod = 0.5
		}
	},
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.score, card.ability.extra.score_mod}
		}
	end,
	calculate = function(self, card, context)
		if context.before then
			card.ability.extra.score = (to_big(card.ability.extra.score))+(to_big(card.ability.extra.score_mod))
		end
		if context.discard then
			card.ability.extra.score = math.max(1, (to_big(card.ability.extra.score))-(to_big(card.ability.extra.score_mod)))
		end
		if context.after then
			G.E_MANAGER:add_event(Event({
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips))*(to_big(card.ability.extra.score))
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('multhit1')
					play_sound('chips1')
					return true
				end,
			}))
		end
		if context.after then
			return {
				message = "X" .. tostring(card.ability.extra.score),
				colour = G.C.PURPLE
			}
		end
	end
}

SMODS.Joker {
	key = 'facsimile', --code mostly copied from old blueprint in cryptid with the banana code removed i dont know how 95% of this works
	loc_txt = {
		name = 'Facsimile',
		text = {
			'Copies ability of ',
			'{C:attention}Joker{} to the left',
		}
	},
	pos = { x = 0, y = 0 },
	config = { extra = { odds = 0 } }, --note to self DONT delete this i have NO idea why but deleting this crashes the fucking game
	rarity = 3,
	cost = 10,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i - 1]
				end
			end
			if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
				card.ability.blueprint_compat = "compatible"
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,
	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil
		return {
			vars = {
				cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
				card.ability.extra.odds,
			},
			main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
		}
	end,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = 'jokers',
	calculate = function(self, card, context)
	if not context.blueprint or (context.blueprint and context.fromRight) then --prevents the crash
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i - 1]
				end
			end
			if other_joker and other_joker ~= card then
				context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
				context.blueprint_card = context.blueprint_card or card
				context.fromRight = true

				if context.blueprint > #G.jokers.cards + 1 then
					return
				end

				local other_joker_ret, trig = other_joker:calculate_joker(context)
				local eff_card = context.blueprint_card or card

				context.blueprint = nil
				context.blueprint_card = nil
				context.fromRight = nil

				if other_joker_ret == true then
					return other_joker_ret
				end
				if other_joker_ret or trig then
					if not other_joker_ret then
						other_joker_ret = {}
					end
					other_joker_ret.card = eff_card
					other_joker_ret.colour = darken(G.C.BLUE, 0.3)
					other_joker_ret.no_callback = true
					return other_joker_ret
				end
			end
		end
	end,
	cry_credits = {
		code = {
			"MathIsFun", --note to self: unsure why this isnt showing up ingame please fix it so you can actually credit him
		},
	},
}

SMODS.Joker {
	key = 'centurio',
	loc_txt = {
		name = 'Centurio',
		text = {
			'Go up to {X:dark_edition,C:white,s:2}-$Infinity {C:black} in debt',
		}
	},
	pos = { x = 3, y = 0 },
	soul_pos = { x = 4, y = 0, extra = { x = 5, y = 0 } },
	cost = 100, --higher than normal exotics on purpose
	rarity = 'cry_exotic',
	unlocked = true,
	discovered = true,
	no_doe = false,
	immutable = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	atlas = 'exotic',
	add_to_deck = function(self, card, from_debuff)
        
        G.GAME.bankrupt_at = -math.huge --makes it so your money can go to negative infinity i think? i have no way of checking how low you can actually go

    end,
}

SMODS.Joker{
    key = 'tetratia',
    loc_txt = {
        name = 'Tetratia', --ohhh yall are NOT ready...
        text = {
            'Gains {X:dark_edition,C:white}^^#2# {C:black} Score',
			' when {X:attention,C:white} ANYTHING {C:black} happens',
			'{C:inactive}(Currently {X:dark_edition,C:white}^^#1# {C:inactive} Score)',
        }
    },
    atlas = 'exotic',
    pos = {x = 0, y = 1},
	soul_pos = { x = 2, y = 1, extra = { x = 1, y = 1 } },
	blueprint_compat = true,
	price = 50,
	rarity = 'cry_exotic',
	config = {
		extra = {
			score = 1,
			score_mod = 0.0003
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.score, card.ability.extra.score_mod}
		}
	end,
	calculate = function(self, card, context)
		if context.before
		or context.main_scoring
		-- or context.individual --upgrades on every playing card
		-- or context.repetition --and not
		or context.pre_joker
		or context.joker_main
		or context.other_joker
		or context.post_joker
		-- or context.final_scoring_step --extra trigger?
		-- or context.destroy_card --few extra triggers i dont like
		-- or context.remove_playing_cards --same as above but worse
		-- or context.after --used differently
		or context.debuffed_hand
		-- or context.end_of_round --why does this upgrade for every card
		or context.setting_blind --maybe doesnt work
		or context.pre_discard
		or context.discard
		or context.open_booster
		or context.skipping_booster
		-- or context.buying_card --overlap with card added
		or context.selling_card
		or context.reroll_shop
		or context.ending_shop
		or context.first_hand_drawn
		or context.hand_drawn
		or context.using_consumeable
		or context.skip_blind
		or context.playing_card_added
		-- or context.post_trigger
		or context.card_added
		or context.ending_booster
		-- or context.modify_scoring_hand --annoying
		or context.blind_disabled
		or context.blind_defeated
		or context.press_play
		-- or context.debuff_card
		-- or context.debuff_hand
		-- or context.stay_flipped
		-- or context.modify_hand
		-- or context.cry_press
 		and not (context.repetition or context.blueprint) then
			-- for i, _ in pairs(context) do --print debugging
			-- 	if i ~= "main_eval" then
			-- 		context_counts[i] = (context_counts[i] or 0) + 1
			-- 		break
			-- 	end
			-- end
			  
			--   print(context_counts)
			card.ability.extra.score = (to_big(card.ability.extra.score))+(to_big(card.ability.extra.score_mod))
			return {
				message = 'Upgrade!',
			colour = G.C.DARK_EDITION,
			card = card
			}
		end
		if context.after then
			G.E_MANAGER:add_event(Event({
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips)):arrow(2, card.ability.extra.score)
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('multhit1')
					play_sound('chips1')
					return true
				end,
			}))
		end
		if context.after then
			return {
				message = "X" .. tostring(card.ability.extra.score),
				colour = G.C.PURPLE
			}
		end
	end
}

SMODS.Joker {
	key = "factoria", 
	loc_txt = {
		name = "Factoria",
		text = {
			"At end of round, Joker's {X:mult,C:white}XMult{C:black} becomes {X:dark_edition,C:white}(XMult)! ",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{}{C:inactive} Mult)",
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
	cost = 100,
	rarity = 'ast_ascendant',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "exotic",
	config = {
		extra = {
			n = 3, 
			c = false
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.n}
		}
	end,
	calculate = function(self, card, context) --i now see why nobody has done factorials in this game before
		--print('calculate called')
		if context.first_hand_drawn then
			card.ability.extra.c = false
		end
		if context.end_of_round and card.ability.extra.c == false then
			--print('round end')
			card.ability.extra.c = true
			if to_big(card.ability.extra.n):gt(to_big(150)) then
				card.ability.extra.n = UTIL_TABLE.factorial(card.ability.extra.n)
			else
				card.ability.extra.n = UTIL_TABLE.small_factorial(card.ability.extra.n)
			end
		end
		if context.joker_main then
			return {Xmult_mod = card.ability.extra.n, message = "X" .. tostring(card.ability.extra.n)}
		end
		if context.end_of_round and context.game_over == false and not context.repetition and not context.blueprint then
			return {
				message = 'Upgrade!',
			colour = G.C.DARK_EDITION,
			card = card
			}
		end
	end
}

-- SMODS.Joker{
--     key = 'scorepf',
--     loc_txt = {
--         name = 'additive test',
--         text = {
--             '{X:dark_edition,C:white,s:2}Score?',
--         }
--     },
-- 	blueprint_compat = true,
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	calculate = function(self, card, context)
-- 		if context.after then
-- 			G.E_MANAGER:add_event(Event({
-- 				func = function() 
-- 					G.GAME.chips = (to_big(G.GAME.chips)*(to_big(G.GAME.chips)+1)/2)
-- 					play_sound('multhit2')
-- 					play_sound('chips1')
-- 					return true
-- 				end,
-- 			}))
-- 		end
-- 		if context.after then
-- 			return {
-- 				message = 'Score?',
-- 				colour = G.C.PURPLE
-- 			}
-- 		end
-- 	end
-- }

-- SMODS.Joker{
--     key = 'scorexf',
--     loc_txt = {
--         name = 'multiplicative test',
--         text = {
--             '{X:dark_edition,C:white,s:2}Score!',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	calculate = function(self, card, context)
-- 		if context.after then
-- 			G.E_MANAGER:add_event(Event({
-- 				func = function() 
-- 					G.GAME.chips = (to_big(pi * 2)*to_big(G.GAME.chips)):pow(0.5)*(to_big(G.GAME.chips)/to_big(euler))^to_big(G.GAME.chips)
-- 					play_sound('multhit2')
-- 					return true
-- 				end,
-- 			}))
-- 		end
-- 		if context.after then
-- 			return {
-- 				message = 'Score!',
-- 				colour = G.C.PURPLE
-- 			}
-- 		end
-- 	end
-- }

-- SMODS.Joker{
--     key = 'scoreef',
--     loc_txt = {
--         name = 'exponential test',
--         text = {
--             '{X:dark_edition,C:white,s:2}Score^!',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	calculate = function(self, card, context)
-- 		if context.after then
-- 			G.E_MANAGER:add_event(Event({
-- 				func = function() 
-- 					G.GAME.chips = (to_big(pi * 2)*to_big(G.GAME.chips^(G.GAME.chips-1))):pow(0.5)*(to_big(G.GAME.chips^(G.GAME.chips-1))/to_big(euler))^to_big(G.GAME.chips^(G.GAME.chips-1))
-- 					play_sound('multhit2')
-- 					return true
-- 				end,
-- 			}))
-- 		end
-- 		if context.after then
-- 			return {
-- 				message = 'Score^!',
-- 				colour = G.C.PURPLE
-- 			}
-- 		end
-- 	end
-- }

-- SMODS.Joker{
--     key = 'postscoretest', --ok some things to note: context.final_scoring step is for effects that modify the score after all cards have been scored, the round score itself is G.GAME.chips, additive factoral:x(x+1)/2
--     loc_txt = {
--         name = 'Post Score Test',
--         text = {
--             '{X:dark_edition,C:white,s:2}Score?',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	calculate = function(self, card, context)
-- 		if context.final_scoring_step then
-- 			G.GAME.chips = (to_big(G.GAME.chips)*(to_big(G.GAME.chips)+1)/2)
-- 		end
-- 	end
-- }

-- SMODS.Joker{
--     key = 'shoptest',
--     loc_txt = {
--         name = 'Shop Test',
--         text = {
--             'placeholder',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0}
-- }

-- SMODS.Joker{
--     key = 'normalfactorial',
--     loc_txt = {
--         name = 'Normal Factorial Test',
--         text = {
--             'placeholder',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- }

----------------------------------------------
------------MOD CODE END----------------------
