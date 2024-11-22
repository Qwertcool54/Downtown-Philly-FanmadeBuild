import  flixel.FlxObject;
import flixel.FlxCameraFollowStyle;
//var intensity = 2; // How far the camera moves on press, default is 5
                   // 5 = 50 Pixels

public var move = true;   // Do you want the camera to move? default is true (can also be toggled with "toggleMovePress" event)

var posOffsets = [
    [-20, 0],
    [0, 20],
    [0, -20],
    [20, 0]
];


var bfNoteCamOffset = [];
var dadNoteCamOffset = [];

var curPee:Int = 2;
function onCameraMove(event) {
    if (event.position.x == dad.getCameraPosition().x && event.position.y == dad.getCameraPosition().y)
    {
        camTarget = "dad";
        curPee = 2;
    }
    else if (event.position.x == boyfriend.getCameraPosition().x && event.position.y == boyfriend.getCameraPosition().y)
    {
        camTarget = "boyfriend";
        curPee = 1;
    }

}

function onNoteHit(event) {
    if (move) {
        if (camTarget == "dad")
            {
                bfNoteCamOffset[0] = 0;
                bfNoteCamOffset[1] = 0;

                dadNoteCamOffset[0] = posOffsets[event.direction][0];
                dadNoteCamOffset[1] = posOffsets[event.direction][1];

                camFolloww.x = camFollow.x + dadNoteCamOffset[0];
                camFolloww.y = camFollow.y + dadNoteCamOffset[1];

            }
        else if (camTarget == "boyfriend")
            {
                dadNoteCamOffset[0] = 0;
                dadNoteCamOffset[1] = 0;

                bfNoteCamOffset[0] = posOffsets[event.direction][0];
                bfNoteCamOffset[1] = posOffsets[event.direction][1];
                //camFollow.setPosition(camFollow.x, 0);
                camFolloww.x = camFollow.x + bfNoteCamOffset[0];
                camFolloww.y = camFollow.y + bfNoteCamOffset[1];
           }
    }
}
function postUpdate() {
  if (move) {
        if (camTarget == "dad")
        {
            if (dad.animation.curAnim.name == "idle")
            {
                dadNoteCamOffset[0] = 0;
                dadNoteCamOffset[1] = 0; 
            }
            camFolloww.x = camFollow.x + dadNoteCamOffset[0];
            camFolloww.y = camFollow.y + dadNoteCamOffset[1];
        }
        else if (camTarget == "boyfriend")
        {
            if (boyfriend.animation.curAnim.name == "idle")
            {
                bfNoteCamOffset[0] = 0;
                bfNoteCamOffset[1] = 0;
            }
            camFolloww.x = camFollow.x + bfNoteCamOffset[0];
            camFolloww.y = camFollow.y + bfNoteCamOffset[1];
        }
    }

}
function toggleMovePress(event) {
    move = !move;
}

var camFolloww:FlxObject;

function postCreate() {
    
    var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

    camFolloww = new FlxObject(0, 0, 1, 1);

    camFolloww.setPosition(camFollow.x, camFollow.y);

    FlxG.camera.follow(camFolloww, FlxCameraFollowStyle.LOCKON, 0.05);
    //FlxG.camera.focusOn(camFollow.getPosition());
    FlxG.camera.focusOn(camFolloww.getPosition());
}