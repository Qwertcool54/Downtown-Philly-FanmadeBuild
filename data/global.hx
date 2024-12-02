var windowName = 'VS Invert/Negative BF';
public var canDie:Bool = !opponentMode && !coopMode;

window.title = windowName;

function postStateSwitch(){
    if(!Std.isOfType(FlxG.state, PlayState))
        window.title = windowName;
    else
        window.title = windowName + ' - ' + PlayState.SONG.meta.displayName;
}

function destroy(){
    window.title = "Friday Night Funkin' - Codename Engine";
}

