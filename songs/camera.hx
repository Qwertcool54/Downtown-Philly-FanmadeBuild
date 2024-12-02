public var cameraMovementStrength = 20;
public var cameraMovementEnabled = true;
public var cameraMovementSpeed = 1;
public var cameraEase = FlxEase.quadInOut;
public var notesCamGame = false;
var offX = 0;
var offY = 0;
var tarX = 0;
var tarY = 0;
public var target:FlxSprite;
var tarAdd:FlxSprite;
var tween:FlxTween;
var curChar = "";
var theAmt = 0;

function postCreate() {
	FlxG.camera.followLerp = 0.00;
	trace(cameraMovementEnabled);
    	target = new FlxSprite();
	target.makeGraphic(10, 10, FlxColor.CYAN);
	target.x = 0;
	target.y = 0;
	target.camera = camHUD;
	target.origin.set(0, 0);
	target.visible = false;
	add(target);
    	tarAdd = new FlxSprite();
	tarAdd.makeGraphic(10, 10, FlxColor.CYAN);
	tarAdd.x = 0;
	tarAdd.y = 0;
	tarAdd.camera = camHUD;
	tarAdd.origin.set(0, 0);
	tarAdd.visible = false;
	add(tarAdd);
	tweenPos = FlxTween.tween(target, {x:0, y:0}, cameraMovementSpeed, {ease: FlxEase.quintOut});
	tweenPos.cancel();
	curChar = strumLines.members[curCameraTarget].characters[0];
	target.x = curChar.getCameraPosition().x;
	target.y = curChar.getCameraPosition().y;
	theAmt = (Conductor.bpm / 3 / cameraMovementSpeed / 2) * 10;
	trace(theAmt);
	trace(cameraEase == FlxEase.quadInOut);
	for (event in events) {
		if (event.name == "Camera Movement" && cameraEase == FlxEase.quadInOut) {
			event.time -= theAmt;
		}
	}
}

function postUpdate(elapsed:Float){
	if (cameraMovementEnabled) {
	var anim = strumLines.members[curCameraTarget].characters[0].getAnimName();
	switch(anim){
        	case "singLEFT"|"singLEFT-alt":
			offX = -cameraMovementStrength;
			offY = 0;
        	case "singDOWN"|"singDOWN-alt":
			offX = 0;
			offY = cameraMovementStrength;
        	case "singUP"|"singUP-alt":
			offX = 0;
			offY = -cameraMovementStrength;
        	case "singRIGHT"|"singRIGHT-alt":
			offX = cameraMovementStrength;
			offY = 0;
		case "idle":
			offX = 0;
			offY = 0;
	}
	}
	curChar = strumLines.members[curCameraTarget].characters[0];
	camGame.scroll.x = -650 + target.x + tarAdd.x;
	camGame.scroll.y = -350 + target.y + tarAdd.y;
	camGame.zoom = FlxMath.lerp(camGame.zoom, defaultCamZoom, 0.015); 
	camHUD.zoom = FlxMath.lerp(camHUD.zoom, (camGame.zoom - defaultCamZoom) * 2 + 1, 0.015);
	tarAdd.x = FlxMath.lerp(tarAdd.x, offX, 0.015); 
	tarAdd.y = FlxMath.lerp(tarAdd.y, offY, 0.015); 
	if (notesCamGame)
	for (i in 0...strumLines.members[0].members.length) {
		strumLines.members[0].members[i].x = dad.x - camGame.scroll.x + (i * 114);
		strumLines.members[0].members[i].y = dad.y - dad.height/3 + camGame.scroll.y;
	}
	FlxG.camera.followLerp = 0.00;
}

function onCameraMove(event) event.cancel();

function onEvent(event) {
	if (event.event.name == "Camera Movement") {
		tweenPos.cancel();
		curChar = strumLines.members[event.event.params[0]].characters[0];
		tweenPos = FlxTween.tween(target, {
			x:curChar.getCameraPosition().x, 
			y:curChar.getCameraPosition().y
		}, 1 / cameraMovementSpeed, {ease: cameraEase});
	}
}

function destroy() {
	for (event in events) {
		if (event.name == "Camera Movement" && cameraEase == FlxEase.quadInOut) {
			event.time += theAmt;
		}
	}
}
