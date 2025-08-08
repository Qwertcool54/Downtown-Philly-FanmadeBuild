import funkin.options.Options;
import funkin.backend.system.framerate.Framerate;

function postCreate() {
    ghostTapping = false;
    missesTxt.visible = false;
    accuracyTxt.visible = false;
}

function create() {
    Options.colorHealthBar = false;
}
Framerate.codenameBuildField.visible = false;
Framerate.memoryCounter.visible = false;
