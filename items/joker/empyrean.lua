-- SMODS.Joker {
-- 	key = "", 
-- 	loc_txt = {
-- 		name = "{f:ast_futhark2,s:1.1,C:chips}",
-- 		text = {
-- 		}
-- 	},
-- 	pos = { x = 0, y = 0 },
-- 	soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
-- 	cost = 100,
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
-- 			n = 3, 
-- 			c = false
-- 		},
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {card.ability.extra.n}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 	end,
-- 	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
--     SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

--     if desc_nodes == full_UI_table.main then
--         full_UI_table.name = {
--             {
--                 n = G.UIT.C,
--                 config = { align = "cm", padding = 0.05 },
--                 nodes = {
--                     {
--                         n = G.UIT.R,
--                         config = { align = "cm" },
--                         nodes = full_UI_table.name
--                     },
--                     {
--                         n = G.UIT.R,
--                         config = { align = "cm" },
--                         nodes = {{
--                           n = G.UIT.T,
--                           config = { text = "()", colour = G.C.INACTIVE, scale = (0.4 - 0.004 * #"()") } }
--                     }},
--                 }
--             }
--         }
--     end
-- end
-- }

SMODS.Joker {
	key = "radalingr", 
	loc_txt = {
		name = "{f:ast_futhark2,s:1.1,C:chips}Radalingr",
		text = {
			"At end of round, Joker's {X:mult,C:white}XMult{C:black} becomes {X:dark_edition,C:white}(XMult)! ",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{}{C:inactive} Mult)",
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
	end,
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

    if desc_nodes == full_UI_table.main then
        full_UI_table.name = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = full_UI_table.name
                    },
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = {{
                          n = G.UIT.T,
                          config = { text = "(Radąlingr)", colour = G.C.INACTIVE, scale = (0.4 - 0.004 * #"(Radąlingr)") } }
                    }},
                }
            }
        }
    end
end
}

SMODS.Joker {
	key = "aukatigi", 
	loc_txt = {
		name = "{f:ast_futhark2,s:1.1,C:chips}Aukatigi",
		text = {
			"After scoring, the total chips and mult",
			"replaces the played poker hand's base chips and mult",
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
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

    if desc_nodes == full_UI_table.main then
        full_UI_table.name = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = full_UI_table.name
                    },
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = {{
                          n = G.UIT.T,
                          config = { text = "(Aukatigi)", colour = G.C.INACTIVE, scale = (0.4 - 0.004 * #"(Aukatigi)") } }
                    }},
                }
            }
        }
    end
end
}

SMODS.Joker {
	key = "asgard", 
	loc_txt = {
		name = "{f:ast_futhark2,s:1.1,C:chips}Asgard",
		text = {
			"Gains {C:dark_edition}#2#{} Chip per scored card or joker, caps at {C:dark_edition}#4#{},",
			"When reached, increase operator by one and reset Chips",
			"Joker's scoring effects trigger per card played",
			"{C:inactive}(Currently {X:dark_edition,C:white}#1# {C:inactive} Chips)"
		}
	},
	pos = { x = 6, y = 0 },
	soul_pos = { x = 8, y = 0, extra = { x = 7, y = 0 } },
	cost = 100,
	rarity = 'ast_empyrean',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
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
			chips = 1,
			chips_mod = 1,
            arrows = -1,
			cap = 100,
			fakechips = 1e300,
        },
    },
	loc_vars = function(self, q, card)
		return {
			vars = {
                ast.FormatArrowMult(card.ability.extra.arrows, card.ability.extra.chips),
                card.ability.extra.chips_mod,
				card.ability.extra.arrows, --??????????
                card.ability.extra.cap,
            },
		}
	end,
	calculate = function(self, card, context)
		if ((to_big(card.ability.extra.chips)) >= (to_big(card.ability.extra.cap)) and not context.repetition and not context.blueprint) or context.forcetrigger then
			card.ability.extra.arrows = (to_big(card.ability.extra.arrows)) + (to_big(1))
			card.ability.extra.chips = (to_big(1))
		end
		if not context.blueprint and ((context.post_trigger and context.other_joker ~= card) or (context.individual and context.cardarea == G.play)) then --duplicare type beat
			card.ability.extra.chips = lenient_bignum(to_big(card.ability.extra.chips) + card.ability.extra.chips_mod)
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
		end
		if (context.individual and (to_big(card.ability.extra.arrows)) <= (to_big(100)) and context.cardarea == G.play) or (context.forcetrigger and (to_big(card.ability.extra.arrows)) <= (to_big(100))) then
            if to_big(card.ability.extra.arrows) < to_big(0) then
                    return {
                        chip_mod=card.ability.extra.chips,
                        message = ast.FormatArrowMult(card.ability.extra.arrows, card.ability.extra.chips) .. ' Chips',
                        colour = G.C.CHIPS,
                    }
            elseif to_big(card.ability.extra.arrows) < to_big(1) then
                return {
                    Xchip_mod=card.ability.extra.chips,
                    message = ast.FormatArrowMult(card.ability.extra.arrows, card.ability.extra.chips) .. ' Chips',
                    colour = G.C.CHIPS,
                }
            end
            return {
				hyperchip_mod = {
                    card.ability.extra.arrows,
                    card.ability.extra.chips
                },
				message =   ast.FormatArrowMult(card.ability.extra.arrows, card.ability.extra.chips) .. ' Chips',
				colour = { 0.8, 0.45, 0.85, 1 },
			}
		end
		if (context.individual and (to_big(card.ability.extra.arrows)) > (to_big(100)) and context.cardarea == G.play) or (context.forcetrigger and (to_big(card.ability.extra.arrows)) > (to_big(100))) then
            if to_big(card.ability.extra.arrows) < to_big(0) then
                    return {
                        chip_mod=card.ability.extra.chips,
                        message = ast.FormatArrowMult(card.ability.extra.arrows, card.ability.extra.chips) .. ' Chips',
                        colour = G.C.CHIPS,
                    }
            elseif to_big(card.ability.extra.arrows) < to_big(1) then
                return {
                    Xchip_mod=card.ability.extra.chips,
                    message = ast.FormatArrowMult(card.ability.extra.arrows, card.ability.extra.chips) .. ' Chips',
                    colour = G.C.CHIPS,
                }
            end
            return {
				hyperchip_mod = {
                    card.ability.extra.arrows,
                    card.ability.extra.fakechips
                },
				message =   ast.FormatArrowMult(card.ability.extra.arrows, card.ability.extra.chips) .. ' Chips',
				colour = { 0.8, 0.45, 0.85, 1 },
			}
		end
	end,
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

    if desc_nodes == full_UI_table.main then
        full_UI_table.name = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = full_UI_table.name
                    },
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = {{
                          n = G.UIT.T,
                          config = { text = "(Asgard)", colour = G.C.INACTIVE, scale = (0.4 - 0.004 * #"(Asgard)") } }
                    }},
                }
            }
        }
    end
end
}
