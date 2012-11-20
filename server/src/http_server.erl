-module(http_server).
-export([init/3, handle/2, terminate/2]).

% Initialize cowboy handler
init(_Transport, Req, []) ->
    {ok, Req, undefined};

init(_Transport, Req, Something) ->
    io:format("Something is: ~p~n", [Something]),
    {ok, Req, undefined}.

handle(Req, State) ->
    io:format("in handler~n",[]),
    {Method, Req2} = cowboy_req:method(Req),
    io:format("method ~p~n",[Method]),
    {Path, Req3} = cowboy_req:path(Req2),
    io:format("path ~p~n",[Path]),
    {PathInfo, Req4} = cowboy_req:path_info(Req3),
    io:format("path info ~p~n",[PathInfo]),
    {HostInfo, Req5} = cowboy_req:host_info(Req4),
    io:format("host info ~p~n",[HostInfo]),
    {Cookie, ReqA} = cowboy_req:cookies(Req5),
    io:format("cookie ~p~n",[Cookie]),
    %{CookieId, Req7} = cowboy_req:get_cookie_value("id", Req6),
    %io:format("id ~p~n",[CookieId]),
    case Cookie of
        [] ->
            io:format("Cookie Seted??"),
            Ans = cowboy_req:set_resp_cookie(<<"Id">>, <<"32">>, [], ReqA),
            io:format("Cookie Set?  ~p~n",[Ans]),
            Req6 = Ans;
            %io:format("Cookie Set!  ~p:~p~n",[Name,Value]);
        _ ->
            io:format("Cookie already exists...~n"),
            Req6 = ReqA
    end,
    {ok, Req8} = cowboy_req:reply(200, [], <<"Hello world!">>, Req6),
    {ok, Req8, State}.

terminate(_Req, _State) ->
    ok.

