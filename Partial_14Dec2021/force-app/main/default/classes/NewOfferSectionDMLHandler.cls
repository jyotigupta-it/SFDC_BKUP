/***************************************************************************************************************************
Created By: Rahul Mukherji
Modified By: Subhajit Ghosh,Surya Priya.S 
Company: KVP 
Description: 1.This is the controller to the trigger on Project object. Whenever a project gets created its autopopulates data in the 
new offer section/indicative product fitment list object along with the calculations.
Test: NewOfferDMLTriggerTest
********************************************************************************************************************/
public class NewOfferSectionDMLHandler {
    
    /**This function is used when a project is created and records have to be created in the product fitment list
and when products are selected and sent for SPR then this function is called and because it takes the latest price
from the master object.
*/
    public static List<New_Offer_Section__c > calcMatrixMap(Map<Id,Opportunity> newOppMap,String dataType){
        
        system.debug('trigger called---');
        String papaTypeCheck='';//for the type of product category coming in case of PAPA and AAV
        Set<String> internalPlumbingSet = new Set<String>();
        Set<String> materialSet = new Set<String>();
        Set<String> swrToBeDeployedSet = new Set<String>();
        Set<String> propTypeSet = new Set<String>();
        //   Set<String> CombinationCalcSet=new Set<String>();
        //Map<Id,String> oppKeyCombMap = new Map<Id,String>();
        Map<String , Probability_Master__c> probMastMap = new Map<String, Probability_Master__c>();
        Map<Id,List<Probability_Master__c>> IdProbMap = new Map<Id,List<Probability_Master__c>>();
        Map<String , Decimal > calcMatrixValMap = new Map <String,Decimal>();
        Map<Id,String> CombinationCalcMap=new   Map<Id,String>();//combination of Max-Min floors,Project_Type__c,SWR_system_to_be_deployed__c,Material_of_Stack__c, Dimension_of_the_stack__c
        Map<Id,Id> projectDistributorMap=new  Map<Id,Id>();
        List<Discount_Master__c> discMasterList=new    List<Discount_Master__c>();
        
        
        
        Map<String,Double> distributorProductMap=new    Map<String,Double>();
        String tempData='';
        String tempData1='';
        Decimal calcValue=0;
        New_Offer_Section__c newOfferObj;
        
        
        List<New_Offer_Section__c > insertOfferList = new List<New_Offer_Section__c >();
        for(Id eachId : newOppMap.keySet()){
            internalPlumbingSet.add(newOppMap.get(eachId).Internal_Plumbing_Mix__c);
            system.debug('internalPlumbingSet'+internalPlumbingSet);
            
            materialSet.add(newOppMap.get(eachId).Material_of_Stack__c);
            system.debug('materialSet'+materialSet);
            
            swrToBeDeployedSet.add(newOppMap.get(eachId).SWR_system_to_be_deployed__c);
            system.debug('swrToBeDeployedSet'+swrToBeDeployedSet);
            
            //Creating a set for unique combination of data from each project
            propTypeSet.add(newOppMap.get(eachId).Project_Type__c);
            if(newOppMap.get(eachId).No_of_Floors__c >= 0 && newOppMap.get(eachId).No_of_Floors__c <= 18){
                CombinationCalcMap.put(eachId,newOppMap.get(eachId).Project_Type__c+'-'+newOppMap.get(eachId).SWR_system_to_be_deployed__c+'-'+newOppMap.get(eachId).Dimension_of_the_stack__c+'mm'+'-'+newOppMap.get(eachId).Material_of_Stack__c+'-'+'0-18');
            }
            if(newOppMap.get(eachId).No_of_Floors__c >= 19 && newOppMap.get(eachId).No_of_Floors__c <= 33){
                CombinationCalcMap.put(eachId,newOppMap.get(eachId).Project_Type__c+'-'+newOppMap.get(eachId).SWR_system_to_be_deployed__c+'-'+newOppMap.get(eachId).Dimension_of_the_stack__c+'mm'+'-'+newOppMap.get(eachId).Material_of_Stack__c+'-'+'19-33');
            }
            if(newOppMap.get(eachId).No_of_Floors__c >= 34 && newOppMap.get(eachId).No_of_Floors__c <= 45){
                CombinationCalcMap.put(eachId,newOppMap.get(eachId).Project_Type__c+'-'+newOppMap.get(eachId).SWR_system_to_be_deployed__c+'-'+newOppMap.get(eachId).Dimension_of_the_stack__c+'mm'+'-'+newOppMap.get(eachId).Material_of_Stack__c+'-'+'34-45');
            }
            if(newOppMap.get(eachId).No_of_Floors__c >= 46){
                CombinationCalcMap.put(eachId,newOppMap.get(eachId).Project_Type__c+'-'+newOppMap.get(eachId).SWR_system_to_be_deployed__c+'-'+newOppMap.get(eachId).Dimension_of_the_stack__c+'mm'+'-'+newOppMap.get(eachId).Material_of_Stack__c+'-'+'46-');  
            }
            
            projectDistributorMap.put(eachId,newOppMap.get(eachId).Distributor__c);
            //oppKeyCombMap.put(eachId , newOppMap.get(eachId).Internal_Plumbing_Mix__c + newOppMap.get(eachId).Material_of_Stack__c + newOppMap.get(eachId).SWR_system_to_be_deployed__c + newOppMap.get(eachId).Project_Type__c);
            
        }//for ends
        
        //Query from the discount master based on the distributors received from the projects
        discMasterList=[SELECT id,Distributor__c,Products__c,Std_APPL_Discount_Percent__c FROM Discount_Master__c WHERE Distributor__c IN: projectDistributorMap.values()];
        
        if(!discMasterList.isEmpty()){
            for(Discount_Master__c dis:discMasterList){
                if(!distributorProductMap.containsKey(dis.Distributor__c+'#'+dis.Products__c)){
                    distributorProductMap.put(dis.Distributor__c+'#'+dis.Products__c,dis.Std_APPL_Discount_Percent__c);
                }
            } 
        }
        
        
        
        
        /* 
* not reqd as entire project going for approval
* for(Id eachIds:newOppMap.keySet()){
userList=[SELECT id,Owner.Manager_ID_Approval__c FROM Opportunity  WHERE ID =: eachIds];
//system.debug('userList---'+userList);
projectManagerMap.put(eachIds,userList[0].Owner.Manager_ID_Approval__c);
system.debug('  projectManagerMap.put(eachIds,newOppMap.get(eachIds).Owner.ManagerId);'+projectManagerMap);
}
*/  
        for(Probability_Master__c eachMast : [SELECT ID,NAME,RecordTypeId,RecordType.Name,  Product_Category__c,Dimension_of_Stack__c,Internal_Plumbing_Mix__c,Material__c,Number_of_Floors_Max__c,Number_of_Floors_Min__c,Price__c,Property_Type__c,SWR_System_to_be_Deployed__c,Combination_for_calculation__c
                                              FROM Probability_Master__c WHERE (Internal_Plumbing_Mix__c IN : internalPlumbingSet )/* OR ( Material__c IN : materialSet AND SWR_System_to_be_Deployed__c IN : swrToBeDeployedSet  AND Property_Type__c IN :propTypeSet) */ 
                                              OR (Combination_for_calculation__c IN : CombinationCalcMap.Values() ) OR RecordType.Name='Project Area' OR RecordType.Name='BlazeMaster' OR RecordType.Name='Watertank' OR RecordType.Name='Grease Interceptors' OR RecordType.Name='Grease Interceptors'  OR RecordType.Name='PAPA and AAV' OR RecordType.Name='Length of Pipeline']){
                                                  
                                                  
                                                  system.debug('eachMast data--**'+eachMast.Product_Category__c+'-cost-'+ eachMast.Price__c);                                 
                                                  if(eachMast.RecordType.Name.equalsIgnoreCase('Bathroom')){
                                                      probMastMap.put(eachMast.RecordType.Name+'#'+eachMast.Product_Category__c , eachMast);
                                                      //    system.debug('probMastMap--->'+probMastMap);
                                                  }
                                                  if(eachMast.RecordType.Name.equalsIgnoreCase('Kitchen')){
                                                      probMastMap.put(eachMast.RecordType.Name+'#'+eachMast.Product_Category__c , eachMast); 
                                                  }
                                                  if(eachMast.RecordType.Name.equalsIgnoreCase('Project Area')) {
                                                      
                                                      probMastMap.put(eachMast.RecordType.Name+'#'+eachMast.Product_Category__c , eachMast); 
                                                  }
                                                  if(eachMast.RecordType.Name.equalsIgnoreCase('BlazeMaster')) {
                                                      
                                                      probMastMap.put(eachMast.RecordType.Name+'#'+eachMast.Product_Category__c , eachMast); 
                                                  } if(eachMast.RecordType.Name.equalsIgnoreCase('Watertank')) {
                                                      
                                                      probMastMap.put(eachMast.RecordType.Name+'#'+eachMast.Product_Category__c , eachMast); 
                                                  }
                                                  if(eachMast.RecordType.Name.equalsIgnoreCase('Grease Interceptors')) {
                                                      
                                                      probMastMap.put(eachMast.RecordType.Name+'#'+eachMast.Product_Category__c , eachMast); 
                                                  }
                                                  if(eachMast.RecordType.Name.equalsIgnoreCase('PAPA and AAV')) {
                                                      
                                                      probMastMap.put(eachMast.RecordType.Name+'#'+eachMast.Product_Category__c , eachMast); 
                                                  }
                                                  if(eachMast.RecordType.Name.equalsIgnoreCase('Length of Pipeline')) {
                                                      
                                                      probMastMap.put(eachMast.RecordType.Name+'#'+eachMast.Product_Category__c , eachMast); 
                                                  }
                                                  
                                              }//for ends
        // system.debug('probMastMap---'+probMastMap);
        system.debug('probMastMap.size---'+probMastMap.size());
        if(!probMastMap.isEmpty()){
            for(String str : probMastMap.keySet()){
                
                for(Id eachId : newOppMap.keySet()){
                    /*       integer c=0;
system.debug('x--->'+CombinationCalcSet.contains(probMastMap.get(str).Combination_for_calculation__c));
if(c==0){
system.debug('CombinationCalcSet--'+CombinationCalcSet);
system.debug('probMastMap.get(str).Combination_for_calculation__c--'+probMastMap.get(str).Combination_for_calculation__c);
boolean x=CombinationCalcSet.contains(probMastMap.get(str).Combination_for_calculation__c);
system.debug('x'+x);
system.debug('x-in loop-->'+CombinationCalcSet.contains(probMastMap.get(str).Combination_for_calculation__c));
}*/
                    
                    if(probMastMap.get(str).Internal_Plumbing_Mix__c == newOppMap.get(eachId).Internal_Plumbing_Mix__c 
                       ||  probMastMap.get(str).recordType.Name =='Project Area' ||  probMastMap.get(str).recordType.Name =='BlazeMaster' ||  probMastMap.get(str).recordType.Name =='Watertank' ||  probMastMap.get(str).recordType.Name =='Grease Interceptors' || probMastMap.get(str).recordType.Name =='PAPA and AAV' || probMastMap.get(str).recordType.Name =='Length of Pipeline'
                       || probMastMap.get(str).Combination_for_calculation__c == CombinationCalcMap.get(eachId)) {
                           if(!IdProbMap.isEmpty() && IdProbMap.containsKey(eachId)){
                               IdProbMap.get(eachId).add(probMastMap.get(str));
                           }
                           else{
                               IdProbMap.put(eachId , new List<Probability_Master__c>{probMastMap.get(str)});
                           }
                           
                       }//if plumbing mix condition ends
                }//inner for ends
            }//outer for ends
        }//if ends
        system.debug('IdProbMap.size---'+IdProbMap.size());
        System.debug('IdProbMap:: :: '+IdProbMap);
        if(!IdProbMap.isEmpty()){
            for(Id eachId : newOppMap.keySet()){
                if(IdProbMap.containsKey(eachId)){
                    for(Probability_Master__c each : IdProbMap.get(eachId)){
                        if(each.RecordType.Name == 'Bathroom'){
                            if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c) ){
                                calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).No_of_Bathrooms__c * each.Price__c );
                                calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
                            }
                            else{
                                calcValue = (newOppMap.get(eachId).No_of_Bathrooms__c * each.Price__c );
                                calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
                            }
                        }//bathroom ends.
                        if(each.RecordType.Name == 'Kitchen'){
                            if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c) ){
                                calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).Number_of_kitchens__c * each.Price__c );
                                
                                calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
                            }
                            else{
                                calcValue = (newOppMap.get(eachId).Number_of_kitchens__c * each.Price__c );
                                calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
                            }   
                        }//kitchen ends
                        if(each.RecordType.Name == 'Project Area'){
                            system.debug('Project Area coming....');
                            if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c) ){
                                calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).Project_Area__c * each.Price__c );
                                calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
                            }
                            else{
                                calcValue = (newOppMap.get(eachId).Project_Area__c * each.Price__c );
                                calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
                            }   
                        }//Project Area ends 
                        
                        if(each.RecordType.Name == 'BlazeMaster'){
                            if(newOppMap.get(eachId).blazeMaster__c == 'Yes'){
                                system.debug('BlazeMaster yes coming....');
                                if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c) ){
                                    calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).Average_Flat_Area_in_sq_metres__c * newOppMap.get(eachId).No_of_flats_per_floor__c *
                                                                                                               newOppMap.get(eachId).No_of_Floors__c * newOppMap.get(eachId).Number_of_towers__c * each.Price__c );
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
                                }
                                else{
                                    calcValue = (newOppMap.get(eachId).Average_Flat_Area_in_sq_metres__c * newOppMap.get(eachId).No_of_flats_per_floor__c *
                                                 newOppMap.get(eachId).No_of_Floors__c * newOppMap.get(eachId).Number_of_towers__c * each.Price__c );
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
                                }  
                            }
                            
                        }//BlazeMaster ends
                        if(each.RecordType.Name == 'Watertank'){
                            if(newOppMap.get(eachId).Water_Tank__c == 'Yes'){
                                system.debug('water tank yes coming....');
                                if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c) ){
                                    calcValue = (newOppMap.get(eachId).Quantity__c  * each.Price__c );
                                    
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
                                }
                                else{
                                    calcValue = (newOppMap.get(eachId).Quantity__c * each.Price__c );
                                    
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
                                }  
                            }
                            
                        }//water tank ends
                        if(each.RecordType.Name == 'Grease Interceptors'){
                            if(newOppMap.get(eachId).Grease_Interceptors__c == 'Yes'){
                                system.debug('Grease Interceptors yes coming....');
                                if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c) ){
                                    calcValue = (newOppMap.get(eachId).Quantit_y__c  * each.Price__c );
                                    
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
                                }
                                else{
                                    calcValue = (newOppMap.get(eachId).Quantit_y__c * each.Price__c );
                                    
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
                                }  
                            }
                            
                        }//Grease Interceptors ends
                        
                        if(each.RecordType.Name == 'Length of Pipeline'){
                            if(newOppMap.get(eachId).HDPE__c == 'Yes'){
                                system.debug('Length of Pipeline yes coming....');
                                if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c) ){
                                    calcValue = (newOppMap.get(eachId).Length_of_Pipeline_Meters__c  * each.Price__c );
                                    
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
                                }
                                else{
                                    calcValue = (newOppMap.get(eachId).Length_of_Pipeline_Meters__c * each.Price__c );
                                    
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
                                }  
                            }
                            
                        }//Length of Pipeline ends
                        system.debug('recordtype....'+each.RecordType.Name);
                        /*   if(each.RecordType.Name == 'PAPA and AAV'){
//  system.debug('eachId===>'+newOppMap.get(eachId).);
system.debug('newOppMap.get(eachId).SWR_system_to_be_deployed__c'+newOppMap.get(eachId).SWR_system_to_be_deployed__c);
if(newOppMap.get(eachId).SWR_system_to_be_deployed__c == 'Single Stack with P.A.P.A & A.A.V'){
system.debug('each.Product_Category__c'+each.Product_Category__c);
if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c)){
papaTypeCheck=eachId +'#' +each.Product_Category__c;
papaTypeCheck = papaTypeCheck.subString(papaTypeCheck.indexOf('#')+1);

if(papaTypeCheck == 'Mini-Vent'){
calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).No_of_Mini_Vent__c * each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
}
if(papaTypeCheck == 'Maxi-Filtra Cartridge'){
calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).No_of_Maxi_Filtra_Catridge__c * each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
}
if(papaTypeCheck == 'P.A.P.A'){
calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).No_of_P_A_P_A__c * each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
}
if(papaTypeCheck == 'Alumn cap for Maxi-Vent-Filtra'){
calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).No_of_Aluminum_cap_for_Maxi_Vent_Filtra__c * each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
}
if(papaTypeCheck == 'Max-Filtra'){
calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).No_of_Maxi_Filtra__c * each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
}
if(papaTypeCheck == 'Maxi-Vent'){
calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).No_of_Maxi_Vent__c * each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
}
}
else{
papaTypeCheck=eachId +'#' +each.Product_Category__c;
papaTypeCheck = papaTypeCheck.subString(papaTypeCheck.indexOf('#')+1);
if(papaTypeCheck == 'Mini-Vent'){
calcValue = (newOppMap.get(eachId).No_of_Mini_Vent__c*each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
}
if(papaTypeCheck == 'Maxi-Filtra Cartridge'){
calcValue = (newOppMap.get(eachId).No_of_Maxi_Filtra_Catridge__c*each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
}
if(papaTypeCheck == 'P.A.P.A'){
calcValue = (newOppMap.get(eachId).No_of_P_A_P_A__c*each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
}
if(papaTypeCheck == 'Alumn cap for Maxi-Vent-Filtra'){
calcValue = (newOppMap.get(eachId).No_of_Aluminum_cap_for_Maxi_Vent_Filtra__c*each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
}
if(papaTypeCheck == 'Max-Filtra'){
calcValue = (newOppMap.get(eachId).No_of_Maxi_Filtra__c*each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
}
if(papaTypeCheck == 'Maxi-Vent'){
calcValue = (newOppMap.get(eachId).No_of_Maxi_Vent__c*each.Price__c);
calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
}

}
} System.debug('calcMatrixValMap ::: '+calcMatrixValMap);

} */ //PAPA and AAV ends
                        if(each.RecordType.Name == 'PAPA and AAV'){
                            if(newOppMap.get(eachId).SWR_system_to_be_deployed__c == 'Single Stack with P.A.P.A & A.A.V'){
                                if(!calcMatrixValMap.isEmpty() && calcMatrixValMap.containsKey(eachId +'#' +each.Product_Category__c) ){
                                    calcValue = calcMatrixValMap.get(eachId +'#' +each.Product_Category__c) + (newOppMap.get(eachId).No_of_Maxi_Vent__c * each.Price__c );
                                    
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c ,calcValue);
                                }
                                else{
                                    calcValue = (newOppMap.get(eachId).No_of_Maxi_Vent__c * each.Price__c );
                                    calcMatrixValMap.put(eachId +'#' +each.Product_Category__c , calcValue );
                                }   
                            }System.debug('calcMatrixValMap ::: '+calcMatrixValMap);
                        }//PAPA ends
                    }//prob master for ends
                }//if ends
            }//outer for ends
        }//outer if ends
        
        System.debug('calcMatrixValMap ::: '+calcMatrixValMap);
        Integer pricevalidity=Integer.valueOf(System.Label.PriceValidity_days);
        if(!calcMatrixValMap.isEmpty()){
            for(String eachStr : calcMatrixValMap.keySet()){
                system.debug('eachStr-->>'+eachStr);
                tempData = eachStr.subString(0,eachStr.indexOf('#'));
                tempData1 = eachStr.subString(eachStr.indexOf('#')+1);
                if(newOppMap.containsKey(tempData)){
                    newOfferObj = new New_Offer_Section__c();
                    newOfferObj.Project__c = tempData;
                    newOfferObj.ORC_MARGIN_TO_DLR_DIST__c=newOppMap.get(tempData).Standard_ORC__c;
                    newOfferObj.MRP_Value__c =calcMatrixValMap.get(eachStr);
                    newOfferObj.Product_Name__c = tempData1;
                    if(!test.isRunningTest() ){
                        newOfferObj.Validity_for_the_Price__c=newOppMap.get(tempData).Createddate_only_date__c.addDays(pricevalidity);// customlabel-----PriceValidity_days  
                    }
                    
                    newOfferObj.APPL__c=distributorProductMap.get(projectDistributorMap.get(tempData)+'#'+tempData1)==NULL?0:distributorProductMap.get(projectDistributorMap.get(tempData)+'#'+tempData1);
                    insertOfferList.add(newOfferObj);
                    system.debug('insertOfferList--->>##'+insertOfferList);
                }
            }
        }
        System.debug('insertOfferList ::: :: '+insertOfferList);
        if(insertOfferList.size() >0 && dataType == 'ProjectInsertion'){
            system.debug('insertOfferList--->>##'+insertOfferList);
            insert insertOfferList;
            return null;
        }
        if(insertOfferList.size() >0 && dataType == 'SpecialPriceRequestInsert') {
            return insertOfferList;
        }
        else{
            return NULL;
        }
        
    }//method ends
    // the below method is called at the time of update of a project
    public static void updateCalcMatrixData(Map<Id,Opportunity> oldOppMap , Map<Id,Opportunity> newOppMap){
        system.debug('*****************************************************%%%%%%%%%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@');
        system.debug('After Update called');
        
        Integer count=0;
        List<New_Offer_Section__c> tobeUpdatedORC=new List<New_Offer_Section__c>();// to be updated list if the orc is changed in project level
        Set<Id> oppIdSet = new Set<Id>();
        Set<Id> orcChangedSet=new Set<Id>();//contains the 
        List<New_Offer_Section__c> toBeDeletedList = new List<New_Offer_Section__c>();
        if(oldOppMap != newOppMap){
            system.debug('oldOppMap != newOppMap');
            for(Id eachId : oldOppMap.keySet()){
                system.debug('oldOppMap.get(eachId).Project_Area__c---->'+oldOppMap.get(eachId).Project_Area__c);
                system.debug('newOppMap.get(eachId).Project_Area__c---->'+newOppMap.get(eachId).Project_Area__c);
                if(newOppMap.containsKey(eachId) && (oldOppMap.get(eachId).No_of_Bathrooms__c != newOppMap.get(eachId).No_of_Bathrooms__c || oldOppMap.get(eachId).Number_of_kitchens__c != newOppMap.get(eachId).Number_of_kitchens__c || oldOppMap.get(eachId).Project_Area__c != newOppMap.get(eachId).Project_Area__c || /*oldOppMap.get(eachId).OwnerId != newOppMap.get(eachId).OwnerId ||*/ oldOppMap.get(eachId).Material_of_Stack__c != newOppMap.get(eachId).Material_of_Stack__c
                                                     || oldOppMap.get(eachId).SWR_system_to_be_deployed__c != newOppMap.get(eachId).SWR_system_to_be_deployed__c || oldOppMap.get(eachId).Internal_Plumbing_Mix__c != newOppMap.get(eachId).Internal_Plumbing_Mix__c || oldOppMap.get(eachId).Dimension_of_the_stack__c != newOppMap.get(eachId).Dimension_of_the_stack__c || oldOppMap.get(eachId).Project_Type__c != newOppMap.get(eachId).Project_Type__c
                                                     || oldOppMap.get(eachId).No_of_Floors__c != newOppMap.get(eachId).No_of_Floors__c || oldOppMap.get(eachId).No_of_P_A_P_A__c != newOppMap.get(eachId).No_of_P_A_P_A__c)
                   || oldOppMap.get(eachId).No_of_Maxi_Filtra__c != newOppMap.get(eachId).No_of_Maxi_Filtra__c
                   || oldOppMap.get(eachId).No_of_Maxi_Filtra_Catridge__c != newOppMap.get(eachId).No_of_Maxi_Filtra_Catridge__c
                   || oldOppMap.get(eachId).No_of_Maxi_Vent__c != newOppMap.get(eachId).No_of_Maxi_Vent__c
                   || oldOppMap.get(eachId).No_of_Mini_Vent__c != newOppMap.get(eachId).No_of_Mini_Vent__c  || oldOppMap.get(eachId).No_of_Aluminum_cap_for_Maxi_Vent_Filtra__c!= newOppMap.get(eachId).No_of_Aluminum_cap_for_Maxi_Vent_Filtra__c                      
                   || oldOppMap.get(eachId).BlazeMaster__c != newOppMap.get(eachId).BlazeMaster__c  || oldOppMap.get(eachId).Average_Flat_Area_in_sq_metres__c!=newOppMap.get(eachId).Average_Flat_Area_in_sq_metres__c
                   || oldOppMap.get(eachId).Water_Tank__c != newOppMap.get(eachId).Water_Tank__c || oldOppMap.get(eachId).Quantity__c != newOppMap.get(eachId).Quantity__c
                   || oldOppMap.get(eachId).Grease_Interceptors__c != newOppMap.get(eachId).Grease_Interceptors__c || oldOppMap.get(eachId).Quantit_y__c != newOppMap.get(eachId).Quantit_y__c
                   || oldOppMap.get(eachId).HDPE__c != newOppMap.get(eachId).HDPE__c || oldOppMap.get(eachId).Length_of_Pipeline_Meters__c != newOppMap.get(eachId).Length_of_Pipeline_Meters__c
                   || oldOppMap.get(eachId).No_of_flats_per_floor__c != newOppMap.get(eachId).No_of_flats_per_floor__c
                  ){
                      oppIdSet.add(eachId);
                      
                      count++;
                  }//if ends 
                
                if(newOppMap.containsKey(eachId) && (oldOppMap.get(eachId).Standard_ORC__c != newOppMap.get(eachId).Standard_ORC__c)){
                    orcChangedSet.add(eachId);
                    
                }
                
                
            }//for ends
            
        }//if ends
        // compare both the sets
        if(!oppIdSet.isempty()){
            for(Id objId: oppIdSet){
                if(orcChangedSet.contains(objId))
                    orcChangedSet.remove(objId);
            }
        }
        
        
        
        for(New_Offer_Section__c eachOffer : [SELECT ID,NAME FROM New_Offer_Section__c WHERE Project__c IN : oppIdSet]){
            toBeDeletedList.add(eachOffer);
            system.debug('************toBeDeletedList size-->'+toBeDeletedList.size());
            system.debug('**************toBeDeletedList-->'+toBeDeletedList);
        }
        //system.debug('oppIdSetL1Approver.size()'+oppIdSetL1Approver.size());
        
        if(orcChangedSet.size()>0){
            system.debug('orcChangedSet-->'+orcChangedSet);
            for(New_Offer_Section__c eachOffer : [SELECT ID,NAME,Project__c,ORC_MARGIN_TO_DLR_DIST__c FROM New_Offer_Section__c WHERE Project__c IN : orcChangedSet]){
                New_Offer_Section__c newOffUpd=new New_Offer_Section__c();
                newOffUpd.id=eachOffer.id;
                newOffUpd.ORC_MARGIN_TO_DLR_DIST__c =newOppMap.get(eachOffer.Project__c).Standard_ORC__c;
                tobeUpdatedORC.add(newOffUpd);
            }
        }
        
        if(tobeUpdatedORC.size()>0){
            update tobeUpdatedORC;
        }
        if(toBeDeletedList.size() >0){
            system.debug('toBeDeletedList size-->'+toBeDeletedList.size());
            system.debug('toBeDeletedList-->'+toBeDeletedList);
            delete toBeDeletedList;
            //call the method which is being used in after insert.
            //NewOfferSectionDMLHandler.calcMatrixMap(newOppMap);
        }
        if(count > 0){
            NewOfferSectionDMLHandler.calcMatrixMap(newOppMap,'ProjectInsertion');
        }
        
        
    }
    
    
}