SMODS.Consumable:take_ownership('judgement',
{
    atlas = 'sptarot',
    pos = {x = 0, y = 0},
    use = function(self, card, area, copier)
        if card.edition and card.edition.ast_nil then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card('Joker', G.jokers, nil, 'ast_empyrean', nil, nil, nil, 'jud')
                card:add_to_deck()
                G.jokers:emplace(card)
                return true end }))
            delay(0.6)
            else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'jud')
                card:add_to_deck()
                G.jokers:emplace(card)
                return true end }))
            delay(0.6)
        end
    end,
    update = function(self, card, dt)
        if card.edition and card.edition.ast_nil then
            card.children.center:set_sprite_pos({x = 1, y = 0})
        end
    end,
},
true)

SMODS.Consumable:take_ownership('c_hermit',
{
    atlas = 'sptarot',
    pos = {x = 0, y=1},
    use = function(self, card, area, copier)
        if card.edition and card.edition.ast_nil then
            G.GAME.bankrupt_at = -math.huge
            else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                ease_dollars(math.max(0,math.min(G.GAME.dollars, card.ability.extra)), true)
                return true end }))
            delay(0.6)
        end
    end,
    update = function(self, card, dt)
        if card.edition and card.edition.ast_nil then
            card.children.center:set_sprite_pos({x = 1, y = 1})
        end
    end,
},
true)