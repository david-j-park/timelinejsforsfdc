({
    jsLoaded : function(component, event, helper) {
        alert('loading');
        /*
        component.set("v.TimelineID", "a020R000000wlYkQAI"); // test data now; needs to be make configurable)
        //Get the JSON structured data from controller
        var action = component.get("c.GetTimelineData");
        action.setParams({Id: component.get("v.TimelineID")}); 
        action.setCallback(this, function(a){
            alert(a.getReturnValue());
            component.set("v.tldata", a.getReturnValue());
            new TL.Timeline(component.find("timeline-embed").getElement(), a.getReturnValue());
        });
        $A.enqueueAction(action);
        */
    },

    doInit: function(component, event, helper){
        //alert('Init!');
        component.set("v.TimelineID", "a020R000000wlYkQAI"); // test data now; needs to be make configurable)
        //Get the JSON structured data from controller
        var action = component.get("c.GetTimelineData");
        action.setParams({timelineID: component.get("v.TimelineID")});
        console.log(component.get("v.TimelineID"))
        action.setCallback(this, function(a){
            console.log(TL);
            component.set("v.tldata", a.getReturnValue());
            new TL.Timeline("timeline-embed", a.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})
