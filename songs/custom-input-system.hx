public var judgements = [
    {
        window: 50,
        score: 350,
        accuracy: 1,
        name: "sick"
    },
    {
        window: 100,
        score: 150,
        accuracy: 0.75,
        name: "good"
    },
    {
        window: 120,
        score: 0,
        accuracy: 0.25,
        name: "bad"
    },
    {
        window: 140,
        score: -50,
        accuracy: 0,
        name: "shit"
    }
];

function onPlayerHit(e)
{
    var noteDiff = Math.abs(Conductor.songPosition - e.note.strumTime);

    // monster of monsters code no way????
    // (i just ported it to softcode, since its originally hardcoded from the mod itself, original code by nebula) - syrup
    for(j in judgements)
    {
        if(noteDiff <= j.window)
        {
            e.rating = j.name;
            e.score = j.score;
            e.accuracy = j.accuracy;

            break;
        }
    }

    // fixes a lil issue
    if (e.rating != 'sick') e.showSplash = false;
}