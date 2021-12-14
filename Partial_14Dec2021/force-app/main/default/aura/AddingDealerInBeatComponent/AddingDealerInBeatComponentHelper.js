({
    /* doInitHelper funcation to fetch all records, and set attributes value on component load */
    doInitHelper : function(component,event, helper){ 
        component.set('v.loaded',true);
        var action = component.get("c.fetchAccountWrapper");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var oRes = response.getReturnValue();
                console.log('oRes'+oRes);
                if(oRes != null){
                    component.set('v.access',true);
                    if(oRes.length > 0){
                        component.set('v.listOfAllAccounts', oRes);
                        var pageSize = component.get("v.pageSize");
                        var totalRecordsList = oRes;
                        var totalLength = totalRecordsList.length ;
                        component.set("v.totalRecordsCount", totalLength);
                        component.set("v.startPage",0);
                        component.set("v.endPage",pageSize-1);
                        component.set("v.filterlist",oRes);
                        
                        var PaginationLst = [];
                        for(var i=0; i < pageSize; i++){
                            if(component.get("v.listOfAllAccounts").length > i){
                                PaginationLst.push(oRes[i]);    
                            } 
                        }
                        component.set('v.PaginationList', PaginationLst);
                        component.set("v.selectedCount" , 0);
                        //use Math.ceil() to Round a number upward to its nearest integer
                        component.set("v.totalPagesCount", Math.ceil(totalLength / pageSize));    
                    }else{
                        // if there is no records then display message
                        component.set("v.bNoRecordsFound" , true);
                    } 
                    component.set('v.loaded',false);
                    
                }else{
                    component.set('v.access',false);
                    component.set('v.loaded',false);
                    
                    console.log('Beyond the Date')
                }
                
            }
            else{
                alert('Error...');
                component.set('v.loaded',false);
                
            }
        });
        $A.enqueueAction(action);  
    },
    
    onSearch1 : function(component,event){ 
        component.set('v.loaded',true);
        
        var temp=component.get('v.listOfAllAccounts');
        // component.set('v.allSelected', oRes.selectedIds);
        var name = component.get('v.sTemp');
        var filteredList =[];
        var temp1;
        var lengthOfArray = temp.length;
        for(var i=0;i<lengthOfArray;i++){
            //temp1 = temp[i].objAccount.Name.toLowerCase()+temp[i].objAccount.City__c!=undefined?temp[i].objAccount.City__c:''+temp[i].objAccount.Sparsh_Code__c!=undefined?temp[i].objAccount.Sparsh_Code__c:''+temp[i].objAccount.Contact_Number_Mobile__c!=undefined?temp[i].objAccount.Contact_Number_Mobile__c.toLowerCase():'';
            if(temp[i].searchField.toLowerCase().includes(name.toLowerCase())){
                filteredList.push(temp[i]);  
            }
        }
        console.log('filteredList'+filteredList);
        component.set("v.filterlist",filteredList);
        component.set("v.currentPage", 1);
        
        var pageSize = component.get("v.pageSize");
        var totalRecordsList = filteredList;
        var totalLength = filteredList.length ;
        component.set("v.totalRecordsCount", totalLength);
        component.set("v.startPage",0);
        component.set("v.endPage",pageSize-1);
        
        var PaginationLst = [];
        for(var i=0; i < pageSize; i++){
            if(filteredList.length > i){
                PaginationLst.push(filteredList[i]);    
            } 
        }
        component.set('v.PaginationList', PaginationLst);
        //component.set("v.selectedCount" , 0);
        //use Math.ceil() to Round a number upward to its nearest integer
        component.set("v.totalPagesCount", Math.ceil(totalLength / pageSize));
        var getSelectedNumber = component.get("v.selectedCount");
        console.log('getSelectedNumber'+getSelectedNumber);
        
        console.log('component.get("v.totalRecordsCount")'+component.get("v.totalRecordsCount"));
        //  if (getSelectedNumber == component.get("v.totalRecordsCount")) {
        //  console.log(JSON.stringify(PaginationLst));
        for(var i=0;i<filteredList.length;i++){
            if(filteredList[i].isChecked==true){
                component.find("selectAllId").set("v.value", true);
            }
            // console.log(JSON.stringify(PaginationLst));
        }
        for(var i=0;i<filteredList.length;i++){
            if(filteredList[i].isChecked==false){
                component.find("selectAllId").set("v.value", false);
            }
            // console.log(JSON.stringify(PaginationLst));
            
        }
        console.log('getSelectedNumber'+getSelectedNumber);
        component.set('v.loaded',false);
        
        
    },
    // navigate to next pagination record set   
    next : function(component,event,sObjectList,end,start,pageSize){
        component.set('v.loaded',true);
        
        var Paginationlist = [];
        var counter = 0;
        for(var i = end + 1; i < end + pageSize + 1; i++){
            if(sObjectList.length > i){ 
                if(component.find("selectAllId").get("v.value")){
                    Paginationlist.push(sObjectList[i]);
                }else{
                    Paginationlist.push(sObjectList[i]);  
                }
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.PaginationList', Paginationlist);
        component.set('v.loaded',false);
        
    },
    // navigate to previous pagination record set   
    previous : function(component,event,sObjectList,end,start,pageSize){
        component.set('v.loaded',true);
        
        var Paginationlist = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                if(component.find("selectAllId").get("v.value")){
                    Paginationlist.push(sObjectList[i]);
                }else{
                    Paginationlist.push(sObjectList[i]); 
                }
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.PaginationList', Paginationlist);
        component.set('v.loaded',false);
        
    },
    showToast : function(component, event, helper, title, toastMessage, type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title" : title,
            "message" : toastMessage,
            "type" : type
        });
        toastEvent.fire();
    },
    
})