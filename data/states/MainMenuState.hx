function onSelectItem(event)
    if (event.name == "donate") {
        event.cancel();
        PlayState.loadSong("eye-to-invert", "hard");
		FlxG.switchState(new PlayState());
    }