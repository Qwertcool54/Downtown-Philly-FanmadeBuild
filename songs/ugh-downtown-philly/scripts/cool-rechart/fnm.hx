//script by idk, modified by me

function postCreate() {
    healthBar.createFilledBar(0xFFFF0000, 0xFF0102ED);
    iconP1.loadGraphic(Paths.image('icons/blue'), true, 150, 150);
    iconP1.flipX = true;
    iconP2.loadGraphic(Paths.image('icons/red'), true, 150, 150);
    missesTxt.visible = false;
    accuracyTxt.visible = false;
    comboGroup.visible = false;
    splashHandler.visible = false;
    ghostTapping = false;
    downscroll = false;
}

function postUpdate(elapsed) {
    iconP1.scale.x = 0.7;
    iconP2.scale.x = 0.7;
    iconP1.scale.y = 0.7;
    iconP2.scale.y = 0.7;
}

function onNoteCreation(note)
{
    note.noteSprite = "game/notes/fnmshit";
}

function onStrumCreation(note)
{
    note.sprite = "game/notes/fnmshit";
}