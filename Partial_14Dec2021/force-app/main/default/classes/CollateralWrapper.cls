Public class CollateralWrapper{
    public Inventory_Request__c invRequest{get;set;}
   // public Boolean disabled{get;set;}
   // public SelectOption[] selectedSubProds { get; set; }
   // public List<SelectOption> allSubProds{ get; set; }
    

    public CollateralWrapper() {
        invRequest=new Inventory_Request__c();
               // disabled=true;
       // selectedSubProds = new List<SelectOption>();
       // allSubProds= new List<SelectOption>();
    }
}