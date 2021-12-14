/***************************************************
* Name:SudhaMurthy
* Description: Class to send chatter post on user's birthday and anniversary
* Controller:AnniversayBirthydayChatter 
* created date :20/06/2019***********************/


global class AnniversayBirthydayChatter implements Schedulable{
    
    
    global void execute(SchedulableContext sc) {
        
        List<user> lstbirthday=[Select id,name,UserRole.name,User_State__c,Title,Division,Vertical_Type__c  from user where IS_birthday_today__c=true and isactive=true];// query on birthday of users
        
        List<user> lstanniversary=[Select id,name,UserRole.name,User_State__c,Title,Division,Vertical_Type__c from user where IS_Anniversary_today__c=true and isactive=true];//query of anniversary of users
        
        list<FeedItem> postlist1= new list<FeedItem>();
        list<FeedItem> postlist2= new list<FeedItem>();
        
        for(User u:lstbirthday){
            FeedItem post = new FeedItem(); // chatter instance creation
            
            post.ParentId = u.id;
            
            post.Body = 'Join together in wishing a very Happy Birthday to '+'-'+u.name +'-'+u.Title+'-'+u.Division+'-'+u.Vertical_Type__c;
            postlist1.add(post);
            
        }
        if(postlist1.size()>0 && postlist1!=null){
            insert postlist1;
        }
        for(User u:lstanniversary){
            FeedItem post = new FeedItem();// chatter instance creation
            
            post.ParentId = u.id;
            
            post.Body = 'Ashirvad Family wishes you both a very happy anniversary. Wish you both lot of happiness & good health'+'-'+'Mr & Mrs'+'.'+u.name+'-' +u.Title+'-'+u.Division+'-'+u.Vertical_Type__c;
            postlist2.add(post);
            
        }
        if(postlist2.size()>0 && postlist2!=null){ //check for list size
            insert postlist2;
        }
        
    }
}