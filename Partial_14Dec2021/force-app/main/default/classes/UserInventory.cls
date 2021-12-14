/*  
 * Author     : Vasanthi K N
 */ 
public with sharing class UserInventory {
    public integer counter;
    public boolean renderSearch {get; set;}  
    public integer total_size{get; set;}
    public integer list_size;
    public string soql;
    public String  Userdata{get; set;}
    private ApexPages.StandardSetController controller;
    public inventory__c searchData {get; set;}
    public boolean prodrender{get; set;}
    public boolean renderNext{get; set;}
    public boolean renderPrevious{get; set;}

    public boolean samprender{get; set;}
    public boolean giftrender{get; set;}
    public boolean packrender{get; set;}
    public Integer countCombined = 0;
    public List<inventory__c> productCollateralList{get; set;}
    public List<inventory__c> giftList{get; set;}
    public List<inventory__c> sampleList{get; set;}
    public List<inventory__c> packageMaterialList{get; set;}
    public String searchText{get; set;}
   
    
    
       public UserInventory(ApexPages.StandardSetController stdcontroller) {
        this.controller = stdcontroller;
        list_size=10;
       
        counter=0;
        User user = [select profile.name from user where id =: userInfo.getUserId()];
        if(user.profile.name == 'CSO Depot' || user.profile.name == 'Warehouse' || user.profile.name == 'System Administrator'){
        renderSearch = true;
        }
        else 
        renderSearch = false;
        searchData =(inventory__c)stdcontroller.getRecord();
       
        Userdata = UserInfo.getname();

        getCollaterals();
    }

    public void getCollaterals(){
        List<inventory__c> inventoryList= new List<inventory__c>();
        productCollateralList =new List<inventory__c>();
        giftList=new List<inventory__c>();
        sampleList=new List<inventory__c>();
        packageMaterialList=new List<inventory__c>();
        string di=UserInfo.getUserid();
        soql = 'select product__C,name, Type__c,Product_Description__c, Item_Code__c,type_of_meet__c,Color_Language_Size__c, opening_stock__c, Used_Stock__c,Received_Stock__c, Closing_Stocks__c, Owner_Account__c  from inventory__c where Owner_Account__c =:di';     
        inventoryList = Database.query(soql);
      
        for(inventory__c userInventory : inventoryList){
            if(userInventory.type__c == System.Label.PRODUCT_COLLATERALS){
                productCollateralList.add(userInventory);
            }
            if(userInventory.type__c == System.Label.GIFT_ITEMS){
                giftList.add(userInventory);
            }

            if(userInventory.type__c == System.Label.SAMPLES){
                sampleList.add(userInventory);
            }

            if(userInventory.type__c == System.Label.PACKING_MATERIALS){
                packageMaterialList.add(userInventory);
            }    

        }
        
        countCombined =  productCollateralList.size() +  packageMaterialList.size();
        
        if(countCombined > 30){
        prodrender = true;
        samprender = true;
        giftrender = false;
        packrender = false;
        renderNext = true;
        }           
        else
        {
        prodrender = true;
        samprender = true;
        giftrender = true;
        packrender = true;
        renderNext = false;
        }
        
        Userdata = UserInfo.getname();

          }
   /* public PageReference Beginning() { //user clicked beginning
        
        counter1 = 0;
        counter2 = 0;
        counter3 = 0;
        counter4 = 0;

        
        if(Userdata == UserInfo.getname()){
        getCollaterals();}
        else{search();}
        
        return null;
    }

    public PageReference Previous() { //user clicked previous button
        counter1 -= list_size;
        
       if(Userdata == UserInfo.getname()){
        getCollaterals();}
        else{search();} 
        
        return null;
    }

    public PageReference Next() { //user clicked next button
        counter += list_size;
        
       if(Userdata == UserInfo.getname()){
        getCollaterals();}
        else{search();}        
        
        return null;
    }

    public PageReference End() { //user clicked end
        counter = total_size - math.mod(total_size, list_size);
        
        if(Userdata == UserInfo.getname()){
        getCollaterals();}
        else{search();}        
        
        return null;
    }

    public Boolean getDisablePrevious() { //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }

    public Boolean getDisableNext() { //this will disable the next and end buttons
        if (counter + list_size < total_size) return false; else return true;
    }

    public Integer getTotal_size() {
      return total_size;
   }
*/
    public void search(){

        List<inventory__c> inventoryList= new List<inventory__c>();
        productCollateralList =new List<inventory__c>();
        giftList=new List<inventory__c>();
        sampleList=new List<inventory__c>();
        packageMaterialList=new List<inventory__c>();
       
        String data =searchData.Owner_Account__c;
        if(data == null){
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please add the user and then click on Search'));
         data=UserInfo.getUserid();
         searchData.Owner_Account__c = data;
        }
        soql = 'select product__C,name, Type__c,Product_Description__c,type_of_meet__c, Item_Code__c,Color_Language_Size__c, opening_stock__c, Used_Stock__c,Received_Stock__c, Closing_Stocks__c, Owner_Account__c  from inventory__c where Owner_Account__c =:data';     
        inventoryList = Database.query(soql);
       // total_size =inventoryList.size();
       // soql+=' limit '+list_size+' offset '+counter ; 
       // inventoryList = Database.query(soql);

        for(inventory__c userInventory : inventoryList){
            if(userInventory.type__c == System.Label.PRODUCT_COLLATERALS){
                productCollateralList.add(userInventory);
            }
            if(userInventory.type__c == System.Label.GIFT_ITEMS){
                giftList.add(userInventory);
            }

            if(userInventory.type__c == System.Label.SAMPLES){
                sampleList.add(userInventory);
            }

            if(userInventory.type__c == System.Label.PACKING_MATERIALS){
                packageMaterialList.add(userInventory);
            }    

        }
       countCombined =  productCollateralList.size() +  packageMaterialList.size();
        
        if(countCombined > 30){
        prodrender = true;
        samprender = true;
        giftrender = false;
        packrender = false;
        renderNext = true;
        }           
        else
        {
        prodrender = true;
        samprender = true;
        giftrender = true;
        packrender = true;
        renderNext = false;
        }
        
        List<User> user =[select name from User where id =:searchData.Owner_Account__c];
        Userdata =user[0].name;
      // searchData.Owner_Account__c =null;

   
    }
    
    public void RenderNext(){
        prodrender = false;
        samprender = false;
        giftrender = true;
        packrender = true;
        renderPrevious = true;
        renderNext = false;
    }
    
     public void RenderPrevious(){
        prodrender = true;
        samprender = true;
        giftrender = false;
        packrender = false;
        renderNext= true;
    renderPrevious = false;
   
   } 
     public void searchInventory(){
     
     
        List<inventory__c> inventoryList= new List<inventory__c>();
        productCollateralList =new List<inventory__c>();
        giftList=new List<inventory__c>();
        sampleList=new List<inventory__c>();
        packageMaterialList=new List<inventory__c>();
        String usersdata =searchData.Owner_Account__c;
       if(usersdata == null){
       usersdata = userInfo.getUserId(); 
       }
        String data ='%'+searchText +'%';
        soql = 'select product__C,name, Type__c,Product_Description__c,type_of_meet__c, Color_Language_Size__c, opening_stock__c, Used_Stock__c,Received_Stock__c, Closing_Stocks__c,Item_Code__c, Owner_Account__c  from inventory__c where (product__C like :data or Type__c like :data or Item_Code__c like :data or Product_Description__c like :data) and Owner_Account__c =:usersdata'; 
        inventoryList = Database.query(soql);
       // total_size =inventoryList.size();
       // soql+=' limit '+list_size+' offset '+counter ; 
       // inventoryList = Database.query(soql);

        for(inventory__c userInventory : inventoryList){
            if(userInventory.type__c == System.Label.PRODUCT_COLLATERALS){
                productCollateralList.add(userInventory);
            }
            if(userInventory.type__c == System.Label.GIFT_ITEMS){
                giftList.add(userInventory);
            }

            if(userInventory.type__c == System.Label.SAMPLES){
                sampleList.add(userInventory);
            }

            if(userInventory.type__c == System.Label.PACKING_MATERIALS){
                packageMaterialList.add(userInventory);
            }    

        }
       countCombined =  productCollateralList.size() +  packageMaterialList.size();
        
        if(countCombined > 30){
        prodrender = true;
        samprender = true;
        giftrender = false;
        packrender = false;
        renderNext = true;
        }           
        else
        {
        prodrender = true;
        samprender = true;
        giftrender = true;
        packrender = true;
        renderNext = false;
        }
        
        searchText = null;

        }

    }