trigger  CreateTourplan on Tour_Program__c (after insert, after update) {

 
    for(Tour_Program__c newSL: Trigger.New){
        if(newSL.From_Date__c != null && newSL.To_Date__c != null  && newSL.No_of_Days1__c!= null ){
            Date StartMon = newSL.From_Date__c;
            Date EndMon = newSL.To_Date__c;
            
          
            
            Integer MonthDiff = StartMon.daysBetween(EndMon);
            
            system.debug('@@@@@@@@@MonthDiff@@@@@@@@'+MonthDiff);
            
            
            
            Decimal div = MonthDiff / newSL.No_of_Days1__c;
            
            system.debug('@@@@@@@@div@@@@@@@@@@@'+div);
            
            
          
            
            Integer Idiv  = Integer.valueOf(div);
            
            system.debug('@@@@@@@@@div@@@@@@@@@@@'+div);
           
           Integer Idiv1 = 0;
          
                
        if(newSL.No_of_Days1__c!= null){
            List<Tour_Plan1__c> svlist = [select id,Date__c,Name,State__c,District__c,Location__c,Visit_Type__c from  Tour_Plan1__c where  Tour_Program__c =:newSL.id];
            if(svlist.size() == 0){   
            
                for(integer i=0; i<=newSL.No_of_Days1__c; i++){
                   
                          if(i==0)
                          {
                            Tour_Plan1__c sv = new Tour_Plan1__c(
                            Name = 'Tourplan',
                            Tour_Program__c = newSL.id,
                            
                            Date__c = newSL.From_Date__c);   
                            insert sv;
                            }
                            else
                            {
                              Idiv1 = Idiv + Idiv1 ; 
                            Tour_Plan1__c sv1 = new Tour_Plan1__c(
                            Name = 'Tourplan',
                            Tour_Program__c = newSL.id,
                            
                            Date__c = newSL.From_Date__c.addDays(Idiv1));   
                            insert sv1;
                            
                            }
                    }
                }
            }
        
}    
}    
}