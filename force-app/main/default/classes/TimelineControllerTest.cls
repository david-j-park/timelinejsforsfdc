@IsTest
public with sharing class TimelineControllerTest {
	
    public static Id setup(){
        Timeline__c t = new Timeline__c();
        t.Title__c = 'Test';
        t.Subtitle__c = 'Testing';
        t.Background_Color__c = '#666666';
        insert t;
        
        Timeline_Era__c e = new Timeline_Era__c();
        e.Timeline__c = t.Id;
        e.Start_Year__c = '2001';
        e.End_Year__c = '2010';
        e.Title__c = 'Test Era';
        e.Details__c = 'Test';
        insert e;
        
        Timeline_Slide__c s = new Timeline_Slide__c();
        s.Timeline__c = t.Id;
        s.Title__c = 'Test Slide';
        s.Details__c = 'Test content.';
        s.Background_Color__c = '#003366';
        s.Start_Day__c = 1;
        s.Start_Month__c = 7;
        s.Start_Year__c = '2001';
        s.End_Year__c = '2005';
        s.Media_Alt_Tag_Text__c = '';
        s.Media_Caption__c = '';
        s.Media_Credit__c = '';
        s.Media_Thumbnail__c = '';
        s.Media_URL__c = 'http://www.example.com';
        insert s;
        
        return t.Id;
    }
    
    public static testmethod void testGetJSON(){
        PageReference ref = Page.TimelineDisplay;
        Test.setCurrentPage(ref);
        ApexPages.currentPage().getParameters().put('id', setup());
        TimelineController c = new TimelineController();
        string json = c.GetTimelineJSON(setup());
        System.assert(json.length() > 0);
    }
    
}