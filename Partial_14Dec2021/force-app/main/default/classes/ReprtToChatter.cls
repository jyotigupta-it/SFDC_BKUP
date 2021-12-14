/***************************************************
* Name:SudhaMurthy
* Description: Class to send chatter post ,onclick to report of dealer/distributor anniversary and birthday
* Controller:ReprtToChatter 
* created date :29/07/2019***********************/

global class ReprtToChatter implements Schedulable{
  User userlist =[select id,name from user where name='Ashirvad Pipes' limit 1];
     global void execute(SchedulableContext sc) {
         
        list<feeditem> postlist= new list<feeditem>();
            FeedItem post = new FeedItem(); // create a chatter instance
            //post.ParentId = userlist.id;
            post.ParentId = '00530000003m5lD';
            post.Body = 'Anniversary of Dealer and distributor';
            post.LinkUrl=URL.getSalesforceBaseUrl().toExternalForm() + '/' + '00O30000008SigW'; // onclick goes to report
            post.Title = 'Please click here to see  Dealer and Distributor Anniversary details';
            postlist.add(post);  
         
         try{
             if(!postlist.IsEmpty()){ // check for null
                     insert postlist; // insert chatter post
                 }
             }catch(exception e1){
             system.debug('exception1...'+e1);
             }
             
             list<feeditem> postlist2= new list<feeditem>();
            FeedItem post2 = new FeedItem(); 
            //post.ParentId = userlist.id;
            post2.ParentId = '00530000003m5lD';
            post2.Body = 'Birthday of Dealer and distributor';
            post2.LinkUrl=URL.getSalesforceBaseUrl().toExternalForm() + '/' + '00O30000008SigM';
            post2.Title = 'Please click here to see  Dealer and Distributor Birthday details';
            postlist2.add(post2);  
         
         try{
             if(!postlist2.IsEmpty()){ // check for null
                     insert postlist2; // insert chatter post
                 }
             }catch(exception e2){
             system.debug('exception1...'+e2);
             }
    
     }
}