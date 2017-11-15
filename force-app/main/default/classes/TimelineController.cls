public with sharing class TimelineController {
    
    public string outjson { get; set; }
    
    public TimelineController(){
        outjson = GetTimelineJSON(apexpages.currentPage().getParameters().get('id'));
    }
    
    public string GetTimelineJSON(Id timelineID){
        
        //get the object
        Timeline__c tl = [SELECT Id, Title__c, Subtitle__c, Background_Color__c, Background_URL__c, (
        	SELECT Title__c, Details__c, Start_Year__c, Start_Month__c, Start_Day__c, 
            	End_Year__c, End_Month__c, End_Day__c, Background_URL__c, Background_Color__c,
            	Media_URL__c, Media_Caption__c, Media_Credit__c, Media_Thumbnail__c, Media_Alt_Tag_Text__c,
            	Group__c, Display_Date__c
            from Timeline_Slides__r
        ), (
        	SELECT Title__c, Details__c, Start_Year__c, Start_Month__c, Start_Day__c,
            End_Year__c, End_Month__c, End_Day__c
            from Timeline_Eras__r
        ) FROM Timeline__c WHERE Id = :timelineID];
        
        
        JSONGenerator gen = JSON.createGenerator(true); 
        gen.writeStartObject();
        gen.writeFieldName('title');
        gen.writeStartObject();
        gen.writeFieldName('text');
        gen.writeStartObject();
        gen.writeStringField('headline', tl.Title__c);
        gen.writeStringField('text', tl.Subtitle__c);
        gen.writeEndObject();
        
        //title Background
        if (tl.Background_Color__c != null || tl.Background_URL__c != null){
            gen.writeFieldName('background');
            gen.writeStartObject();
            if (tl.Background_Color__c != null) gen.writeStringField('color', tl.Background_Color__c);
            if (tl.Background_URL__c != null) gen.writeStringField('url', tl.Background_URL__c);
            gen.writeEndObject();
        }
        gen.writeEndObject();        
        
        //eras
        gen.writeFieldName('eras');
        gen.writeStartArray();
        for (Timeline_Era__c e : tl.Timeline_Eras__r){
            gen.writeStartObject();
            
            //text
            gen.writeFieldName('text');
            gen.writeStartObject();
            gen.writeStringField('headline', e.Title__c);
            if (e.Details__c != null) gen.writeStringField('text', e.Details__c);
            gen.writeEndObject();
            
            //dates
            gen.writeFieldName('start_date');
            gen.writeStartObject();
            gen.writeNumberField('year', Integer.valueOf(e.Start_Year__c));
            if (e.Start_Month__c != null) gen.writeNumberField('month', e.Start_Month__c);
            if (e.Start_Day__c != null) gen.writeNumberField('day', e.Start_Day__c);
            gen.writeEndObject();
            
            gen.writeFieldName('end_date');
            gen.writeStartObject();
            gen.writeNumberField('year', Integer.valueOf(e.End_Year__c));
            if (e.End_Month__c != null) gen.writeNumberField('month', e.End_Month__c);
            if (e.End_Day__c != null) gen.writeNumberField('day', e.End_Day__c);
            gen.writeEndObject();
            
            gen.writeEndObject();
        }
        gen.writeEndArray();
        
        gen.writeFieldName('events');
        gen.writeStartArray();
        for (Timeline_Slide__c s : tl.Timeline_Slides__r){
            gen.writeStartObject();
            
            //text
            gen.writeFieldName('text');
            gen.writeStartObject();
            gen.writeStringField('headline', s.Title__c);
            gen.writeStringField('text', s.Details__c);
            gen.writeEndObject();
            
            //start date
            gen.writeFieldName('start_date');
            gen.writeStartObject();
            gen.writeNumberField('year', Integer.valueOf(s.Start_Year__c));
            if (s.Start_Month__c != null) gen.writeNumberField('month', s.Start_Month__c);
            if (s.Start_Day__c != null) gen.writeNumberField('day', s.Start_Day__c);
            gen.writeEndObject();
            
            
            //end date
            if (s.End_Year__c != null){
                gen.writeFieldName('end_date');
                gen.writeStartObject();
                gen.writeNumberField('year', Integer.valueOf(s.End_Year__c));
                if (s.End_Month__c != null) gen.writeNumberField('month', s.End_Month__c);
                if (s.End_Day__c != null) gen.writeNumberField('day', s.End_Day__c);
                gen.writeEndObject();
            }
            
            //display date
            if (s.Display_Date__c != null) gen.writeStringField('display_date', s.Display_Date__c);
            
            //group
            if (s.Group__c != null) gen.writeStringField('group', s.Group__c);
            
            //media
            
            if (s.Media_URL__c != null){
                gen.writeFieldName('media');
                gen.writeStartObject();
                gen.writeStringField('url', s.Media_URL__c);
                if (s.Media_Caption__c != null) gen.writeStringField('caption', s.Media_Caption__c);
                if (s.Media_Credit__c != null) gen.writeStringField('credit', s.Media_Credit__c);
                if (s.Media_Alt_Tag_Text__c != null) gen.writeStringField('alt', s.Media_Alt_Tag_Text__c);
                if (s.Media_Thumbnail__c != null) gen.writeStringField('thumbnail', s.Media_Thumbnail__c);
                gen.writeEndObject();
            }
            
            //background
            if (s.Background_Color__c != null || s.Background_URL__c != null){
                gen.writeFieldName('background');
                gen.writeStartObject();
                if (s.Background_Color__c != null) gen.writeStringField('color', s.Background_Color__c);
                if (s.Background_URL__c != null) gen.writeStringField('url', s.Background_URL__c);
                gen.writeEndObject();
            }

            gen.writeEndObject();
            
        }
        gen.writeEndArray();
        gen.writeEndObject();
        return gen.getAsString();
    }
}