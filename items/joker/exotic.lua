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
				message = "^^" .. tostring(card.ability.extra.score),
				colour = G.C.PURPLE
			}
		end
	end
}