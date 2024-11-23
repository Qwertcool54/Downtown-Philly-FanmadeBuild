public var holdGroup:Array<FlxSprite> = [];

public var opponentStrumline:Int = 0;
public var playerStrumline:Int = 1;

/*
 * json to load in with
 * doesnt work w/ scripts currently :(
*/
public var holdJSON:String = "default";

public var sustainData:Array = Json.parse(Assets.getText(Paths.json('splashes/hold/' + holdJSON)));

function postCreate()
    if (PlayState.instance.opponentMode){
        playerStrumline = 0;
        opponentStrumline = 1;
    }

function onPostStrumCreation(){
    for (i in 0...8){
        holdSplash = new FlxSprite();
        holdSplash.frames = Paths.getSparrowAtlas("game/splashes/hold/" + sustainData.spritesheet + sustainData.holdAnimations[i]);
        holdSplash.animation.addByPrefix("holdStart", "holdCoverStart" + sustainData.holdAnimations[i], 24, true);
        holdSplash.animation.addByPrefix("holding", "holdCover" + sustainData.holdAnimations[i], 24, true);
        holdSplash.animation.addByPrefix("holdEnd", "holdCoverEnd" + sustainData.holdAnimations[i], 24, false);
        holdSplash.cameras = [camHUD];
        holdSplash.visible = false;
        holdSplash.scale.set(sustainData.scale.x, sustainData.scale.y);
        holdSplash.antialiasing = sustainData.antialiasing;
        holdSplash.alpha = sustainData.alpha;
        add(holdSplash);
        holdGroup.push(holdSplash);
    }

    add(holdGroup);
}

function update()
    updateHoldSplashPos();

function updateHoldSplashPos(){
    for (lol in 0...4){
        var strum = strumLines.members[playerStrumline].members[lol];
        holdGroup[lol].x = strum.x + sustainData.xPos;
        holdGroup[lol].y = downscroll ? strum.y + sustainData.yPos.downscroll : strum.y + sustainData.yPos.upscroll;
    }

    // couldn't find a working way to use a for loop for the opponent :(
    var strum0 = strumLines.members[opponentStrumline].members[0];
    holdGroup[4].x = strum0.x + sustainData.xPos;
    holdGroup[4].y = downscroll ? strum0.y + sustainData.yPos.downscroll : strum0.y + sustainData.yPos.upscroll;

    var strum1 = strumLines.members[opponentStrumline].members[1];
    holdGroup[5].x = strum1.x + sustainData.xPos;
    holdGroup[5].y = downscroll ? strum1.y + sustainData.yPos.downscroll : strum1.y + sustainData.yPos.upscroll;

    var strum2 = strumLines.members[opponentStrumline].members[2];
    holdGroup[6].x = strum2.x + sustainData.xPos;
    holdGroup[6].y = downscroll ? strum2.y + sustainData.yPos.downscroll : strum2.y + sustainData.yPos.upscroll;

    var strum3 = strumLines.members[opponentStrumline].members[3];
    holdGroup[7].x = strum3.x + sustainData.xPos;
    holdGroup[7].y = downscroll ? strum3.y + sustainData.yPos.downscroll : strum3.y + sustainData.yPos.upscroll;
    
    for (i in 0...sustainData.holdDurations.length){
        sustainData.holdDurations[i] += 1;
        if (sustainData.holdDurations[i] == sustainData.endDelay){
            if (i <= 3){
                holdGroup[i].animation.play("holdEnd");
                new FlxTimer().start(sustainData.timeTillDisappear, function(){
                    holdGroup[i].visible = false;
                });
            }else
                holdGroup[i].visible = false;
        }
    }
}


function onPlayerHit(e){
    if (!e.cancelled)
        if (e.note.isSustainNote && e.note.__strum != null)
            sustainHolding(e.direction);
}

function onDadHit(e){
    if (!e.cancelled && sustainData.dadHoldSustains)
        if (e.note.isSustainNote && e.note.__strum != null)
            switch(e.direction){
                case 0:
                    sustainHolding(4);
                case 1:
                    sustainHolding(5);
                case 2:
                    sustainHolding(6);
                case 3:
                    sustainHolding(7);
            }
}

function sustainHolding(susInt:Int){
    holdGroup[susInt].visible = true;
    holdGroup[susInt].animation.play("holding");

    sustainData.holdDurations[susInt] = 0;
}