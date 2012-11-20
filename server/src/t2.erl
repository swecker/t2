-module(t2).
-export([start/0,start/1,stop/0]).


start() ->
    start(8080).

start(Port) ->
    ok = application:start(crypto),
    ok = application:start(ranch),
    ok = application:start(cowboy),
    {ok, Game} = t2_server:start(),
    Dispatch = [
        {'_', [
            {'_', http_server, [Game]}
        ]}
    ],
    {ok, _} = cowboy:start_http(http, 100, [{port, Port}], [
        {dispatch, Dispatch}
    ]).

stop() ->
    ok.
