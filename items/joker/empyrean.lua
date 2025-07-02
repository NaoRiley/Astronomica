-- SMODS.Joker {
-- 	key = "", 
-- 	loc_txt = {
-- 		name = {
-- 			"{f:ast_futhark2,s:1.1,C:chips}",
-- 			"{s:0.8}()"
-- 		},
-- 		text = {
-- 		}
-- 	},
-- 	pos = { x = 0, y = 0 },
-- 	soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
-- 	cost = 100, --100 normal, 250 realm, 800 yggdrasil
-- 	rarity = 'ast_empyrean',
-- 	unlocked = true,
-- 	discovered = true,
-- 	blueprint_compat = true,
-- 	demicoloncompat = true,
-- 	eternal_compat = true,
-- 	perishable_compat = true,
-- 	immutable = false,
-- 	atlas = "exotic",
-- 	ast_credits = {
-- 	},
-- 	config = {
-- 		extra = {
-- 		},
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 	end,
-- }

SMODS.Joker {
	key = "bifrost", 
	loc_txt = {
		name = {
			"Bifrost",
		},
		text = {
			"{X:dark_edition,C:white}^#1#{} {C:attention}Boss Blind{} size",
			"When {C:attention}Boss Blind{} is defeated,",
			"{C:red}self destructs{}, and creates",
			"an {C:ast_multicolor}Empyrean{} Joker",
			"{C:inactive,s:0.7}Does something {C:ast_evalues,s:0.7}Special",
			"{C:inactive,s:0.7}if you have all {C:ast_multicolor,s:0.7}Realm Empyrean{C:inactive,s:0.7} Jokers",
		}
	},
	pos = { x = 4, y = 3 },
	cost = 20,
	rarity = 'cry_epic',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "jokers",
	ast_credits = {
		art = {"Tatteredlurker"},
	},
	config = {
		extra = {
			boss_size = 25,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.boss_size}
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and context.blind.boss and not card.getting_sliced then
			card.gone = false
			G.GAME.blind.chips = G.GAME.blind.chips ^ card.ability.extra.boss_size
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.HUD_blind:recalculate()
		end
		if context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and G.GAME.blind.boss
			and not card.gone and (next(SMODS.find_card('j_ast_alfheim')) and next(SMODS.find_card('j_ast_jotunheim')) and next(SMODS.find_card('j_ast_vanaheim')) and next(SMODS.find_card('j_ast_asgard'))) then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card('Joker',G.jokers, nil, nil, nil, nil, 'j_ast_yggdrasil', nil)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true end }))
			delay(0.6)
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			card.gone = true
		elseif context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and G.GAME.blind.boss
			and not card.gone then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card('Joker', G.jokers, nil, 'ast_empyrean', nil, nil, nil)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true end }))
			delay(0.6)
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			card.gone = true
		end
	end,
}

SMODS.Joker {
	key = "radalingr", 
	loc_txt = {
		name = {
			"{f:ast_futhark2,s:1.1,C:mult}Radalingr",
			"{s:0.8}(Radalingr)"
		},
		text = {
			"When triggered, Joker's {X:mult,C:white}XMult{C:black} becomes {X:dark_edition,C:white}XMult!",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{}{C:inactive} Mult)",
			"{C:inactive,s:0.8}Example: {X:dark_edition,C:white,s:0.8}3!{} ={C:inactive,s:0.8} {C:attention,s:0.8}3x2x1{C:inactive,s:0.8} (6)"
		}
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
	cost = 100,
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "exotic",
	ast_credits = {
		art = {"Tatteredlurker"},
	},
	config = {
		extra = {
			n = 3, 
			c = false
		},
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
		if context.pre_joker and card.ability.extra.c == false or context.forcetrigger then
			--print('round end')
			card.ability.extra.c = true
			if to_big(card.ability.extra.n):gt(to_big(150)) then
				card.ability.extra.n = UTIL_TABLE.factorial(card.ability.extra.n)
			else
				card.ability.extra.n = UTIL_TABLE.small_factorial(card.ability.extra.n)
			end
			card.ability.extra.c = false
			return {
				message = 'Upgrade!',
			colour = G.C.DARK_EDITION,
			card = card
			}
		end
		if context.joker_main then
			return {Xmult_mod = card.ability.extra.n, message = "X" .. tostring(card.ability.extra.n)}
		end
	end,
}

SMODS.Joker {
	key = "aukatigi", 
	loc_txt = {
		name = {
			"{f:ast_futhark2,s:1.1,C:mult}Aukatigi",
			"{s:0.8}(Aukatigi)"
		},
		text = {
			"After scoring, the total {X:chips,C:white}Chips{} and {X:mult,C:white}Mult{}",
			"replaces the played poker hand's base {X:chips,C:white}Chips{} and {X:mult,C:white}Mult{}",
		}
	},
	pos = { x = 6, y = 1 },
	soul_pos = { x = 8, y = 1, extra = { x = 7, y = 1 } },
	cost = 100,
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "exotic",
	ast_credits = {
		art = {"yahooyowza"},
	},
	config = {
		extra = {
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
		}
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step then
            local chips = hand_chips
            local mult = mult
            local text = G.FUNCS.get_poker_hand_info(G.play.cards)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.hands[text].chips = chips
                    G.GAME.hands[text].mult = mult
                    return true
                end
            }))
        end
	end,
}

-- SMODS.Joker {
-- 	key = "midgard", 
-- 	loc_txt = {
-- 		name = {
-- 			"{f:ast_futhark2,s:1.1,C:chips}Midgard",
-- 			"{s:0.8}(Midgard)"
-- 		},
-- 		text = {
-- 			{
-- 				"Certain {C:spectral}Rare Spectral{} rates are {C:attention}substantially{} increased",
-- 			},
-- 			{
-- 				"{C:spectral}Gateway{} no longer has a {C:attention}downside{}",
-- 			},
-- 			-- {
-- 			-- 	"{C:spectral}POINTER://{} can now create {C:cry_exotic}Exotic{} Jokers",
-- 			-- },
-- 			{
-- 				"Create a {C:dark_edition}Negative{} Mega {C:spectral}Spectral{} Pack at end of round",
-- 			},
-- 			-- {
-- 			-- 	"Open a Mega {C:spectral}Spectral{} Pack at end of shop",
-- 			-- },
-- 			-- {
-- 			-- 	"Create an {C:spectral}Ethereal Tag{} at end of round",
-- 			-- },
-- 		}
-- 	},
-- 	pos = { x = 3, y = 3 },
-- 	soul_pos = { x = 4, y = 3, extra = { x = 5, y = 3 } },
-- 	cost = 250, --100 normal, 250 realm, 800 yggdrasil
-- 	rarity = 'ast_empyrean',
-- 	unlocked = true,
-- 	discovered = true,
-- 	blueprint_compat = true,
-- 	demicoloncompat = true,
-- 	eternal_compat = true,
-- 	perishable_compat = true,
-- 	immutable = false,
-- 	atlas = "exotic",
-- 	ast_credits = {
-- 	},
-- 	config = {
-- 		extra = {
-- 		},
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 		if context.end_of_round and context.main_eval then
-- 			if Entropy then
-- 				SMODS.add_card{key = 'p_spectral_mega_1', edition = 'e_negative', area = G.consumeables}
-- 				G.consumeables.config.card_limit = G.consumeables.config.card_limit +
-- 			else
-- 				G.E_MANAGER:add_event(Event({
-- 					trigger = "before",
-- 					func = function()
-- 						local key = "p_spectral_mega_1"
-- 						local card = Card(
-- 							G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
-- 							G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
-- 							G.CARD_W * 1.27,
-- 							G.CARD_H * 1.27,
-- 							G.P_CARDS.empty,
-- 							G.P_CENTERS[key],
-- 							{ bypass_discovery_center = true, bypass_discovery_ui = true }
-- 						)
-- 						card.cost = 0
-- 						card.from_tag = true
-- 						G.FUNCS.use_card({ config = { ref_table = card } })
-- 						card:start_materialize()
-- 						pack_opened = true
-- 						return true
-- 					end,
-- 				}))
-- 			end
-- 		end
-- 	end,
-- 	add_to_deck = function(self, card, from_debuff)
-- 		-- G.P_CENTERS['c_soul'].soul_rate = 0
-- 		-- G.P_CENTERS['c_black_hole'].soul_rate = 0
-- 		G.P_CENTERS['c_cry_gateway'].soul_rate = 0.1
-- 		-- G.P_CENTERS['c_entr_beyond'].soul_rate = 0.01
-- 		G.P_CENTERS['c_cry_pointer'].soul_rate = 0.05
-- 		G.GAME.safe_gateway = true
-- 		-- G.GAME.safe_pointer = true
-- 	end,
-- 	remove_from_deck = function(self, card, from_debuff)
-- 		-- G.P_CENTERS['c_soul'].soul_rate = 0.003
-- 		-- G.P_CENTERS['c_black_hole'].soul_rate = 0.003
-- 		G.P_CENTERS['c_cry_gateway'].soul_rate = 0.003
-- 		-- G.P_CENTERS['c_entr_beyond'].soul_rate = 0
-- 		G.P_CENTERS['c_cry_pointer'].soul_rate = 0.003
-- 		G.GAME.safe_gateway = false
-- 		-- G.GAME.safe_pointer = false
-- 	end
-- }

SMODS.Joker {
	key = "alfheim", 
	loc_txt = {
		name = {
			"{f:ast_futhark2,s:1.1,C:chips}Alfheim",
			"{s:0.8}(Alfheim)"
		},
		text = {
			'Gain {X:dark_edition,C:white}^Chips{} for each scored {C:spades}Spade{} and {C:clubs}Club{}',
			'Gain {X:dark_edition,C:white}^Mult{} for each scored {C:hearts}Heart{} and {C:diamonds}Diamond{}',
			'{X:chips,C:white}Chips{} and {X:mult,C:white}Mult{} scale exponentially',
			"Joker's scoring effects trigger per card played",
			"{C:inactive}(Currently {X:dark_edition,C:white}^#1# {C:inactive} Chips and {X:dark_edition,C:white}^#2# {C:inactive} Mult)",
		}
	},
	pos = { x = 0, y = 2 },
	soul_pos = { x = 1, y = 2, extra = { x = 2, y = 2 } },
	cost = 250,
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "exotic",
	ast_credits = {
		art = {"Tatteredlurker"},
	},
	config = {
		extra = {
			echips = 2,
			emult = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.echips,
				card.ability.extra.emult,
			}
		}
	end,
	calculate = function(self, card, context)
		if (context.cardarea == G.play and context.individual and context.other_card:is_suit("Spades")) or (context.cardarea == G.play and context.individual and context.other_card:is_suit("Clubs")) or context.forcetrigger then
            card.ability.extra.echips = (to_big(card.ability.extra.echips)) ^ (to_big(2))
        end
		if (context.cardarea == G.play and context.individual and context.other_card:is_suit("Hearts")) or (context.cardarea == G.play and context.individual and context.other_card:is_suit("Diamonds")) or context.forcetrigger then
            card.ability.extra.emult = (to_big(card.ability.extra.emult)) ^ (to_big(2))
        end
		if (context.individual and context.cardarea == G.play) or context.forcetrigger then
            return {
				emult = card.ability.extra.emult, 
				echips = card.ability.extra.echips,
			}
		end
	end,
}

-- SMODS.Joker {
-- 	key = "nidavellir", 
-- 	loc_txt = {
-- 		name = {
-- 			"{f:ast_futhark2,s:1.1,C:chips}Nidavellir",
-- 			"{s:0.8}(Nidavellir)"
-- 		},
-- 		text = {
-- 			"",

-- 		}
-- 	},
-- 	pos = { x = 6, y = 2 },
-- 	soul_pos = { x = 8, y = 2, extra = { x = 7, y = 2 } },
-- 	cost = 250, --100 normal, 250 realm, 800 yggdrasil
-- 	rarity = 'ast_empyrean',
-- 	unlocked = true,
-- 	discovered = true,
-- 	blueprint_compat = true,
-- 	demicoloncompat = true,
-- 	eternal_compat = true,
-- 	perishable_compat = true,
-- 	immutable = false,
-- 	atlas = "exotic",
-- 	ast_credits = {
-- 	},
-- 	config = {
-- 		extra = {
-- 		},
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {}
-- 		}
-- 	end,
-- 	add_to_deck = function(self, card, from_debuff)
-- 		G.GAME.nidavellir = true
-- 	end,
-- 	add_to_deck = function(self, card, from_debuff)
-- 		G.GAME.nidavellir = false
-- 	end,
-- }

SMODS.Joker {
	key = "jotunheim", 
	loc_txt = {
		name = {
			"{f:ast_futhark2,s:1.1,C:chips}Jotunheim",
			"{s:0.8}(Jotunheim)"
		},
		text = {
			{
				"Sets a random {C:attention}Joker{} in collection's",
				"rarity to {C:blue}Common{} when {C:attention}rerolling{}",
			},
			{
				"{X:money,C:white}$?{} at end of round",
				"{C:inactive,s:0.8}Example: {X:money,C:white}4?{} ={C:inactive,s:0.8} {C:attention,s:0.8}4+3+2+1{C:inactive,s:0.8} (10)"
			},
			{
				"{X:chips,C:white}X#2#{} Chips per {C:money}Dollar{} spent this run",
				"{C:inactive}(Currently {X:chips,C:white}X#3#{C:inactive} Chips)"
			},
		}
	},
	pos = { x = 6, y = 3 },
	soul_pos = { x = 7, y = 3, extra = { x = 8, y = 3 } },
	cost = 100, --100 normal, 250 realm, 800 yggdrasil
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "exotic",
	ast_credits = {
		art = {"Tatteredlurker"},
	},
	config = {
		extra = {
			current = nil,
			xchips_mod = 1,
			xchips = 1,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.current, card.ability.extra.xchips_mod, card.ability.extra.xchips}
		}
	end,
	calculate = function(self, card, context)
		G.GAME.dollars_spent = G.GAME.dollars_spent or 0
		if G.GAME.dollars_spent <= 0 then
			card.ability.extra.xchips = 1
		else
			card.ability.extra.xchips = (G.GAME.dollars_spent*card.ability.extra.xchips_mod)
		end
		if context.reroll_shop or context.forcetrigger then
			if not G.GAME.modified_rarities then
				G.GAME.modified_rarities = {}
			end
			card.ability.extra.current = pseudorandom_element(G.P_CENTER_POOLS.Joker, pseudoseed("seed")).key
			if not G.GAME.modified_rarities[card.ability.extra.current] then
				G.GAME.modified_rarities[card.ability.extra.current] = {}
			end
			if G.P_CENTERS[card.ability.extra.current].no_doe == true or G.P_CENTERS[card.ability.extra.current].no_collection == true then
				return
			else
				G.GAME.modified_rarities[card.ability.extra.current] = 1
				G.P_CENTERS[card.ability.extra.current].oldrarity = G.P_CENTERS[card.ability.extra.current].rarity
			end
			if G.P_CENTERS[card.ability.extra.current].no_doe == true or G.P_CENTERS[card.ability.extra.current].no_collection == true then
				return
			else
				local center = G.P_CENTERS[card.ability.extra.current]
				local rarity = G.P_CENTERS[card.ability.extra.current].rarity
				print(card.ability.extra.current)
				G.P_CENTERS[card.ability.extra.current].rarity = 1
				SMODS.remove_pool(G.P_JOKER_RARITY_POOLS[rarity], center.key)
				SMODS.insert_pool(G.P_JOKER_RARITY_POOLS[1], center, true)
			end
		end
		if (context.end_of_round and context.main_eval and not context.repetition) or context.forcetrigger then
			local mdollars = G.GAME.dollars
			G.GAME.dollars = 0
			ease_dollars(((mdollars*(mdollars+1))/2))
		end
		if context.joker_main or context.forcetrigger then
			SMODS.calculate_effect ({
				xchips = (to_big(card.ability.extra.xchips)),
			}, card)
		end
	end
}

SMODS.Joker {
	key = "vanaheim", 
	loc_txt = {
		name = {
			"{f:ast_futhark2,s:1.1,C:chips}Vanaheim",
			"{s:0.8}(Vanaheim)"
		},
		text = {
			{
				"While in rightmost {C:attention}Joker{} slot, {C:attention}-1{} Ante when exiting shop",
			},
			{
				"{C:attention}Chips/Mult{} operator is increased by one when first obtained",
				"and every {C:attention}4{} {C:inactive}[#1#]{} {C:attention}Boss Blinds{} defeated",
			},
			-- {
			-- 	"Ante scaling is {C:attention}lowered{}",
			-- }
		}
	},
	pos = { x = 0, y = 3 },
	soul_pos = { x = 1, y = 3, extra = { x = 2, y = 3 } },
	cost = 250, --100 normal, 250 realm, 800 yggdrasil
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = true,
	atlas = "exotic",
	ast_credits = {
		art = {"Tatteredlurker"},
	},
	config = {
		extra = {
			antes_defeated = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.antes_defeated
			}
		}
	end,
	calculate = function(self, card, context)
		if G.jokers.cards[#G.jokers.cards] == card and context.ending_shop or context.forcetrigger then
			ease_ante(-1)
		end
		if context.end_of_round and context.main_eval and G.GAME.blind.boss or context.forcetrigger then
			card.ability.extra.antes_defeated = card.ability.extra.antes_defeated - 1
		end
		if card.ability.extra.antes_defeated == 0 then
			ease_operator(1)
			card.ability.extra.antes_defeated = 4
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if G.GAME.vanaheim_init ~= true then
			ease_operator(1)
			G.GAME.vanaheim_init = true
		end
		-- G.GAME.vanaheim_ante_scaling = true
	end
}

SMODS.Joker {
	key = "asgard", 
	loc_txt = {
		name = {
			"{f:ast_futhark2,s:1.1,C:chips}Asgard",
			"{s:0.8}(Asgard)"
		},
		text = {
			"Gains {C:dark_edition}#2#{} Chip per scored card or joker, caps at {C:dark_edition}#4#{},",
			"When reached, increase operator by one and reset Chips",
			"Joker's scoring effects trigger per card played",
			"{C:inactive}(Currently {X:dark_edition,C:white}#1# {C:inactive} Chips)"
		}
	},
	pos = { x = 6, y = 0 },
	soul_pos = { x = 7, y = 0, extra = { x = 8, y = 0 } },
	cost = 250,
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "exotic",
	ast_credits = {
		art = {"Tatteredlurker"},
	},
	config = {
        extra = {
			chips = 1,
			fakechips = 1e300,
			immutable = {
				arrows = -1,
				chips_mod = 1,
				cap = 100,
			},
        },
    },
	loc_vars = function(self, q, card)
		return {
			vars = {
                ast.FormatArrowMult(card.ability.extra.immutable.arrows, card.ability.extra.chips),
                card.ability.extra.immutable.chips_mod,
				card.ability.extra.immutable.arrows, --??????????
                card.ability.extra.immutable.cap,
            },
		}
	end,
	calculate = function(self, card, context)
		if ((to_big(card.ability.extra.chips)) >= (to_big(card.ability.extra.immutable.cap)) and not context.repetition and not context.blueprint) or context.forcetrigger then
			card.ability.extra.immutable.arrows = (to_big(card.ability.extra.immutable.arrows)) + (to_big(1))
			card.ability.extra.chips = (to_big(1))
		end
		if not context.blueprint and ((context.post_trigger and context.other_joker ~= card) or (context.individual and context.cardarea == G.play)) then --duplicare type beat
			card.ability.extra.chips = lenient_bignum(to_big(card.ability.extra.chips) + card.ability.extra.immutable.chips_mod)
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
		end
		if (context.individual and (to_big(card.ability.extra.immutable.arrows)) <= (to_big(100)) and context.cardarea == G.play) or (context.forcetrigger and (to_big(card.ability.extra.immutable.arrows)) <= (to_big(100))) then
            if to_big(card.ability.extra.immutable.arrows) < to_big(0) then
                    return {
                        chip_mod=card.ability.extra.chips,
                        message = ast.FormatArrowMult(card.ability.extra.immutable.arrows, card.ability.extra.chips) .. ' Chips',
                        colour = G.C.CHIPS,
                    }
            elseif to_big(card.ability.extra.immutable.arrows) < to_big(1) then
                return {
                    Xchip_mod=card.ability.extra.chips,
                    message = ast.FormatArrowMult(card.ability.extra.immutable.arrows, card.ability.extra.chips) .. ' Chips',
                    colour = G.C.CHIPS,
                }
            end
            return {
				hyperchip_mod = {
                    card.ability.extra.immutable.arrows,
                    card.ability.extra.chips
                },
				message =   ast.FormatArrowMult(card.ability.extra.immutable.arrows, card.ability.extra.chips) .. ' Chips',
				colour = { 0.8, 0.45, 0.85, 1 },
			}
		end
		if (context.individual and (to_big(card.ability.extra.immutable.arrows)) > (to_big(100)) and context.cardarea == G.play) or (context.forcetrigger and (to_big(card.ability.extra.immutable.arrows)) > (to_big(100))) then
            if to_big(card.ability.extra.immutable.arrows) < to_big(0) then
                    return {
                        chip_mod=card.ability.extra.chips,
                        message = ast.FormatArrowMult(card.ability.extra.immutable.arrows, card.ability.extra.chips) .. ' Chips',
                        colour = G.C.CHIPS,
                    }
            elseif to_big(card.ability.extra.immutable.arrows) < to_big(1) then
                return {
                    Xchip_mod=card.ability.extra.chips,
                    message = ast.FormatArrowMult(card.ability.extra.immutable.arrows, card.ability.extra.chips) .. ' Chips',
                    colour = G.C.CHIPS,
                }
            end
            return {
				hyperchip_mod = {
                    card.ability.extra.immutable.arrows,
                    card.ability.extra.fakechips
                },
				message =   ast.FormatArrowMult(card.ability.extra.immutable.arrows, card.ability.extra.chips) .. ' Chips',
				colour = { 0.8, 0.45, 0.85, 1 },
			}
		end
	end,
}

SMODS.Joker {
	key = "yggdrasil", 
	loc_txt = {
		name = {
			"{f:ast_futhark2,s:1.1,C:ast_yggdrasil}Yggdrasil",
			"{s:0.8}(Yggdrasil, The World Tree)"
		},
		text = {
			"Increase values of all {C:attention}Jokers{} to the right",
			"by {X:ast_evalues,C:white}#1#{} at end of round and {C:attention}exponentiate{} multiplier",
			"When obtaining a {C:attention}Joker{}, increase operator by one",
		}
	},
	pos = { x = 0, y = 5 },
	soul_pos = { x = 1, y = 5, extra = { x = 2, y = 5 } },
	cost = 800,
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "exotic",
	ast_credits = {
	},
	in_pool = function(self, args)
		return false
	end,
	config = {
		extra = {
			increase = 2,
			immutable = {
				arrows = 0,
			},
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {ast.FormatArrowMult(card.ability.extra.immutable.arrows, card.ability.extra.increase), card.ability.extra.immutable.arrows}
		}
	end,
	calculate = function(self, card, context)
		if (context.end_of_round and not context.repetition and not context.individual and not context.blueprint) or context.forcetrigger then
			local check = false
			local cardind = #G.jokers.cards
			for i=1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					cardind = i
				end
			end
			for i=1, #G.jokers.cards do
				if i > cardind then
					if not Card.no(G.jokers.cards[i], "immutable", true) then
						check = true
						Cryptid.manipulate(G.jokers.cards[i], { value = {arrows = card.ability.extra.immutable.arrows, height = card.ability.extra.increase}, type = "hyper" })
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
			card.ability.extra.increase = (to_big(card.ability.extra.increase))^(to_big(2))
		end
		if context.card_added or context.forcetrigger then
			card.ability.extra.immutable.arrows = (to_big(card.ability.extra.immutable.arrows)) + (to_big(1))
			return {
				message = ("+1"),
				colour = G.C.GREEN,
			}
		end
	end,
}

