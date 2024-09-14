function postUpdate() {
    if (FlxG.keys.justPressed.F7) {
        FlxG.switchState(new ModState('ResultsState'));
    }
}