import openfl.geom.Rectangle;

import openfl.text.TextFormat;

import flixel.text.FlxTextBorderStyle;

import flixel.ui.FlxBar;

import flixel.FlxG;

var songTxt:FlxText;

var timeEplaseTxt:FlxText;

var timeTxt:FlxText;

function create() {

songTxt = new FlxText(0, 20.5, 400, "X:XX", 36);

songTxt.setFormat(Paths.font("MilkyNice.ttf"), 24, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

songTxt.scrollFactor.set();

songTxt.alpha = 0;

songTxt.borderColor = 0xFF000000;

songTxt.borderSize = 2;

songTxt.screenCenter(FlxAxes.X);

timeBarBG = new FlxSprite();

timeBarBG.x = songTxt.x;

timeBarBG.y = songTxt.y + 40;

timeBarBG.scale.x = 1;

timeBarBG.scale.y = 1.9;

timeBarBG.alpha = 0;

timeBarBG.scrollFactor.set();

timeBarBG.color = FlxColor.BLACK;

timeBarBG.loadGraphic(Paths.image("game/timeBar"));

//timeBarBG.visible = false;

timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y - 32, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);

timeBar.scrollFactor.set();

timeBar.createFilledBar(0xFF242424,dad.iconColor);

timeBar.numDivisions = 400; //Toned it down to 400 to see what it would look like.

timeBar.alpha = 0;

timeBar.scale.y = 1.9;

timeBar.antialiasing = true;

timeBar.value = Conductor.songPosition / Conductor.songDuration;

timeEplaseTxt = new FlxText(0, 10.5, 400, "X:XX", 45);

timeEplaseTxt.setFormat(Paths.font("MilkyNice.ttf"), 24, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

timeEplaseTxt.scrollFactor.set();

timeEplaseTxt.x = timeBarBG.x + 400;

timeEplaseTxt.y = timeBarBG.y - 45;

timeEplaseTxt.alpha = 0;

timeEplaseTxt.borderColor = 0xFF000000;

timeEplaseTxt.borderSize = 2;

timeEplaseTxt.antialiasing = true;

timeTxt = new FlxText(0, 10.5, 400, "X:XX", 45);

timeTxt.setFormat(Paths.font("MilkyNice.ttf"), 24, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

timeTxt.scrollFactor.set();

timeTxt.x = timeBarBG.x - 60;

timeTxt.y = timeBarBG.y - 45;

timeTxt.alpha = 0;

timeTxt.borderColor = 0xFF000000;

timeTxt.borderSize = 2;

timeTxt.antialiasing = true;

add(timeBarBG);

add(timeBar);

add(songTxt);

add(timeEplaseTxt);

add(timeTxt);

timeBarBG.x = timeBar.x - 4;

timeBarBG.y = timeBar.y - 4;

timeBar.cameras = [camHUD];

timeBarBG.cameras = [camHUD];

songTxt.cameras = [camHUD];

timeEplaseTxt.cameras = [camHUD];

timeTxt.cameras = [camHUD];

}

function onSongStart() {

if (timeBar != null) {

FlxTween.tween(timeBar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

}

if (timeBarBG != null) {

FlxTween.tween(timeBarBG, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

}

if (songTxt != null) {

FlxTween.tween(songTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

}

if (timeTxt != null) {

FlxTween.tween(timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

}

if (timeEplaseTxt != null) {

FlxTween.tween(timeEplaseTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

}

}

function update(elapsed:Float) {

var pos = Math.max(Conductor.songPosition, 0);

var timeNow = Math.floor(pos / 60000) + ":" + CoolUtil.addZeros(Std.string(Math.floor(pos / 1000) % 60), 2);

var length = Math.floor(inst.length / 60000) + ":" + CoolUtil.addZeros(Std.string(Math.floor(inst.length / 1000) % 60), 2);

if (inst != null && timeBar != null && timeBar.max != inst.length) {

timeBar.setRange(0, Math.max(1, inst.length));

}

songTxt.text = PlayState.SONG.meta.displayName;

timeEplaseTxt.text = length;

timeTxt.text = timeNow;

}