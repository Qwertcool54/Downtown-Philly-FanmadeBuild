for(i in 0...strumlines.members[0].length)
    {
      FlxTween.tween(strum.members[i], {y: strum.members[i].y + 50}, 3);
    }