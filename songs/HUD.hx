import flixel.util.FlxStringUtil;
import flixel.text.FlxTextBorderStyle;

function postUpdate()
     {
        icoP1.x = 825;
        icoP2.x = 300;
     }
function postCreate() {
    Timetxt = new FunkinText(0, 74, FlxG.width, "X:XX");
    Timetxt.setFormat(Paths.font('vcr.otf'), 26, FlxColor.BLACK, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
    Timetxt.borderSize = 9;
    Timetxt.cameras = [camHUD];
    add(Timetxt);
}

function update(elapsed:Float) {
    var songPos = Math.max(Conductor.songPosition, 0);
    var songTime = FlxStringUtil.formatTime((inst.length-inst.time) / 1000, false);

    Timetxt.text = PlayState.SONG.meta.displayName + " • " + songTime;
}
