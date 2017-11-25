# This doesn't work, ignore it.

There appear to be incompatibilities between the lightning javascript loader and the Timeline.js framework. The "afterScriptsLoaded" event never fires, so there is no good way to initialize the timeline, at least not that I've found.

Use the visualforce page instead for display purposes. 