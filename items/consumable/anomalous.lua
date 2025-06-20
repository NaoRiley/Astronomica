-- SMODS.ObjectType = {
--   key = "anomalous",
--   default = "j_joker",
-- }

SMODS.ConsumableType {
    key = 'anomalous',
    default = 'j_joker',
    primary_colour = G.C.DARK_EDITION, --why does this exist
    secondary_colour = G.C.DARK_EDITION, 
    loc_txt = {
        name = 'Anomalous',
        collection = 'Anomalous Cards',
    },
}

SMODS.Consumable {
    key = 'semiconductor',
    set = 'anomalous',
    loc_txt = {
        name = 'Semiconductor',
        text = {
            'Increase operator of scoring effects on',
            '1 selected Joker',
        },
    },
    atlas = 's_placeholder',
    pos = {x = 0, y = 0},
    cost = 0,
}