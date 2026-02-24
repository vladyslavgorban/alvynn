SELECT
                         pi.created_at                                                       transaction_dttm
                       , pi.player_id
                       , pi.id                                                               invoice_id
                       , CASE
                             WHEN pi.type IN (1, 4) AND pi.number = 1 AND pi.status = 2
                                 THEN pi.created_at
                             END                                                          AS fd_dttm
                       , CASE WHEN pi.type IN (1, 4) AND pi.status = 2 THEN pi.number END AS deposit_number
--                        , pp.is_test                                                          test_account
--                        , pp.country                                                          user_county
--                        , pp.affiliate_tag
                       , ppm.method_name                                                  AS pay_method
                       , CASE
                             WHEN pi.type IN (1, 4) THEN 'deposit'
                             WHEN pi.type IN (2, 5) THEN 'withdrowal'
                             ELSE pi.type :: VARCHAR
                             END                                                          AS transaction_type
                       , CASE
                             WHEN pi.status = 2 THEN 'success'
                             WHEN pi.status != 1 AND
                                  COALESCE(pi.status_result, '') NOT IN
                                  ('Cancelled by Timeout', 'Cancelled by Customer')
                                 THEN 'Failed'
                             WHEN pi.status = 1 THEN 'pending'
                             ELSE
                                 'status: ' || pi.status :: VARCHAR ||
                                 ' (' || COALESCE(pi.status_result, 'no details') || ')'
                             END                                                          AS transaction_status
                       , ppd.payment_provider
                       , ppd.payment_method                                                  provider_pay_method
                       , pi.currency
                       , pi.1.0*base_currency_amount/100 base_currency_amount
                       , pi.base_currency
                     FROM stealthcasino_payment_service.public.invoices pi
                              --                               LEFT JOIN stealthcasino_player_service.public.players pp
--                                         ON pp.id = pi.player_id
                              LEFT JOIN stealthcasino_payment_service.public.payment_methods ppm
                                        ON ppm.id = pi.payment_method_id
                              LEFT JOIN stealthcasino_payment_service.public.payment_details ppd
                                        ON ppd.id = pi.payment_details_id
                            LEFt JOIN 

                                        ;

