/************

Deactivated by Extentor  on 20/04/2015

Reason: Tour Program object not in use.

************/

trigger Rolluptotourprogram on Promotion__c (after insert, after update, after delete, after undelete) {
    
 /*   set<Id> RId = new set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Promotion__c promo_new : trigger.new){                        
            RId.add(promo_new.id);                        
        }
    }
    if(Trigger.isDelete){
        for(Promotion__c promo_old : trigger.old){                        
            RId.add(promo_old.id);
                                    
        }
    }
    
    set<Id> tourProgramIds = new set<Id>();
    
    public List<Promotion__c> listmodifiedPromo =[select ID, Site_Visit__r.id, Site_Visit__r.Tour_Plan1__c, Site_Visit__r.Tour_Plan1__r.Tour_Program__r.id from Promotion__c where id IN :RId];
    for(Promotion__c each: listmodifiedPromo){
        System.debug('each.id = '+each.id);
        System.debug('each.site visit = '+each.Site_Visit__r.id);
        System.debug('each.tour plan  = '+each.Site_Visit__r.Tour_Plan1__c);
        System.debug('each.Program = '+each.Site_Visit__r.Tour_Plan1__r.Tour_Program__r.id);
        tourProgramIds.add(each.Site_Visit__r.Tour_Plan1__r.Tour_Program__r.id);
    }
    
    public List<Promotion__c> listAllPromo = [select Id, Name, Type__c, Site_Visit__r.Tour_Plan1__r.Tour_Program__r.id from Promotion__c where Site_Visit__r.Tour_Plan1__r.Tour_Program__r.id IN :tourProgramIds];

    integer Architects_Meet =0;
    integer Boarers_Meet=0;
    integer Builders_Meet=0;
    integer Dealers_Meet=0;
    integer Engineers_Meet=0;
    integer Exhibition=0;
    integer Farmers_Meet=0;
    integer Jeep_Campaign=0;
    integer Mechanic_Meet=0;
    integer Plumber_Meet=0;
    integer Shandy_Show=0;
    integer Tractor_Show=0;
    integer Dealers_Salesman_Meet=0;
    integer Mini_Meet=0;
    integer Dealers_Factory_Visit=0;
    integer Plumber_Mechanic_Engineers_Factory=0;
    integer GroupActivity=0;
    for(Promotion__c each : listAllPromo){
        if(each.Type__c =='Architects Meet') Architects_Meet++;
        if(each.Type__c =='Boarers Meet') Boarers_Meet++;
        if(each.Type__c =='Builders Meet') Builders_Meet++;
         if(each.Type__c =='Dealers Meet') Dealers_Meet++;
          if(each.Type__c =='Engineers Meet') Engineers_Meet++;
          if(each.Type__c =='Exhibition') Exhibition++;
           if(each.Type__c =='Farmers Meet') Farmers_Meet++;
            if(each.Type__c =='Jeep Campaign') Jeep_Campaign++;
             if(each.Type__c =='Mechanic Meet') Mechanic_Meet++;
              if(each.Type__c =='Plumber Meet') Plumber_Meet++;
               if(each.Type__c =='Shandy Show') Shandy_Show++;
                if(each.Type__c =='Tractor Show') Tractor_Show++;
                 if(each.Type__c =='Dealers Salesman Meet') Dealers_Salesman_Meet++;
                  if(each.Type__c =='Mini Meet') Mini_Meet++;
                   if(each.Type__c =='Dealers Factory Visit') Dealers_Factory_Visit++;
                   
                     if(each.Type__c =='Plumber/Mechanic/Engineers Factory Visit') Plumber_Mechanic_Engineers_Factory++;
                     if(each.Type__c =='Group Activity') GroupActivity++;
    
    }
    list<Tour_Program__c> programstoUpdate = new list<Tour_Program__c>();
    for(Id programId : tourProgramIds){
        Tour_Program__c newProgram = new Tour_Program__c(Id=programId, 
                                                    Architects_Meet_Actuals__c = Architects_Meet,
                                                    Boarers_Meet_Actuals__c = Boarers_Meet,
                                                    Builders_Meet_Actuals__c = Builders_Meet,
                                                    Dealers_Meet_Actuals__c=Dealers_Meet,
                                                    Engineers_Meet_Actuals__c=Engineers_Meet,
                                                    Exhibition_Actuals__c=Exhibition,
                                                    Farmers_Meet_Actuals__c=Farmers_Meet,
                                                    Jeep_Campaign_Actuals__c=Jeep_Campaign,
                                                    Mechanics_Meet_Actuals__c=Mechanic_Meet,
                                                    Plumbers_Meet_Actuals__c=Plumber_Meet,
                                                    Shandy_Show_Actuals__c=Shandy_Show,
                                                    Tractor_Show_Actuals__c=Tractor_Show,
                                                    Dealers_Salesmen_Meet_Actuals__c=Dealers_Salesman_Meet,
                                                    Mini_Meet_Actuals__c=Mini_Meet,
                                                    Dealers_Factory_Visit_Actuals__c=Dealers_Factory_Visit,
                                                    Plumber_MechanicEngineers_Factory_Visit__c=Plumber_Mechanic_Engineers_Factory,
                                                     Group_Activity_Actuals__c=GroupActivity);
                                                    
        programstoUpdate.add(newProgram);
    }
    update programstoUpdate; */
}