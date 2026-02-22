SELECT
    pp.id as player_id
    , pp.is_test                                                          test_account
    , pp.country                                                          user_county
    , pp.region as region
    , pp.affiliate_tag
    , pp.email
FROM stealthcasino_player_service.public.players pp