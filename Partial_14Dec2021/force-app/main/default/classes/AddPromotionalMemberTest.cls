@isTest
public class AddPromotionalMemberTest {
    static testMethod void AddPromotionalMemberTest() {
        Tour_Program__c tr=new Tour_Program__c();
        tr.From_Date__c=date.newinstance(2018, 10, 1);
        tr.To_Date__c=date.newinstance(2018, 10, 15);
        tr.Tour_Program_Approved__c = true;
        insert tr;
        
        List<Tour_Plan1__c > TourPlan=new List<Tour_Plan1__c >();
        Tour_Plan1__c tp=new Tour_Plan1__c();
        tp.Name='Tour Plan1234';
        tp.Tour_Program__c=tr.id;
        tp.Date__c = Date.today();
        insert tp;
       
     
        Site_Visit__c sv=new Site_Visit__c();
        sv.Tour_Plan1__c=tp.id;
        sv.Architects_Meet_Actuals__c=1;
        sv.Boarers_Meet_Actuals__c=2;
        sv.Builders_Meet_Actuals__c=3;
        sv.Date__c = Date.today();
        insert sv;
       
        Promotion__c prm=new Promotion__c();            
        prm.Date__c=System.today();
        prm.Type__c='Dealers Meet';
        prm.Site_Visit__c=sv.id;
        insert prm; 
        
        AddPromotionalMember.addmember(prm.id);
    }
    
}