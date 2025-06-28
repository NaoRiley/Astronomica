SMODS.Consumable {
    key = 'enshroud',
    set = 'Spectral',
    loc_txt = {
        name = 'Enshroud',
        text = {
			'Flips all selected cards face down',
			'All face down cards for the rest of',
			'the run count as every suit',
			'and cannot be debuffed',
        },
    },
    atlas = 's_placeholder',
    pos = {x = 0, y = 0},
    can_use = function(self, card)
    	return true
	end,
    use = function(self, card, area, copier)
		for _,v in ipairs(G.hand.highlighted) do
		v:flip()
		v.ability.perma_flipped = true
		G.GAME.flip_benefit = true
		end
	end
}

-- SMODS.Consumable {
--     key = 'anomaly',
--     set = 'Spectral',
--     loc_txt = {
--         name = 'Anomaly',
--         text = {
--             'Banish 1 selected consumable and',
-- 			'create an {C:dark_edition}Anomalous{} consumable of the',
-- 			'same type',
--         },
--     },
--     atlas = 'anomaly',
--     pos = {x = 0, y = 0},
-- 	soul_pos = { x = 0, y = 5, },
--     cost = 250,
-- 	hidden = true,
--     soul_rate = 0.01,
--     soul_set = 'Spectral',
--     can_repeat_soul = true,
--     can_use = function(self, card)
-- 		if #G.consumeables.highlighted + ((G.pack_cards and G.pack_cards.highlighted[1] and G.pack_cards.highlighted[1].ability.consumeable and #G.pack_cards.highlighted) or 0) == 2 then --why is there a +, is that an and?
--     		return true
-- 		end
-- 	end,
--     use = function(self, card, area, copier)
-- 		if not G.GAME.banned_keys then
-- 			G.GAME.banned_keys = {}
-- 		end
-- 		if not G.GAME.cry_banned_pcards then
-- 			G.GAME.cry_banned_pcards = {}
-- 		end
-- 		local a = nil
-- 		local c = nil
-- 		if G.consumeables.highlighted[1] then
-- 			a = G.consumeables
-- 			c = G.consumeables.highlighted[1]
-- 		end

-- 		G.GAME.cry_banished_keys[c.config.center.key] = true

-- 		c:start_dissolve()
-- 	end
-- }