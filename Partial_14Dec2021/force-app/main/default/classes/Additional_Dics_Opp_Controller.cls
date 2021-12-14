/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :07-Jan-2015
Modified Date   :17-Feb-2015
Version         :1.0
Description     :Controller of Additional_Dics_Opp page

********************XXX***********************************/
public class Additional_Dics_Opp_Controller {
    public List<wrapperOpp> OldList{get;set;}
    public List<wrapperOpp> NewList{get;set;}
    public String OppId{get;set;}
    public Opportunity oppr{get;set;}
    public List<PricebookEntry> pbe{get;set;}
    public List<PricebookEntry> pbee{get;set;}

    public List<selectOption> productopt{get;set;}
    public String prod{get;set;}
    public String pj{get;set;}
    public String oldId{get;set{
        oldId=value;
       System.debug(value);
    }}
    
    public Boolean pbol{get;set;}
    
    public Additional_Dics_Opp_Controller(){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'To create new SPR, please select any one of the row and add as many rows to raise SPR request'));
        OldList=new List<wrapperOpp>();
        NewList=new List<wrapperOpp>();
        productopt=new List<selectOption>();
        
        OppId= Apexpages.currentPage().getParameters().get('id'); 
        oppr=[select id,Pricebook2id from opportunity where id=:OppId];
        System.debug(oppr);
        
        displaySPR s=new displaySPR();
        
        pbol=true;
        
        
        /***********************************************************/
        List<pricebook2> pd=new List<pricebook2>();
        pd.addAll([select Id,name from pricebook2 ]);
        for(Integer i=0;i<pd.size();i++){
           productopt.add(new selectOption(pd[i].Id,pd[i].name)); 
        }
        System.debug(prod);
        /********************************************************************/
        
        
        //opr=[select id,Pricebook2id from opportunity where id=:OppId ]; 
       /*
        pj=opr.Pricebook2id;
        for(Integer i=0;i<pd.size();i++){
            if(pj==pd[i].Id){
                System.debug('sameeeeeee');
                System.debug(pd[i].name);
                break;
            }
        }
        */
        List<OpportunityLineItem> oppList=new List<OpportunityLineItem>();
        oppList.addAll([SELECT Id,checked_if_Approved__C,OpportunityId,Competitor_name_offer__c,PricebookEntryId,pricebookEntry.Pricebook2Id,product2.name,MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Distributor__c,Distributor__r.name,Offer_MRP__c,APPL_Type__c,Offer_Check__c,Delivery_Start_Date__c,Delivery_End_Date__c,Competitor_name1__c,Product_Specified__c FROM OpportunityLineItem where OpportunityId =:OppId and Offer_Check__c = true]);
            if(oppList.size()>0){
                pbol=false;
            }
        for(OpportunityLineItem temp:oppList){
            wrapperOpp tmp=new wrapperOpp();
            tmp.oli=temp;
            tmp.check1=false;
            OldList.add(tmp);
            
        }
        
    }
    
    public void edit(){
        
        List<wrapperOpp> tempOldlist=new List<wrapperOpp>();
        System.debug(oldId);
        //oldId=Apexpages.currentPage().getParameters().get('oldId');
        //System.debug(oldId);
        List<String> st=new List<String>();
      
        
        for(wrapperOpp t:OldList){
            if(t.oli.Id==oldId){
                t.check1=true;
                t.pbook=t.oli.pricebookEntryId;
                //t.pbook=t.oli.priceBookEntryId;
                st.add(t.oli.pricebookEntry.Pricebook2Id);
                t.pbooklst.add(new SelectOption(t.pbook,t.oli.Product2.Name));
                NewList.add(t);
            }else{
                tempOldlist.add(t);
            }
        }
        System.debug('=======');
        System.debug(st);
        if(st.size()>1){
        pbee=[select Id,Product2Id,Pricebook2Id,Product2.Id,Product2.Name,UnitPrice from pricebookentry where isActive=true and Pricebook2Id in :st];
        }else if(st.size()==1){
            String ids=st[0];
            pbee=[select Id,Product2Id,Pricebook2Id,Product2.Id,Product2.Name,UnitPrice from pricebookentry where isActive=true and Pricebook2Id=:ids];
        }
        System.debug(pbee);
        System.debug('=======');
        oldId='';
        OldList.clear();
        OldList.addAll(tempOldlist);
    }
    
    
    public void addRow(){
        String prbook='';
        if(oppr.Pricebook2id!=null){
            prbook=oppr.Pricebook2id;
           
            pj=prbook;
        }else{
           
            pj=prod;
        }
        pbe=[select Id,Product2Id,Pricebook2Id,Product2.Id,Product2.Name,UnitPrice from pricebookentry where isActive=true and Pricebook2Id=:pj];
        System.debug(pbe);
            
       
        
        List<wrapperOpp> tempNew= new List<wrapperOpp>();
        for(wrapperOpp temp:OldList){
            if(temp.oppCheck){
                wrapperOpp wrapOBJ=new wrapperOpp ();
                
                for(pricebookentry tpb:pbe){
                    wrapOBJ.pbooklst.add(new SelectOption(tpb.Id,tpb.Product2.Name));
                }
                wrapOBJ.oli=new OpportunityLineItem();
                wrapOBJ.oli.OpportunityId=temp.oli.OpportunityId;
                wrapOBJ.oli.Competitor_name_offer__c=temp.oli.Competitor_name_offer__c;
                wrapOBJ.oli.MRP__c=temp.oli.MRP__c;
                wrapOBJ.oli.APPL_STD_Discount__c=temp.oli.APPL_STD_Discount__c;
                wrapOBJ.oli.Addl_Discount_Required__c=temp.oli.Addl_Discount_Required__c;
                wrapOBJ.oli.ORC_Margin_to_Dlr_Dist__c=temp.oli.ORC_Margin_to_Dlr_Dist__c;
                wrapOBJ.oli.Payment_Terms__c=temp.oli.Payment_Terms__c;
                wrapOBJ.oli.Delivery_Schedule__c=temp.oli.Delivery_Schedule__c;
                wrapOBJ.oli.Why_Additional_Discount__c=temp.oli.Why_Additional_Discount__c;
                wrapOBJ.oli.Validity_for_the_Price__c=temp.oli.Validity_for_the_Price__c;
                //wrapOBJ.oli.UnitPrice=temp.oli.UnitPrice;
                wrapOBJ.oli.Distributor__c=temp.oli.Distributor__c;
                wrapOBJ.oli.Offer_MRP__c=temp.oli.Offer_MRP__c;
                wrapOBJ.oli.APPL_Type__c=temp.oli.APPL_Type__c;
                wrapOBJ.oli.Offer_Check__c=temp.oli.Offer_Check__c;
                wrapOBJ.oli.Delivery_Start_Date__c=temp.oli.Delivery_Start_Date__c;
                wrapOBJ.oli.Delivery_End_Date__c=temp.oli.Delivery_End_Date__c;
                wrapOBJ.oli.Competitor_name1__c=temp.oli.Competitor_name1__c;
                wrapOBJ.oli.Product_Specified__c =temp.oli.Product_Specified__c;
              
                tempNew.add(wrapOBJ);
            }
        }
      
      
        
        
        
        
        if(tempNew.size()>0){
            NewList.addAll(tempNew);
        
        }
        else{
        System.debug(pj);
        wrapperOpp tmp=new wrapperOpp();
        tmp.oli=new OpportunityLineItem();
        tmp.oli.OpportunityId=OppId;
        System.debug(pj);
        pbe=[select Id,Product2Id,Pricebook2Id,Product2.Id,Product2.Name,UnitPrice from pricebookentry where isActive=true and Pricebook2Id=:pj];
        System.debug(pbe);
            
        for(pricebookentry tpb:pbe){
            tmp.pbooklst.add(new SelectOption(tpb.Id,tpb.Product2.Name));
        }
        tmp.check1=true;
        NewList.add(tmp);
        }
    }
    
    
    
    
    public PageReference save(){
     
     //if(NewList.size()==0){
     //    opr.Pricebook2Id=pj;
     //}else{
     //    opr.Pricebook2Id=prod;
     //}
     //update opr;
     System.debug(NewList);
     
     
     
     
     
     
     
     
    List<OpportunityLineItem> wrapOBJ=new List<OpportunityLineItem>();
    
        for(wrapperOpp temp:NewList){
            //System.debug(temp.oli.Id);
            if(temp.oli.Id==null){
                for(pricebookentry  tt:pbe){
                    if(temp.pbook==tt.Id){
                    
                        temp.oli.Offer_Check__c=true;
                        temp.oli.PricebookEntryId=tt.Id;
                        temp.oli.Quantity=temp.qty;
                        temp.oli.Totalprice=(tt.UnitPrice*temp.qty);
                        wrapOBJ.add(temp.oli);
                        break;
                        }
                }
              
            }else{
                System.debug('bbbb');
                System.debug(temp.oli.Id);
                System.debug('zzzz');
                System.debug(pbee);
                System.debug(temp.pbook);
                
                for(pricebookentry  tt:pbee){
                    if(temp.pbook==tt.Id){
                        
                        
                        //temp.oli.PricebookEntryId=tt.Id;
                       
                        temp.oli.Offer_Check__c=true;
                        temp.oli.Quantity=temp.qty;
                        temp.oli.Totalprice=(tt.UnitPrice*temp.qty);
                        wrapOBJ.add(temp.oli);
                        System.debug(wrapOBJ);
                        break;
                    }
                }
            }
           
      
      
      /*
           */
              
        }
        System.debug(wrapOBJ);
        //if(wrapOBJ.size()>0)
      /*  
        boolean bol=false;
         boolean bol1=false;
        Integer count=0;
        Integer count1=0;
     for(Integer i=0;i<NewList.size();i++){
         wrapperOpp temp=NewList[i];
         count=0;
        
         for(Integer j=0;j<OldList.size();j++){
             if(temp.oli.Competitor_name_offer__c==OldList[j].oli.Competitor_name_offer__c && temp.oli.PricebookEntryId==OldList[j].oli.PricebookEntryId && temp.oli.pricebookEntry.Pricebook2Id==OldList[j].oli.pricebookEntry.Pricebook2Id && temp.oli.product2.name==OldList[j].oli.product2.name && temp.oli.MRP__c==OldList[j].oli.MRP__c && temp.oli.APPL_STD_Discount__c==OldList[j].oli.APPL_STD_Discount__c && temp.oli.Validity_for_the_Price__c==OldList[j].oli.Validity_for_the_Price__c && temp.oli.UnitPrice==OldList[j].oli.UnitPrice && temp.oli.Distributor__c==OldList[j].oli.Distributor__c && temp.oli.Offer_MRP__c==OldList[j].oli.Offer_MRP__c && temp.oli.APPL_Type__c==OldList[j].oli.APPL_Type__c && temp.oli.Offer_Check__c==OldList[j].oli.Offer_Check__c && temp.oli.Delivery_Start_Date__c==OldList[j].oli.Delivery_Start_Date__c && temp.oli.Delivery_End_Date__c==OldList[j].oli.Delivery_End_Date__c && temp.oli.Competitor_name1__c==OldList[j].oli.Competitor_name1__c && temp.oli.Product_Specified__c==OldList[j].oli.Product_Specified__c){
                 count++;
             }
         }
         for(Integer j=0;j<NewList.size();j++){
             if(temp.oli.Competitor_name_offer__c==NewList[j].oli.Competitor_name_offer__c && temp.oli.PricebookEntryId==NewList[j].oli.PricebookEntryId && temp.oli.pricebookEntry.Pricebook2Id==NewList[j].oli.pricebookEntry.Pricebook2Id && temp.oli.product2.name==NewList[j].oli.product2.name && temp.oli.MRP__c==NewList[j].oli.MRP__c && temp.oli.APPL_STD_Discount__c==NewList[j].oli.APPL_STD_Discount__c && temp.oli.Validity_for_the_Price__c==NewList[j].oli.Validity_for_the_Price__c && temp.oli.UnitPrice==NewList[j].oli.UnitPrice && temp.oli.Distributor__c==NewList[j].oli.Distributor__c && temp.oli.Offer_MRP__c==NewList[j].oli.Offer_MRP__c && temp.oli.APPL_Type__c==NewList[j].oli.APPL_Type__c && temp.oli.Offer_Check__c==NewList[j].oli.Offer_Check__c && temp.oli.Delivery_Start_Date__c==NewList[j].oli.Delivery_Start_Date__c && temp.oli.Delivery_End_Date__c==NewList[j].oli.Delivery_End_Date__c && temp.oli.Competitor_name1__c==NewList[j].oli.Competitor_name1__c && temp.oli.Product_Specified__c==NewList[j].oli.Product_Specified__c){
                 count++;
             }
         }
         
        
         
         
     }*/
     
     //test
     for(OpportunityLineItem wp:wrapOBJ){

                    System.debug('1111111111Loop Working'+ wrapOBJ.size());
                   // if(wp.check == true)

                     {

                      if(wp.APPL_STD_Discount__c != null && 
                        wp.Addl_Discount_Required__c  != null && 
                        wp.ORC_Margin_to_Dlr_Dist__c != null && 
                        wp.Delivery_Start_Date__c != null &&
                        wp.Delivery_End_Date__c  != null &&
                        wp.Competitor_name_Offer__c  != null &&
                        wp.Distributor__c  != null &&
                        wp.Product_Specified__c   != null &&
                        wp.Payment_Terms__c != null &&
                        wp.Delivery_Schedule__c != null &&
                        wp.Why_Additional_Discount__c != null &&
                        wp.Validity_for_the_Price__c  != null &&
                        wp.Quantity!= null &&
                         wp.Quantity>0 ){

                        //spr_Flag = true;
                            //wp.Special_Pricing_Request_Check__c = true;
                           // wrapOBJ.add(wp.oli);
                           
                        }

                        else {
                            //wrapOpp.clear();
                            if( wp.Quantity<=0){
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter quantity for selected products'));
                            }else{
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                            }
                            return null;

                        }

                    }
     //test ends here
        
    }
        
            //insert wrapOBJ;
            try{
            System.debug('aaa');
            System.debug(wrapOBJ);
            upsert wrapOBJ;
            }catch(exception e){
            system.debug('error in upsertion'+e.getMessage()+'at Line Number'+e.getLineNumber());
            }
           
        return new PageReference('/'+OppId);
        
    }
    
//--------from lookuppopup page controller------------------------------------------------
   // the query string entered by the user
    public String query {get; set;}
    public string dpacc{get;set;}
    // the matchin>g accounts
    public List<Account> accounts {get; set;}
    
    // has a search been executed?
    public Boolean doneLookup {get; set;}
    
    
    
    // executes the search
    public void runQuery()
    {   System.debug('coming inside');
        accounts  = new List<Account>();
         query = query.trim();
         String nameCond = '%'+query+'%';
         String cond = query+'%';
        List<Account> searchResults= New List<Account>([SELECT Id,Name,District__c,city__c, State__c, Status__c,Contact_Number_Mobile__c, Party_type__c FROM Account WHERE status__c ='Existing' AND Party_Type__c = 'Distributor' AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR Contact_Number_Mobile__c LIKE :cond ) limit 999]);
           
        accounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +accounts);
        
    }
    //------------------------------------------------------
    
    
    public class wrapperOpp {
        public OpportunityLineItem oli {get;set;}
        public Boolean check {get;set;}
        public Boolean check1{get;set;}
        public String pbook{get;set;}
        public List<SelectOption> pbooklst{get;set;}
        public Integer unit{get;set;}
        public Integer qty{get;set;}
        public boolean oppCheck{get;set;}
        public boolean editrec{get;set;}
       public wrapperOpp() {
       
            this.pbooklst=new List<SelectOption>();
            this.check = true;
            this.check1=true; 
            this.editrec=false;
            oppCheck=false;
            qty=0;
            unit=0;
        }
    }   
}