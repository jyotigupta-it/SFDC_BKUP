@isTest
public class OpportunitySearchController_UT{

static testMethod void testMethod1(){
test.StartTest();

Opportunity opp=new Opportunity();
opp.Name='test';
opp.StageName='Designing';
Date myDate=date.newInstance(2015,12,31);
opp.CloseDate=myDate;
insert opp;

Influencer__c influencer=new Influencer__c();
influencer.Opportunity__c=opp.id;

OpportunitySearchController oppSearch=new OpportunitySearchController(new ApexPages.StandardController(new Account()));
oppSearch.searchInflu();


test.StopTest();

}

}