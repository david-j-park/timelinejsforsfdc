({
    handleSaveRecord : function(component, event, helper) {
        component.find("recordHandler").saveRecord($A.getCallback(function(saveResult){
            if (saveResult.state === "SUCCESS"){
                console.log("We're saved!");
            }
            else console.log(JSON.stringify(saveResult.error));
        }))
    },

    handleRecordUpdated : function(component, event, helper){
        var eventParams = event.getParams();
        if (eventParams.changeType === "CHANGED"){
            console.log(eventParams.changedFields);
            var toast = $A.get("e.force:showToast");
            toast.setParams({
                "title": "Saved!",
                "message": "All is well"
            });
            toast.fire();
            // Navigate back to the record view
            var navigateEvent = $A.get("e.force:navigateToSObject");
            navigateEvent.setParams({ "recordId": component.get('v.recordId') });
            navigateEvent.fire();
        }
    }
})
