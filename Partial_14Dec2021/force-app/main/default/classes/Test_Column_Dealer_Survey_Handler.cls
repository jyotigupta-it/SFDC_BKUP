@isTest
public class Test_Column_Dealer_Survey_Handler {
     @isTest static void columntest(){
         Test.startTest();
         //Column_Dealer_Survey_Handler  col= new Column_Dealer_Survey_Handler ();
         //Id RecordTypeIdCol = Schema.SObjectType.Column_dealer_Survey__c.getRecordTypeInfosByName().get('DeveloperNameOfRecordType').getRecordTypeId();
         Column_dealer_Survey__c col2 = new Column_dealer_Survey__c ();
         list<Column_dealer_Survey__c> col= new list<Column_dealer_Survey__c>();
         insert col;
         
         Column_Dealer_Survey_Handler.getOtherPickListValues('Conversion_Time_From_GI_to_Column__c');
         Column_Dealer_Survey_Handler.getOtherPickListValues('Credit_Facility_given_to_dealer_by_Pipe__c');
         Column_Dealer_Survey_Handler.getOtherPickListValues('Electricity_connection__c');
         Column_Dealer_Survey_Handler.getOtherPickListValues('Hdpe_fast_moving_Size_Inch__c');
          Column_Dealer_Survey_Handler.getOtherPickListValues('Fast_Moving_Size__c');
          Column_Dealer_Survey_Handler.getOtherPickListValues('Color_of_tank__c');
          Column_Dealer_Survey_Handler.getOtherPickListValues('Agri_fast_moving_Size_Inch__c');
         Column_Dealer_Survey_Handler.getOtherPickListValues('Casting_fast_moving_Size_Inch__c');
         Column_Dealer_Survey_Handler.getOtherPickListValues('Column_fast_moving_Size_Inch__c');
         Column_Dealer_Survey_Handler.getDependentMap(col2,'Product_sold_by_dealer__c','Name_of_Brands__c');
         Column_Dealer_Survey_Handler.decimalToBinary(1234);
         Column_Dealer_Survey_Handler.base64ToBits('test');
         Column_Dealer_Survey_Handler.getFieldLabelNameAndApi();
         Column_Dealer_Survey_Handler.abc();
         Column_Dealer_Survey_Handler.saveColumnRecords(col );
         

     }
}