var defaultZoom:Int; 
var lolZoom:Bool = false;

var currentCameraZoom:Float = defaultCamZoom;
var cameraBopMultiplier:Float = 1.0;
var defaultHUDCameraZoom:Float = FlxCamera.defaultZoom * 1.0;
var cameraBopIntensity:Float = 0.015 * camZoomingStrength;
var hudCameraZoomIntensity:Float = 0.015 * 2.0;

var zoomTween = new FlxTween();

function onNoteHit(event){
    event.enableCamZooming = false;
}

function update(){
    if(!camZooming){
        cameraBopMultiplier = lerp(cameraBopMultiplier, 1, camGameZoomLerp); // Lerp bop multiplier back to 1.0x
        var zoomPlusBop = defaultCamZoom * cameraBopMultiplier; // Apply camera bop multiplier.
        FlxG.camera.zoom = zoomPlusBop;

        camHUD.zoom = lerp(camHUD.zoom, defaultHudZoom, camHUDZoomLerp);
    }
}

function beatHit(){
    if (Options.camZoomOnBeat && !camZooming && curBeat % camZoomingInterval == 0){
        cameraBopMultiplier += 0.015 * camZoomingStrength;
        camHUD.zoom += 0.03 * camZoomingStrength;
    }
}

function create(){
    defaultZoom = defaultCamZoom;
}
function onEvent(_) {
    if (_.event.name == 'ZoomCamera') {
        var zoomAmount = _.event.params[0];
        var tweenTime = (Conductor.stepCrochet / 1000) * _.event.params[1];
        var tweenType = _.event.params[2];
        var zoomType = _.event.params[3];

        switch(zoomType){
            case 'stage': lolZoom = true;
            case 'direct': lolZoom = false;
        }

        targetCameraZoom = zoomAmount * (lolZoom ? defaultZoom : 1);

        if(zoomTween != null) zoomTween.cancel();
        switch(tweenType.toUpperCase()){
            case "INSTANT": zoomTween = FlxTween.tween(this, {defaultCamZoom: targetCameraZoom}, 0.00000000001);
            default: zoomTween = FlxTween.tween(this, {defaultCamZoom: targetCameraZoom}, tweenTime, {ease: Reflect.field(FlxEase, tweenType)});
        }
    }
}