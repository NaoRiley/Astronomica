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
	pos = { x = 0, y = 0 },
	cost = 20,
	rarity = 'cry_epic',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "j_placeholder",
	ast_credits = {
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
			and not card.gone and (next(SMODS.find_card('j_ast_alfheim')) and next(SMODS.find_card('j_ast_vanaheim')) and next(SMODS.find_card('j_ast_asgard'))) then
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
	soul_pos = { x = 2, y = 2, extra = { x = 1, y = 2 } },
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
				"{C:attention}Chips/Mult{} operator is increased by 1 when first obtained",
				"and every {C:attention}8{} {C:inactive}[#1#]{} {C:attention}Boss Blinds{} defeated",
			},
			{
				"Ante scaling is {C:attention}lowered{}",
			}
		}
	},
	pos = { x = 0, y = 0 },
	-- soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
	cost = 250, --100 normal, 250 realm, 800 yggdrasil
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	eternal_compat = true,
	perishable_compat = true,
	immutable = true,
	atlas = "j_placeholder",
	ast_credits = {
	},
	config = {
		extra = {
			antes_defeated = 8,
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
		if G.jokers.cards[#G.jokers.cards] == card and context.ending_shop then
			ease_ante(-1)
		end
		if context.end_of_round and context.main_eval and G.GAME.blind.boss then
			card.ability.extra.antes_defeated = card.ability.extra.antes_defeated - 1
		end
		if card.ability.extra.antes_defeated == 0 then
			G.GAME.ast_operator = G.GAME.ast_operator + 1
			update_operator_display()
			card.ability.extra.antes_defeated = 8
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if G.GAME.vanaheim_init ~= true then
			G.GAME.ast_operator = G.GAME.ast_operator + 1
			update_operator_display()
			G.GAME.vanaheim_init = true
		end
		G.GAME.vanaheim_ante_scaling = true
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
	soul_pos = { x = 8, y = 0, extra = { x = 7, y = 0 } },
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
	pos = { x = 0, y = 0 },
	-- soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
	cost = 800,
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = false,
	atlas = "j_placeholder",
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

