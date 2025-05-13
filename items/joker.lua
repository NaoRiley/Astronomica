
--[[



Let's ensure all the green coded jokers stay confidential, shall we?


It's mostly testing material, or perhaps things that could make their way into a future update.


It's our secret, Keep it between us!



]]

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
					play_sound('gong')
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

-- SMODS.Joker{
--     key = 'trickster', --attempt to migrate to function
--     loc_txt = {
--         name = 'Trickster',
--         text = {
--             '{C:purple}+#1# {C:black}Score',
--         }
--     },
-- 	blueprint_compat = true,
--     atlas = 'jokers',
--     pos = {x = 2, y = 0},
-- 	rarity = 1,
-- 	config = {
-- 		extra = {
-- 			pscore = 400
-- 		}
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {card.ability.extra.pscore}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 		if context.after then
-- 			return {
-- 				message = "+" .. tostring(card.ability.extra.pscore),
-- 				pscore = 400,
-- 				colour = G.C.PURPLE,
-- 				card = card
-- 			}, true
-- 		end
-- 	end
-- }

SMODS.Joker {
	key = 'exoticjoker',
	loc_txt = {
		name = 'Exotic Joker',
		text = {
			'{X:dark_edition,C:white}^#1# {} Mult',
		}
	},
	pos = { x = 4, y = 0 },
	soul_pos = { x = 6, y = 0, extra = { x = 5, y = 0 } },
	config = {
		extra = {
			Emult_mod = 1.04
		} 
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_mod } }
	end,
	cost = 1, 
	rarity = 1,
	unlocked = true,
	discovered = true,
	no_doe = false,
	immutable = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = 'jokers',
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Emult_mod = (to_big(card.ability.extra.Emult_mod)),
				message = "^" .. tostring(card.ability.extra.Emult_mod),
				colour = G.C.DARK_EDITION
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
		local time_elapsed = love.timer.getTime() - AST.start
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
    key = 'blackleg',
    loc_txt = {
        name = 'Blackleg',
        text = {
            'Bring extra {C:attention}Score {C:black}you win to the next blind',
			'{C:inactive}(Currently {C:purple}+#1# {C:inactive}Score)',
        }
    },
    atlas = 'jokers',
    pos = {x = 7, y = 0},
	blueprint_compat = false,
	rarity = 'cry_epic',
	config = {
		extra = {
			score = 0,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.score}
		}
	end,
	calculate = function(self, card, context)
		if context.after and not context.repetiiton or context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score)),
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('gong')
					card.ability.extra.score = (to_big(0))
					return true
				end,
			}))
		end
		if context.blind_defeated and not context.repetition or context.blueprint then
			card.ability.extra.score = (to_big(G.GAME.chips))-(to_big(G.GAME.blind.chips))
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
	demicoloncompat = true,
    atlas = 'jokers',
    pos = {x = 3, y = 0},
	rarity = 'cry_epic',
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
		if context.before or context.forcetrigger then
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
					play_sound('gong')
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

-- SMODS.Joker {
-- 	key = 'centurio', --i hate this joker
-- 	loc_txt = {
-- 		name = 'Centurio',
-- 		text = {
-- 			'Go up to {X:dark_edition,C:white,s:2}-$Infinity {C:black} in debt',
-- 		}
-- 	},
-- 	pos = { x = 3, y = 0 },
-- 	soul_pos = { x = 4, y = 0, extra = { x = 5, y = 0 } },
-- 	cost = 75, --higher than normal exotics on purpose
-- 	rarity = 'cry_exotic',
-- 	unlocked = true,
-- 	discovered = true,
-- 	no_doe = false,
-- 	immutable = true,
-- 	blueprint_compat = false,
-- 	eternal_compat = true,
-- 	perishable_compat = true,
-- 	atlas = 'exotic',
-- 	add_to_deck = function(self, card, from_debuff)
        
--         G.GAME.bankrupt_at = -math.huge --makes it so your money can go to -naneinf

--     end,
-- }

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
	demicoloncompat = true,
	cost = 50,
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
			card.ability.extra.score = (to_big(card.ability.extra.score))+(to_big(card.ability.extra.score_mod))
		end
		if context.forcetrigger then
			card.ability.extra.score = (to_big(card.ability.extra.score))+(to_big(card.ability.extra.score_mod*(to_big(25)))) --demicolon upgrades it once for EVERY available context (currently 25 times)
		end
		if context.before
		or context.main_scoring
		or context.pre_joker
		or context.joker_main
		or context.other_joker
		or context.post_joker
		or context.debuffed_hand
		or context.setting_blind
		or context.pre_discard
		or context.open_booster
		or context.skipping_booster
		or context.selling_card
		or context.reroll_shop
		or context.ending_shop
		or context.first_hand_drawn
		or context.hand_drawn
		or context.using_consumeable
		or context.skip_blind
		or context.playing_card_added
		or context.card_added
		or context.ending_booster
		or context.blind_disabled
		or context.blind_defeated
		or context.press_play
 		and not (context.repetition or context.blueprint) then
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
					play_sound('gong')
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

-- SMODS.Joker{
--     key = 'monalisa',
--     loc_txt = {
--         name = 'Mona Lisa',
--         text = {
-- 			'Retrigger {C:attention}face {C:black}cards 6 times',
-- 			'Retrigger {C:attention}non face {C:black}cards 3 times',
-- 			'{X:mult,C:white}X#1# {C:black} mult per {C:attention}face {C:black}card played',
-- 			'{X:mult,C:white}X#2# {C:black} mult per {C:attention}non face {C:black}card',
-- 			'{C:inactive,s:0.8}looks inside, photochad'
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	blueprint_compat = true,
-- 	rarity = 'cry_exotic',
-- 	config = {
-- 		extra = {
-- 			xmult = 6,
-- 			xmult2 = 3,
-- 		}
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {card.ability.extra.xmult, card.ability.extra.xmult2}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 		if context.individual and context.cardarea == G.play and context.other_card:is_face() then
-- 			return{xmult = card.ability.extra.xmult}
-- 		end
-- 		if context.individual and context.cardarea == G.play and not context.other_card:is_face() then
-- 			return{xmult = card.ability.extra.xmult2}
-- 		end
-- 		if context.repetition and context.cardarea == G.play and context.other_card:is_face() then
-- 			return{repetitions = 6}
-- 		end
-- 		if context.repetition and context.cardarea == G.play and not context.other_card:is_face() then
-- 			return{repetitions = 3}
-- 		end
-- 	end
-- }

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
	rarity = 'ast_worldbending',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
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
		if context.forcetrigger then
			--print('round end')
			card.ability.extra.c = true
			if to_big(card.ability.extra.n):gt(to_big(150)) then
				card.ability.extra.n = UTIL_TABLE.factorial(card.ability.extra.n)
			else
				card.ability.extra.n = UTIL_TABLE.small_factorial(card.ability.extra.n)
			end
			card.ability.extra.c = false
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
--     key = 'reqtest',
--     loc_txt = {
--         name = 'Req Test',
--         text = {
--             'Reduces Blind Requirement by {X:attention,C:white}25%',
-- 			'{C:black}per {C:attention}hand {C:black}played'
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	blueprint_compat = true,
-- 	calculate = function(self, card, context)
-- 		if context.joker_main then
-- 			G.GAME.blind.chips = (to_big(G.GAME.blind.chips))/(to_big(1.33333))
-- 			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
-- 			play_sound('slice1')
-- 			G.hand_text_area.blind_chips:juice_up(0.3, 0.3)
-- 		end
-- 	end
-- }

-- SMODS.Joker{
--     key = 'reqtest2',
--     loc_txt = {
--         name = 'Req Test 2',
--         text = {
--             'Reduces blind requirement by {X:dark_edition,C:white}100%',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	ignore_debuff = true,
-- 	no_doe = true,
-- 	no_collection = true,
-- 	cost = 10^300,
-- 	unlocked = false,
-- 	discovered = false,
-- 	calculate = function(self, card, context)
-- 		if context.hand_drawn then
-- 			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 1,func = function()
-- 				G.GAME.blind.chips = (to_big(0))
-- 				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
-- 				play_sound('slice1')
-- 				G.hand_text_area.blind_chips:juice_up(0.3, 0.3)
-- 				G.GAME.chips = G.GAME.blind.chips
-- 				G.STATE = G.STATES.HAND_PLAYED
-- 				G.STATE_COMPLETE = true
-- 				end_round()
-- 			return true end }))
-- 		end
-- 	end
-- }

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
-- 					G.GAME.chips = (to_big(AST.pi * 2)*to_big(G.GAME.chips)):pow(0.5)*(to_big(G.GAME.chips)/to_big(AST.euler))^to_big(G.GAME.chips)
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
-- 					G.GAME.chips = (to_big(AST.pi * 2)*to_big(G.GAME.chips^(G.GAME.chips-1))):pow(0.5)*(to_big(G.GAME.chips^(G.GAME.chips-1))/to_big(AST.euler))^to_big(G.GAME.chips^(G.GAME.chips-1))
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
