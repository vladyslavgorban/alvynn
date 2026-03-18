-- basic bonus query

SELECT pb.created_at                                          as dttm
     , pb.name                                                as bonus_name
     , pb.bonus_id
     , pb.player_id
     , pb.id                                                  as operation_id
     , case pb.result
           when 1 then 'pending'
           when 2 then 'activated'
           when 3 then 'cancelled'
           when 4 then 'expired'
           when 5 then 'lost'
    end                                                       as bonus_result
     , ROUND(1.0 * pb.base_currency_amount / 100, 2)          as bonus_sum
     , ROUND(1.0 * pb.base_currency_payout / 100, 2)          as bonus_win_sum
     , round(1.0 * pb.base_currency_canceled_payout / 100, 2) as bonus_cancel_sum
FROM public.player_bonuses pb