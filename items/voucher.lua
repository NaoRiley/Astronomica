-- SMODS.Voucher{
--     key = 'test',
--     loc_txt = {
--         name = 'Test',
--         text = 'Placeholder',
--     },
--     atlas = 'v_placeholder',
--     pos = { x = 0, y = 0 },
--     cost = 10,
-- }

-- local _reroll_shop = G.FUNCS.reroll_shop
-- function G.FUNCS.reroll_shop(e) 
--     _reroll_shop(e)

--     if G and G.GAME and G.GAME.used_vouchers['v_ast_test'] == true then
--         for i = #G.shop_booster.cards,1, -1 do
--             local c = G.shop_booster:remove_card(G.shop_booster.cards[i])
--             c:remove()
--             c = nil
--         end
        
--         for i = 1, 2 do
--             G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
--             local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
--             G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[i]], {bypass_discovery_center = true, bypass_discovery_ui = true})
--             create_shop_card_ui(card, 'Booster', G.shop_booster)
--             card.ability.booster_pos = i
--             card:start_materialize()
--             G.shop_booster:emplace(card)
--         end
--     end
-- end

