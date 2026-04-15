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
where 1 = 1
  and spins.finished_at is not null
;

-- game data query aggregated by date
-- 4/6/2026

select spins.player_id
     , spins.currency
     , spins.created_at :: date                            as spin_date
     , spins.game_id
--      , providers.name                         as provider_name
--      , games.name                             as game_name
     , count(distinct spins.id)                            as spins_cnt
     , sum(1.00 * spins.spin_base_currency_amount / 100)   as spin_amnt
     , sum(1.00 * spins.payout_base_currency_amount / 100) as win_amnt
from public.spins
--          left join public.games
--                    on spins.game_id = games.id
--          left join public.providers
--                    on games.provider_id = providers.id
where 1 = 1
  and spins.finished_at is not null
group by 1, 2, 3, 4