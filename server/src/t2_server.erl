-module(t2_server).
-behavior(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start/0,start/1]).

start() ->
    start([]).

start(Opts) ->
  gen_server:start_link(?MODULE, Opts, []).

init(_Opts) ->
    State = {},
    {ok, State}.

handle_call(_Call, _From, State) ->
    Reply = t2_server_called,
    {reply, Reply, State}.

handle_cast(_Cast, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
