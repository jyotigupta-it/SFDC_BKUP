trigger Accountshare on Share__c (after insert) {
    map<Id,List<Share__c>> mapParentAccountUser = new map<Id,List<Share__c>>();
    
    map<Id,List<Share__c>> mapParentAccUpdate = new map<Id,List<Share__c>>();
    
    List<Account> lstAcc = new List<Account>();
    List<AccountShare> lstShares = new List<AccountShare>();
    
    for(Share__c  s: Trigger.New){
        if(mapParentAccountUser.containsKey(s.Account__c)){
            mapParentAccountUser.get(s.Account__c).add(s);
        }
        else{                   
            mapParentAccountUser.put(s.Account__c,new List<Share__c>{s});
        }
    }
    System.debug('@@@@@mapParentAccountUser@@@@@@'+mapParentAccountUser);
    lstAcc = [SELECT Id,Name,Parentid,OwnerId from Account where Parentid IN: mapParentAccountUser.KeySet() OR Id IN:mapParentAccountUser.KeySet()];
    System.debug('@@@@@lstAcc@@@@@@'+lstAcc);
    for(Account a:lstAcc){
        if(mapParentAccountUser.containsKey(a.Parentid)){
            for(Share__c s: mapParentAccountUser.get(a.Parentid)){
                if(s.User__c!=a.OwnerId)
                {
                    AccountShare share = new AccountShare();
                    share.AccountId = a.Id;
                    share.UserOrGroupId = s.User__c;
                    share.AccountAccessLevel= s.Account_Access__c;
                    share.OpportunityAccessLevel=s.Account_Access__c;
                    lstShares.add(share);
                }
            }
        }
        else{
            for(Share__c s: mapParentAccountUser.get(a.Id)){
                if(s.User__c!=a.OwnerId)
                {
                    AccountShare share = new AccountShare();
                    share.AccountId = a.Id;
                    share.UserOrGroupId = s.User__c;
                    share.AccountAccessLevel=s.Account_Access__c;
                    share.OpportunityAccessLevel=s.Account_Access__c;
                    lstShares.add(share);
                }
            }
        }   
    }
    System.debug('@@@@@lstShares@@@@@@'+lstShares);
    if(!lstShares.isEmpty()){
        insert lstShares ;
    }
}