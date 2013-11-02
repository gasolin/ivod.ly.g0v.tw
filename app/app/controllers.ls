poptext = (paper, text, color, size, ms) ->
  paper.text 30, Math.floor(Math.random!*300), text
    .attr {'font-size': size, 'fill': color}
    .animate {x: 2*paper.width}, ms

angular.module 'app.controllers' <[ng app.cinema]>
.run <[$rootScope]> ++ ($rootScope) ->
.controller AppCtrl: <[$scope $location $rootScope]> ++ (s, $location, $rootScope) ->

  s <<< {$location}
  s.$watch '$location.path()' (activeNavId or '/') ->
    s <<< {activeNavId}

  s.getClass = (id) ->
    if s.activeNavId.substring 0 id.length is id
      'active'
    else
      ''

.controller About: <[$rootScope $http]> ++ ($rootScope, $http) ->
    $rootScope.activeTab = \about

.controller Danmaku: <[$scope DanmakuStore $timeout]> ++ ($scope, DanmakuStore, $timout) ->

  $scope.comments = []
  player = $ \#cinema-player
  {left: x, top: y} = player.offset!
  paper = Raphael x, y, player.width!, player.height! - 30

  $scope.$on 'danmaku_added', (ev, danmaku)->
    now = new Date! .getTime! - 1000
    console.log now
    if danmaku.type == \content && danmaku.timestamp >= now
      $scope.comments.push danmaku
      poptext paper, danmaku.text, '#888', 30, 5000

  $scope.addComment = ->
    timestamp = new Date! .getTime!
    created_at = new Date! .getTime!
    DanmakuStore.store $scope.current-video-id, {text: $scope.newComment, timestamp: timestamp, created_at: created_at, type: \content} 

.controller vlist: <[$scope $http]> ++ ($scope, $http) ->
  $scope.blah = "hello world"
.controller mlylist: <[$scope $http]> ++ ($scope, $http) ->
  $scope.blah = "hello world"

.controller EggNinja: <[$scope]> ++ ($scope) ->
  player = $ \#cinema-player
  crosshair = $ \#crosshair
  egg = $ \#egg
  [w,h] = [player.width!, player.height!]
  {top:y, left: x} = player.offset!
  eggninja = $ \#eggninja
  eggninja.offset {top: y, left: x}
  eggninja.css  width: "#{w}px", height: "#{h - 30}px"
  eggninja.on \click (e) ->
    {clientX: mx, clientY: my} = e
    type = <[egg shoe melon]>[parseInt(Math.random!*4)]
    sy = $(document.body)scrollTop!
    [ww, wh] = [$(document.body)width!, $(window)height!]
    [ex, ey] = [if Math.random!>0.5 => ww else 0, my + parseInt((wh - my ) / 2)]

    egg = $ \<div></div>
    egg.addClass "rotate egg"
    egg.css \background-image, "url(/img/#{type}.png)"
    $ document.body .append egg
    egg.offset left: ex - 50, top: ey - 50 + sy .animate left: mx - 50, top: my - 50 + sy
      ..animate left: mx - 50, top: my + 50 + sy
      ..fadeOut!

  eggninja.on \mousemove (e) ->
    {clientX: mx, clientY: my} = e
    sy = $(window)scrollTop!
    player.parent!parent!parent!trigger \mousemove
    crosshair.offset top: my - 100 + sy, left: mx - 100

  $scope.raise-net = (e) ->
    {top:y, left: x} = player.offset!
    [w, h] = [player.width!, player.height!]
    egg = $ \<div></div>
    egg.addClass \raise-net
    $ document.body .append egg
    egg.offset left: x, top: y + h  .animate top: y  .delay 500 .fadeOut!

  $scope.objection = (e, type) ->
    player.removeClass \saturate
    {top:y, left: x} = player.offset!
    setTimeout (-> player.addClass \saturate), 0
    egg = $ \<div></div>
    egg.addClass \white-banner .text "司法不公  政治迫害"
    $ document.body .append egg
    egg.offset left: x, top: y - 150 .animate top: y - 50  .delay 500 .fadeOut!

  $scope.flower = (e, type) ->
    if type=='boat' and Math.random!>0.7 => type = 'duck'
    {clientX: mx, clientY: my} = e
    {top:y, left: x} = player.offset!
    [w, h] = [player.width!, player.height!]
    sy = $(document.body)scrollTop!
    [ww, wh] = [$(document.body)width!, $(window)height!]
    [ex, ey] = [if Math.random!>0.5 => ww else 0, my + parseInt((wh - my ) / 2)]
    egg = $ \<div></div>
    egg.addClass type
    $ document.body .append egg
    egg.offset left: x - 100, top: y + h - 200 .animate left: x + parseInt(w / 2) - 100  .delay 500 .fadeOut!
