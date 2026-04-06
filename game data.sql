-- game data query
-- 4/6/2026

select spins.id                          as spin_id
     , spins.player_id
     , spins.currency
     , spins.created_at                  as spint_dttm
     , spins.game_id
     , providers.name                    as provider_name
     , games.name                        as game_name
     , spins.spin_base_currency_amount   as spin_amnt
     , spins.payout_base_currency_amount as win_amnt
from public.spins
         left join public.games
                   on spins.game_id = games.id
         left join public.providers
                   on games.provider_id = providers.id