SMODS.Consumable {
    key = 'anomaly',
    set = 'Spectral',
    loc_txt = {
        name = 'Anomaly',
        text = {
            'Permeate your earthly poessions',
			'with {C:dark_edition}Anomalous {C:black}power',
        },
    },
    atlas = 'spectral',
    pos = {x = 0, y = 0},
    cost = 250,
	hidden = true,
    soul_rate = 0,
    soul_set = 'Spectral',
    can_repeat_soul = true,
	-- in_pool =  function(self, args)
	-- 	return to_big(G.GAME.round_resets.ante) > to_big(8) --only appears after ante 8
	-- end,
    frames = 2,
    dt = 0,
    dt_r = 1,
    can_use = function(self, card)
		if #G.consumeables.highlighted + ((G.pack_cards and G.pack_cards.highlighted[1] and G.pack_cards.highlighted[1].ability.consumeable and #G.pack_cards.highlighted) or 0) == 2 then
    		return true
		end
	end,
    use = function(self, card, area, copier)
		local used_consumable = copier or card
		for i = 1, #G.consumeables.highlighted do
			local highlighted = G.consumeables.highlighted[i]
			if highlighted ~= card then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						highlighted:juice_up(0.3, 0.5)
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						if highlighted then
                            highlighted:set_edition({ ast_nil = true })
						end
						return true
					end,
				}))
				delay(0.5)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
			end
		end
	end,
}

-- SMODS.Consumable {
--     key = 'anomaly',
--     set = 'Spectral',
--     loc_txt = {
--         name = 'Anomaly',
--         text = {
--             'Permeate your earthly poessions',
-- 			'with {C:dark_edition}Anomalous {C:black}power',
--         },
--     },
--     atlas = 'spectral',
--     pos = {x = 0, y = 0},
--     cost = 250,
-- 	hidden = true,
--     soul_rate = 0.2,
--     soul_set = 'Spectral',
--     can_repeat_soul = true,
-- 	config = {
--         select = 1
--     },
-- 	in_pool =  function(self, args)
-- 		return to_big(G.GAME.round_resets.ante) > to_big(8) --only appears after ante 8
-- 	end,
--     frames = 2,
--     dt = 0,
--     dt_r = 1,
--     loc_vars = function(self, info_queue, center)
-- 		if not center.edition or (center.edition and not center.edition.ast_nil) then
-- 			info_queue[#info_queue + 1] = G.P_CENTERS.e_ast_nil
-- 		end
-- 		return { vars = { center.ability.max_highlighted, card.ability.select } }
-- 	end,
--     can_use = function(self, card)
-- 		if card.area ~= G.domain then
-- 			return #G.hand.highlighted + #G.consumeables.highlighted == 2
-- 		else
-- 			local idx = 1
-- 			if G.hand.highlighted[1] == card then
-- 				idx = 2
-- 			end
-- 			return (#G.consumeables.highlighted == 2) and not G.consumeables.highlighted[idx].edition
-- 		end
-- 	end,
--     use = function(self, card, area, copier)
-- 		local used_consumable = copier or card
-- 		for i = 1, #G.consumeables.highlighted do
-- 			local highlighted = G.consumeables.highlighted[i]
-- 			if highlighted ~= card then
-- 				G.E_MANAGER:add_event(Event({
-- 					func = function()
-- 						play_sound("tarot1")
-- 						highlighted:juice_up(0.3, 0.5)
-- 						return true
-- 					end,
-- 				}))
-- 				G.E_MANAGER:add_event(Event({
-- 					trigger = "after",
-- 					delay = 0.1,
-- 					func = function()
-- 						if highlighted then
--                             highlighted:set_edition({ ast_nil = true })
-- 						end
-- 						return true
-- 					end,
-- 				}))
-- 				delay(0.5)
-- 				G.E_MANAGER:add_event(Event({
-- 					trigger = "after",
-- 					delay = 0.2,
-- 					func = function()
-- 						G.hand:unhighlight_all()
-- 						return true
-- 					end,
-- 				}))
-- 			end
-- 		end
-- 	end,
--     update = function(self, card, dt)
--         if self.dt and self.frames and self.dt_r then
--             self.dt = self.dt + .05
--             if self.dt > self.dt_r then
--                 self.dt = 0
--                 self.pos.x = self.pos.x + 1
--                 if self.pos.x > self.frames-1 then
--                     self.pos.x = 0
--                 end
--                 card.children.center:set_sprite_pos(self.pos)
--             end
--         end
--     end,
-- }
