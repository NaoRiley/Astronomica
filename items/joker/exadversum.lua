--funny how i have to hardcode every single boss blind

SMODS.Atlas{
	key = 'fallback', --Inverted Blind
	path = 'invertedblinds/fallback.png',
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21,
	px = 34,
	py = 34
}

SMODS.Atlas{
	key = 'vanilla', --Inverted Vanilla
	path = 'invertedblinds/vanilla.png',
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21,
	px = 34,
	py = 34
}

SMODS.Atlas{
	key = 'cry', --Inverted Cryptid
	path = 'invertedblinds/cry.png',
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21,
	px = 34,
	py = 34
}

SMODS.Atlas{
	key = 'nostalgia', --Inverted Nostalgia
	path = 'invertedblinds/inverted.png',
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21,
	px = 34,
	py = 34
}

SMODS.Joker{
    key = 'exadversum',
    loc_txt = {
        name = 'Exadversum',
        text = {
            'Converts all boss blinds into positive variants',
        }
    },
    atlas = 'exotic',
    rarity = 'cry_exotic',
    cost = 50,
    pos = {x = 3, y = 1},
    soul_pos = { x = 5, y = 1, extra = { x = 4, y = 1 } },
    config = {
		extra = {
			active = true
		}
	},
    calculate = function(self, card, context)
        if G.GAME.blind.in_blind and card.ability.extra.active == true then
            card.ability.extra.active = false
            if  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_cry_clock" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iclock"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_ast_shard" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_ishard"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_manacle" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_imanacle"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_wall" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iwall"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_serpent" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iserpent"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_goad" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_igoad"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_head" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_ihead"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_club" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iclub"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_window" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iwindow"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_plant" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iplant"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_arm" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iarm"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_flint" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iflint"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_tooth" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_itooth"])
            elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_pillar" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_ipillar"])
            -- elseif  G.GAME.blind.in_blind and G.GAME.blind.config.blind.key == "bl_cry_box" then
            --     G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_ibox"])
            elseif G.GAME.blind.in_blind and G.GAME.blind.boss
            and G.GAME.blind.config.blind.key ~= "bl_ast_iboss"
            and G.GAME.blind.config.blind.key ~= "bl_entr_endless_entropy_phase_one"
            and G.GAME.blind.config.blind.key ~= "bl_entr_endless_entropy_phase_three"
            and G.GAME.blind.config.blind.key ~= "bl_entr_endless_entropy_phase_two"
            and G.GAME.blind.config.blind.key ~= "bl_entr_endless_entropy_phase_four" then
                G.GAME.blind:set_blind(G.P_BLINDS["bl_ast_iboss"])
            end
        end
        if context.blind_defeated then
            card.ability.extra.active = true
        end
    end
}

-- SMODS.Blind{
--     key = '', -- Inverted
--     loc_txt = {
--         name = '',
--         text = {
--         }
--     },
--     atlas = 'inverted',
--     in_pool = function () end,
--     no_collection = true,
--     pos = {x = 0, y = 0},
-- 	dollars = 5,
-- 	mult = 2,
-- 	boss = {min = 0},
-- 	boss_colour = HEX(''), -- original
-- }

SMODS.Blind{
    key = 'iboss', --Fallback
    loc_txt = {
        name = 'Boss Blind',
        text = {
            'Does nothing'
        }
    },
    atlas = 'fallback',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 0},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('4f6367'), --4f6367 original
}

SMODS.Blind{
    key = 'iclock', --The Clock Inverted
    loc_txt = {
        name = 'The Clock',
        text = {
            '-0.1X blind requirements every',
            '12 seconds spent in this round',
        }
    },
    atlas = 'cry',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 1},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('7acbaa'), --853455 original
    defeat = function(self, silent)
		G.P_BLINDS.bl_cry_clock.mult = 0
	end,
    disable = function(self, silent)
		G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
	end,
	cry_ante_base_mod = function(self, dt)
		if G.SETTINGS.paused then
			return 0
		else
			return -0.1 * (dt * math.min(G.SETTINGS.GAMESPEED, 4) / 4) / 3
		end
	end,
    -- calculate = function(self, blind, context)
    --     blind.children.animatedSprite.scale = { x = blind.children.animatedSprite.atlas.px, y = blind.children.animatedSprite.atlas.py } --dont even try, ok?
    --     if next(SMODS.find_mod('Cryptid')) then
    --         blind.children.animatedSprite.atlas = G.ANIMATION_ATLAS['cry_blinds']
    --         blind.children.animatedSprite.set_sprite_pos({x = 0, y = 1})
    --     end
    -- end,
}

SMODS.Blind{
    key = 'ishard', --The Shard Inverted
    loc_txt = {
        name = 'The Shard',
        text = {
            'Multiplies Score by',
			'1.5 per hand played',
        }
    },
    atlas = 'fallback', --change later
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 0},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('005aff'), --FFA500 original
    calculate = function(self, blind, context)
		if context.after and not G.GAME.blind.disabled then
			G.E_MANAGER:add_event(Event({
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips))*(to_big(1.5))
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('gong')
					return true
				end,
			}))
		end
	end
}

SMODS.Blind{
    key = 'imanacle', --The Manacle Inverted
    loc_txt = {
        name = 'The Manacle',
        text = {
            '+1 Hand Size',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 8},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('a8a8a8'), --575757 original
    defeat = function(self, silent)
		G.hand:change_size(-1)
	end,
    set_blind = function(self)
        G.hand:change_size(2)
    end,
}

SMODS.Blind{
    key = 'iwall', --The Wall Inverted
    loc_txt = {
        name = 'The Wall',
        text = {
            'Extra small blind',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 9},
	dollars = 5,
	mult = 0.25,
	boss = {min = 0},
	boss_colour = HEX('75a65a'), --8a59a5 original
}

SMODS.Blind{
    key = 'iserpent', --The Serpent Inverted
    loc_txt = {
        name = 'The Serpent',
        text = {
            'After Play or Discard,',
            'always draw 8 cards',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 15},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('bc65b0'), --439a4f original
} --effect is in patches

SMODS.Blind{
    key = 'igoad', --The Goad Inverted
    loc_txt = {
        name = 'The Goad',
        text = {
            'All Spade cards',
            'are retriggered',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 13},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('46a369'), --b95c96 original
    calculate = function(self, blind, context)
        if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Spades") then
            return{repetitions = 1}
        end
    end
}

SMODS.Blind{
    key = 'ihead', --The Head Inverted
    loc_txt = {
        name = 'The Head',
        text = {
            'All Heart cards',
            'are retriggered',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 21},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('53624b'), --ac9db4 original
    calculate = function(self, blind, context)
        if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
            return{repetitions = 1}
        end
    end
}

SMODS.Blind{
    key = 'iclub', --The Club Inverted
    loc_txt = {
        name = 'The Club',
        text = {
            'All Club cards',
            'are retriggered',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 4},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('46346d'), --b9cb92 original
    calculate = function(self, blind, context)
        if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
            return{repetitions = 1}
        end
    end
}

SMODS.Blind{
    key = 'iwindow', --The Window Inverted
    loc_txt = {
        name = 'The Window',
        text = {
            'All Diamond cards',
            'are retriggered',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 6},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('565d6a'), --a9a295 original
    calculate = function(self, blind, context)
        if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            return{repetitions = 1}
        end
    end
}

SMODS.Blind{
    key = 'iplant', --The Plant Inverted
    loc_txt = {
        name = 'The Plant',
        text = {
            'All Face cards',
            'are retriggered',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 19},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('8f6d7b'), --709284 original
    calculate = function(self, blind, context)
        if context.repetition and context.cardarea == G.play and context.other_card:is_face() then
            return{repetitions = 1}
        end
    end
}

SMODS.Blind{
    key = 'iarm', --The Arm Inverted
    loc_txt = {
        name = 'The Arm',
        text = {
            'Increase level of',
            'played poker hand',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 11},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('979a0c'), --6865f3 original
    debuff_hand = function(self, cards, hand, handname, check)
        if true then
            self.triggered = true
            if not check then
            SMODS.calculate_effect({level_up = true})
            end
        end
    end
}

SMODS.Blind{
    key = 'iflint', --The Flint Inverted
    loc_txt = {
        name = 'The Flint',
        text = {
            'Base Chips and',
            'Mult are doubled',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 24},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('1a95d0'), --e56a2f original
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		if (to_big(mult) == to_big(0)) and (to_big(hand_chips) == to_big(0)) then
			G.GAME.blind.triggered = true
			return mult, hand_chips, false
		end
        G.GAME.blind.triggered = true
        return to_big(mult*2), to_big(hand_chips*2), true
	end,
}

SMODS.Blind{
    key = 'itooth', --The Tooth Inverted
    loc_txt = {
        name = 'The Tooth',
        text = {
            'Gain $1 per',
            'card scored',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 22},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('4ad2d2'), --b52d2d original
    calculate = function(self, blind, context)
        if context.individual and context.cardarea == G.play then
            ease_dollars(1)
        end
    end
}

SMODS.Blind{
    key = 'ipillar', --The Pillar Inverted
    loc_txt = {
        name = 'The Pillar',
        text = {
            'Cards played previously',
            'this Ante are retriggered',
        }
    },
    atlas = 'vanilla',
    in_pool = function () end,
    no_collection = true,
    pos = {x = 0, y = 16},
	dollars = 5,
	mult = 2,
	boss = {min = 0},
	boss_colour = HEX('8198ad'), --7e6752 original
    calculate = function(self, blind, context)
        if context.repetition and context.cardarea == G.play and context.other_card.ability.played_this_ante then
            return{repetitions = 1}
        end
    end
}

-- SMODS.Blind{
--     key = 'ipsychic', --The Psychic Inverted
--     loc_txt = {
--         name = 'The Psychic',
--         text = {
--             'n? to all played cards if', --formula: (to_big(n)*(to_big(n)+1)/2), might change to ^2 instead depending on balancing
--             'played hand contains 5 cards',
--         }
--     },
--     atlas = 'vanilla',
--     in_pool = function () end,
--     no_collection = true,
--     pos = {x = 0, y = 12},
-- 	dollars = 5,
-- 	mult = 2,
-- 	boss = {min = 0},
-- 	boss_colour = HEX('103fc3'), --efc03c original
--     calculate = funtion(self, blind, context)
--         if context.full_hand[5] then

-- }

-- SMODS.Blind{
--     key = 'ibox', --The Box Inverted
--     loc_txt = {
--         name = 'The Box',
--         text = {
--             'All Common Jokers',
--             'are retriggered',
--         }
--     },
--     atlas = 'cry',
--     in_pool = function () end,
--     no_collection = true,
--     pos = {x = 0, y = 8},
-- 	dollars = 5,
-- 	mult = 2,
-- 	boss = {min = 0},
-- 	boss_colour = HEX('77c5c4'), --883a3b original
--     calculate = function(self, card, context)
-- 		if context.retrigger_joker_check and not context.retrigger_joker then
-- 			if card.config.center.rarity == 1 then
-- 				return {
-- 					message = localize("k_again_ex"),
-- 					repetitions = 1,
-- 					card = card,
-- 				}
-- 			else
-- 				return nil, true
-- 			end
-- 		end
-- 	end,
-- }
