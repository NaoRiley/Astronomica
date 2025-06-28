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
				func = function ()
					ast.mod_score({hyper = 2, card.ability.extra.score})
				end,
				message = ("^^")..card.ability.extra.score..(" Score"),
				colour = G.C.PURPLE,
			}
		end
	end
}

SMODS.Joker{
    key = 'congruentia',
    loc_txt = {
        name = 'Congruentia',
        text = {
            'When {C:chips}Chips{} or {C:mult}Mult{} are increased',
			'both are set to the {C:attention}higher{} value'
        }
    },
    atlas = 'exotic',
    rarity = 'cry_exotic',
    cost = 50,
    pos = {x = 3, y = 2},
    soul_pos = { x = 5, y = 2, extra = { x = 4, y = 2 } },
    display_size = { w = 71 * 1.4, h = 95 * 1.4 },
    config = {
		extra = {
		}
	},
}

-- SMODS.Joker{
--     key = 'ignominiosa',
--     loc_txt = {
--         name = 'Ignominiosa',
--         text = {
-- 			'Decreases rarity of 1 random Joker',
-- 			'in collection by 1 per reroll',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	-- soul_pos = { x = 0, y = 0, extra = { x = 0, y = 0 } },
-- 	blueprint_compat = true,
-- 	demicoloncompat = true,
-- 	cost = 50,
-- 	rarity = 'cry_exotic',
-- 	config = {
-- 		extra = {
-- 			current = nil,
-- 		}
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {card.ability.extra.current}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 		if context.reroll_shop then
-- 			local center = G.P_CENTERS[card.ability.extra.current]
-- 			card.ability.extra.current = pseudorandom_element(G.P_CENTER_POOLS.Joker, pseudoseed("seed")).key
-- 			-- print(card.ability.extra.current)
-- 			if G.P_CENTERS[card.ability.extra.current].rarity == 'ast_empyrean' then --if empyrean then exotic
-- 				G.P_CENTERS[card.ability.extra.current].rarity = 'cry_exotic'
-- 				for i, v in ipairs(G.P_JOKER_RARITY_POOLS['ast_empyrean']) do if v == center then table.remove(G.P_JOKER_RARITY_POOLS['ast_empyrean'], i) break end end
-- 				G.P_JOKER_RARITY_POOLS['cry_exotic'][card.ability.extra.current] = center
-- 			elseif G.P_CENTERS[card.ability.extra.current].rarity == 'entr_entropic' then --if entropic then exotic
-- 				G.P_CENTERS[card.ability.extra.current].rarity = 'cry_exotic'
-- 				for i, v in ipairs(G.P_JOKER_RARITY_POOLS['entr_entropic']) do if v == center then table.remove(G.P_JOKER_RARITY_POOLS['entr_entropic'], i) break end end
-- 				G.P_JOKER_RARITY_POOLS['cry_exotic'][card.ability.extra.current] = center
-- 			elseif G.P_CENTERS[card.ability.extra.current].rarity == 'cry_exotic' then --if exotic then legendary
-- 				G.P_CENTERS[card.ability.extra.current].rarity = 4
-- 				for i, v in ipairs(G.P_JOKER_RARITY_POOLS['cry_exotic']) do if v == center then table.remove(G.P_JOKER_RARITY_POOLS['cry_exotic'], i) break end end
-- 				G.P_JOKER_RARITY_POOLS[4][card.ability.extra.current] = center
-- 			elseif G.P_CENTERS[card.ability.extra.current].rarity == 4 then --if legendary then epic
-- 				G.P_CENTERS[card.ability.extra.current].rarity = 'cry_epic'
-- 				for i, v in ipairs(G.P_JOKER_RARITY_POOLS[4]) do if v == center then table.remove(G.P_JOKER_RARITY_POOLS[4], i) break end end
-- 				G.P_JOKER_RARITY_POOLS['cry_epic'][card.ability.extra.current] = center
-- 			elseif G.P_CENTERS[card.ability.extra.current].rarity == 'cry_epic' then --if epic then rare
-- 				G.P_CENTERS[card.ability.extra.current].rarity = 3
-- 				for i, v in ipairs(G.P_JOKER_RARITY_POOLS['cry_epic']) do if v == center then table.remove(G.P_JOKER_RARITY_POOLS['cry_epic'], i) break end end
-- 				G.P_JOKER_RARITY_POOLS[3][card.ability.extra.current] = center
-- 			elseif G.P_CENTERS[card.ability.extra.current].rarity == 3 then --if rare then uncommon
-- 				G.P_CENTERS[card.ability.extra.current].rarity = 2
-- 				for i, v in ipairs(G.P_JOKER_RARITY_POOLS[3]) do if v == center then table.remove(G.P_JOKER_RARITY_POOLS[3], i) break end end
-- 				G.P_JOKER_RARITY_POOLS[2][card.ability.extra.current] = center
-- 			elseif G.P_CENTERS[card.ability.extra.current].rarity == 2 then --if uncommon then common
-- 				G.P_CENTERS[card.ability.extra.current].rarity = 1
-- 				for i, v in ipairs(G.P_JOKER_RARITY_POOLS[2]) do if v == center then table.remove(G.P_JOKER_RARITY_POOLS[2], i) break end end
-- 				G.P_JOKER_RARITY_POOLS[1][card.ability.extra.current] = center
-- 			end
-- 		end
-- 	end
-- }

-- SMODS.Joker{
--     key = 'ignominiosa',
--     loc_txt = {
--         name = 'Ignominiosa',
--         text = {
-- 			'Decreases rarity of #1# random Joker',
-- 			'in collection by 1 per reroll',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	-- soul_pos = { x = 0, y = 0, extra = { x = 0, y = 0 } },
-- 	blueprint_compat = true,
-- 	demicoloncompat = true,
-- 	cost = 50,
-- 	rarity = 'cry_exotic',
-- 	config = {
-- 		extra = {
-- 			downgrades = 1,
-- 		}
-- 	},
--     loc_vars = function(self, info_queue, card)
--         return {vars = {card.ability.extra.downgrades}}
--     end,
-- 	calculate = function(self, card, context)
        
--         if (context.reroll_shop and not context.blueprint and not context.individual and not context.repetition) then


--             for mostlyuselessiterationvariable = 1, card.ability.extra.downgrades do
--                 local candidates = {}
--                 local order = {1, 2, 3, "cry_epic", 4, "cry_exotic", "entr_entropic", "ast_empyrean"}
--                 local names = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Exotic", "Entropic", "Empyrean"}
--                 for i, center in pairs(G.P_CENTERS) do
--                     if center.rarity and table:astcontains(order, center.rarity) then
--                         table.insert(candidates, {index = i, cen = center})
--                     end
--                 end
--                 if #candidates > 0 then
--                     local chosen = candidates[math.random(#candidates)]
--                     print("Downgrading " .. chosen.cen.key)
--                     print("was " .. chosen.cen.rarity)

--                     local current_rarity = chosen.cen.rarity
                    
--                     local idx = nil
--                     for i, v in ipairs(order) do
--                         if v == current_rarity then
--                             idx = i
--                             break
--                         end
--                     end
--                     local new_rarity = order[idx-1]

--                     if idx and idx > 1 then
--                         local pool = G.P_JOKER_RARITY_POOLS[chosen.cen.rarity]
--                         for idx = #pool, 1, -1 do
--                             if pool[idx] == chosen.index then
--                                 table.remove(pool, idx)
--                                 break
--                             end
--                         end

--                         if not (G.P_CENTERS[chosen.index].oldrarity) then
--                             G.P_CENTERS[chosen.index].oldrarity = G.P_CENTERS[chosen.index].rarity
--                         end

--                         G.P_CENTERS[chosen.index].rarity = order[idx-1]
--                         G.P_JOKER_RARITY_POOLS[new_rarity][chosen.index] = chosen.cen
                        
--                     end
                
--                 end
--             end
            
--         end

--     end,
-- 	ast_credits = {
-- 		code = {"vallariacat"},
-- 	},
-- } 

-- SMODS.Joker{
--     key = 'ignominiosa',
--     loc_txt = {
--         name = 'Ignominiosa',
--         text = {
-- 			'Decreases rarity of #1# random Joker',
-- 			'in collection by 1 per reroll',
--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	-- soul_pos = { x = 0, y = 0, extra = { x = 0, y = 0 } },
-- 	blueprint_compat = true,
-- 	demicoloncompat = true,
-- 	cost = 50,
-- 	rarity = 'cry_exotic',
-- 	config = {
-- 		extra = {
-- 			downgrades = 1,
-- 		}
-- 	},
--     loc_vars = function(self, info_queue, card)
--         return {vars = {card.ability.extra.downgrades}}
--     end,
-- 	calculate = function(self, card, context)
        
--         if (context.reroll_shop and not context.blueprint and not context.individual and not context.repetition) then


--             for mostlyuselessiterationvariable = 1, card.ability.extra.downgrades do
--                 local candidates = {}
--                 local conversions = {
-- 					{base='ast_empyrean', new='cry_exotic'},
-- 					{base='cry_exotic', new=4},
-- 					{base=4, new='cry_epic'},
-- 					{base='cry_epic', new=3},
-- 					{base=3, new=2},
-- 					{base=2, new=1},
-- 				}
--                 for i, center in pairs(G.P_CENTERS) do
--                     if center.rarity and table:astcontains(order, center.rarity) then
--                         table.insert(candidates, {index = i, cen = center})
--                     end
--                 end
--                 if #candidates > 0 then
--                     local chosen = candidates[math.random(#candidates)]
--                     print("Downgrading " .. chosen.cen.key)
--                     print("was " .. chosen.cen.rarity)

--                     local current_rarity = chosen.cen.rarity
                    
--                     local idx = nil
--                     for i, v in ipairs(order) do
--                         if v == current_rarity then
--                             idx = i
--                             break
--                         end
--                     end
--                     local new_rarity = order[idx-1]

--                     if idx and idx > 1 then
--                         local pool = G.P_JOKER_RARITY_POOLS[chosen.cen.rarity]
--                         for idx = #pool, 1, -1 do
--                             if pool[idx] == chosen.index then
--                                 table.remove(pool, idx)
--                                 break
--                             end
--                         end

--                         if not (G.P_CENTERS[chosen.index].oldrarity) then
--                             G.P_CENTERS[chosen.index].oldrarity = G.P_CENTERS[chosen.index].rarity
--                         end

--                         G.P_CENTERS[chosen.index].rarity = order[idx-1]
--                         G.P_JOKER_RARITY_POOLS[new_rarity][chosen.index] = chosen.cen
                        
--                     end
                
--                 end
--             end
            
--         end

--     end,
-- 	ast_credits = {
-- 		code = {"vallariacat"},
-- 	},
-- } 

-- SMODS.Joker{
--     key = 'dtest',
--     loc_txt = {
--         name = 'dtest',
--         text = {
-- 			'When Blind is selected, disable',
-- 			'Chips or Mult',
-- 			'If Chips disabled, Mult!',
-- 			'If Mult disabled, Chips!',
--         }
--     },
--     atlas = 'j_placeholder',
--     rarity = 'cry_exotic',
--     cost = 50,
--     pos = {x = 0, y = 0},
--     soul_pos = { x = 0, y = 0, extra = { x = 0, y = 0 } },
--     config = {
-- 		extra = {
-- 			disable = nil,
-- 		}
-- 	},
-- 	calculate = function(self, card, context)
-- 		if context.setting_blind then
-- 			card.ability.extra.disable = pseudorandom("chipsmultdisable", 1, 2)
-- 			if (to_big(card.ability.extra.disable)) == (to_big(1)) then
-- 				disable_chips()
-- 			elseif (to_big(card.ability.extra.disable)) == (to_big(2)) then
-- 				disable_mult()
-- 			end
-- 		end
-- 		if context.joker_main then
-- 			if (to_big(card.ability.extra.disable)) == (to_big(1)) then
-- 				SMODS.calculate_effect({
-- 					fmult = 1,
-- 				}, card)
-- 			elseif (to_big(card.ability.extra.disable)) == (to_big(2)) then
-- 				SMODS.calculate_effect({
-- 					fchips = 1,
-- 				}, card)
-- 			end
-- 		end
-- 		if context.blind_defeated then
-- 			enable_chips()
-- 			enable_mult()
-- 		end
-- 	end
-- }

-- SMODS.Joker:take_ownership("cry_gemino", {
-- 	immutable = false,
--     loc_txt = {
--         name = 'Gemini',
--         text = {
-- 			"Increase values of {C:attention}Joker{} to the left",
-- 			"by {C:attention}X#1#{} at end of round",
--         }
--     },
-- 	config = { extra = { increase = 2 } },
-- 	loc_vars = function(self, info_queue, card)
-- 		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
-- 		card.ability.blueprint_compat_check = nil
-- 		return {
-- 			vars = { number_format(card.ability.extra.increase) },
-- 			main_end = (card.area and card.area == G.jokers) and {
-- 				{
-- 					n = G.UIT.C,
-- 					config = { align = "bm", minh = 0.4 },
-- 					nodes = {
-- 						{
-- 							n = G.UIT.C,
-- 							config = {
-- 								ref_table = card,
-- 								align = "m",
-- 								colour = G.C.JOKER_GREY,
-- 								r = 0.05,
-- 								padding = 0.06,
-- 								func = "blueprint_compat",
-- 							},
-- 							nodes = {
-- 								{
-- 									n = G.UIT.T,
-- 									config = {
-- 										ref_table = card.ability,
-- 										ref_value = "blueprint_compat_ui",
-- 										colour = G.C.UI.TEXT_LIGHT,
-- 										scale = 0.32 * 0.8,
-- 									},
-- 								},
-- 							},
-- 						},
-- 					},
-- 				},
-- 			} or nil,
-- 		}
-- 	end,
-- 	update = function(self, card, front)
-- 		if G.STAGE == G.STAGES.RUN then
-- 			for i = 1, #G.jokers.cards do
-- 				if G.jokers.cards[i] == card then
-- 					other_joker = G.jokers.cards[i - 1]
-- 				end
-- 			end
-- 			if other_joker and other_joker ~= card and not (Card.no(other_joker, "immutable", true)) then
-- 				card.ability.blueprint_compat = "compatible"
-- 			else
-- 				card.ability.blueprint_compat = "incompatible"
-- 			end
-- 		end
-- 	end,
--     calculate = function(self, card, context)
-- 		if
-- 			(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
-- 			or context.forcetrigger
-- 		then
-- 			local check = false
-- 			for i = 1, #G.jokers.cards do
-- 				if G.jokers.cards[i] == card then
-- 					if i < #G.jokers.cards then
-- 						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
-- 							check = true
-- 							Cryptid.manipulate(G.jokers.cards[i - 1], { value = card.ability.extra.increase })
-- 						end
-- 					end
-- 				end
-- 			end
-- 			if check then
-- 				card_eval_status_text(
-- 					card,
-- 					"extra",
-- 					nil,
-- 					nil,
-- 					nil,
-- 					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
-- 				)
-- 			end
-- 		end
-- 	end,
-- })
-- local incrementum = {
-- 	dependencies = {
-- 		items = {
-- 			"c_cry_gateway",
-- 			"set_cry_exotic",
-- 		},
-- 	},
-- 	object_type = "Joker",
-- 	name = "cry-Incrementum",
-- 	key = "incrementum",
-- 	pos = { x = 0, y = 1 },
-- 	-- soul_pos = { x = 0, y = 0, extra = { x = 0, y = 0 } },
-- 	-- config = {
-- 	-- 	extra = {
-- 	-- 	},
-- 	-- },
-- 	rarity = "cry_exotic",
-- 	cost = 50,
-- 	order = 519,
-- 	atlas = "placeholders",
-- 	demicoloncompat = true,
-- 	-- loc_vars = function(self, info_queue, center)
-- 	-- end,
-- 	calculate = function(self, card, context)
-- 		if context.cry_pre_scoring then
-- 			if (to_big(mult)) >= (to_big(150)) then
-- 				mult = collatz_factorial(mult)
-- 				update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
-- 			else
-- 				mult = exact_factorial(mult)
-- 				update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})	
-- 			end
-- 		end
-- 	end,
-- 	cry_credits = {
-- 		idea = { "DiabolicalGod" },
-- 		-- art = { "" },
-- 		code = { "NaoRiley" },
-- 	},
-- }