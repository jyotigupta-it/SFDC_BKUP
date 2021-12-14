/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:class for creating a quiz chatter post
 ****************************************************************************************/ 
public  class createQuizChatter {

// variable Declaration
public String thisMonth; 
public autoRequestBatchHelper autoRequest;

/**
 * Name: createQuizChatter 
 * Params: None
 * Description: Constructor for initializing variables
 */
public createQuizChatter() {
try{
    autoRequest = new autoRequestBatchHelper(); 
    thisMonth = autoRequest.getCurrentMonth();
    chatterpost();
    
}Catch(Exception e){
     system.debug('Exception Occured'+e.getMessage());
 }
}

/**
 * Name: chatterpost
 * Params: None
 * Description: Method for creating chatter post
 */
public void chatterpost() {
try{
    List<Quiz_Attendee__c> agriSeniorList =  new List<Quiz_Attendee__c >();
agriSeniorList=[select Quiz_Attendee__c,Quiz_Catagory__c,Percentage__c,id FROM Quiz_Attendee__c 
          where Quiz_Catagory__c='Agriculture Senior' and Quiz_status__c='Completed' and Quiz_Month__c=:thisMonth
          order by Percentage__c desc limit 3];
List<Quiz_Attendee__c> agriJuniorList =  new List<Quiz_Attendee__c >();
agriJuniorList=[select Quiz_Attendee__c,Quiz_Catagory__c,Percentage__c,id FROM Quiz_Attendee__c 
          where Quiz_Catagory__c='Agriculture Junior' and Quiz_status__c='Completed' and Quiz_Month__c=:thisMonth
                order by Percentage__c desc limit 3];
List<Quiz_Attendee__c> plumJuniorList =  new List<Quiz_Attendee__c >();
plumJuniorList=[select Quiz_Attendee__c,Quiz_Catagory__c,Percentage__c,id FROM Quiz_Attendee__c 
          where Quiz_Catagory__c='Plumbing Junior' and Quiz_status__c='Completed' and Quiz_Month__c=:thisMonth
                order by Percentage__c desc limit 3];
List<Quiz_Attendee__c> plumSeniorList =  new List<Quiz_Attendee__c >();
plumSeniorList=[select Quiz_Attendee__c,Quiz_Catagory__c,Percentage__c,id FROM Quiz_Attendee__c 
          where Quiz_Catagory__c='Plumbing Senior' and Quiz_status__c='Completed' and Quiz_Month__c=:thisMonth
                order by Percentage__c desc limit 3];
    
//Post to chatter
if(agriSeniorList.size()==0 && agriJuniorList.size()==0 && plumJuniorList.size()==0 && plumSeniorList.size()==0){
}  
else{
ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

mentionSegmentInput.id = System.Label.Quiz_Chatter_Group_Id;
messageBodyInput.messageSegments.add(mentionSegmentInput);


textSegmentInput.text = '\nHi All, Please find top scorers of the month '+thisMonth+' for the quiz taken in below categories. Congratulations to All!\n';
messageBodyInput.messageSegments.add(textSegmentInput);
if(agriSeniorList.size()!=0){
ConnectApi.TextSegmentInput textSegmentInput1 = new ConnectApi.TextSegmentInput();
textSegmentInput1.text='Top scorers for Agriculture Senior are : \n';
messageBodyInput.messageSegments.add(textSegmentInput1);
for(Quiz_Attendee__c agriSenior: agriSeniorList){
   ConnectApi.MentionSegmentInput mentionSegmentInputNew = new ConnectApi.MentionSegmentInput(); 
   mentionSegmentInputNew.id = agriSenior.Quiz_Attendee__c; 
   messageBodyInput.messageSegments.add(mentionSegmentInputNew);
   ConnectApi.TextSegmentInput textSegmentInputNew = new ConnectApi.TextSegmentInput();
   textSegmentInputNew.text=' - '+agriSenior.Percentage__c+'%'+' ';
   messageBodyInput.messageSegments.add(textSegmentInputNew);
} 
}
if(agriJuniorList.size()!=0){
ConnectApi.TextSegmentInput textSegmentInput2 = new ConnectApi.TextSegmentInput();
textSegmentInput2.text='\nTop scorers for Agriculture Junior are : \n';
messageBodyInput.messageSegments.add(textSegmentInput2);
for(Quiz_Attendee__c agriJunior: agriJuniorList){
   ConnectApi.MentionSegmentInput mentionSegmentInputNew = new ConnectApi.MentionSegmentInput(); 
   mentionSegmentInputNew.id = agriJunior.Quiz_Attendee__c; 
   messageBodyInput.messageSegments.add(mentionSegmentInputNew);
   ConnectApi.TextSegmentInput textSegmentInputNew = new ConnectApi.TextSegmentInput();
   textSegmentInputNew.text=' - '+agriJunior.Percentage__c+'%'+' ';
   messageBodyInput.messageSegments.add(textSegmentInputNew);
}
}
if(plumJuniorList.size()>0){
ConnectApi.TextSegmentInput textSegmentInput3 = new ConnectApi.TextSegmentInput();
textSegmentInput3.text='\nTop scorers for Plumbing Junior are :\n ';
messageBodyInput.messageSegments.add(textSegmentInput3);
for(Quiz_Attendee__c plumJunior: plumJuniorList){
   ConnectApi.MentionSegmentInput mentionSegmentInputNew = new ConnectApi.MentionSegmentInput(); 
   mentionSegmentInputNew.id = plumJunior.Quiz_Attendee__c; 
   messageBodyInput.messageSegments.add(mentionSegmentInputNew);
   ConnectApi.TextSegmentInput textSegmentInputNew = new ConnectApi.TextSegmentInput();
   textSegmentInputNew.text=' - '+plumJunior.Percentage__c+'%'+' ';
   messageBodyInput.messageSegments.add(textSegmentInputNew);
} 
}

if(plumSeniorList.size()>0){
ConnectApi.TextSegmentInput textSegmentInput4 = new ConnectApi.TextSegmentInput();
textSegmentInput4.text='\nTop scorers for Plumbing Senior are :\n ';
messageBodyInput.messageSegments.add(textSegmentInput4);
for(Quiz_Attendee__c plumSenior: plumSeniorList){
   ConnectApi.MentionSegmentInput mentionSegmentInputNew = new ConnectApi.MentionSegmentInput(); 
   mentionSegmentInputNew.id = plumSenior.Quiz_Attendee__c; 
   messageBodyInput.messageSegments.add(mentionSegmentInputNew);
   ConnectApi.TextSegmentInput textSegmentInputNew = new ConnectApi.TextSegmentInput();
   textSegmentInputNew.text=' - '+plumSenior.Percentage__c+'%'+' ';
   messageBodyInput.messageSegments.add(textSegmentInputNew);
}
}


feedItemInput.body = messageBodyInput;
feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
feedItemInput.subjectId = 'me';

ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), feedItemInput, null);
}   
}Catch(Exception e){
     system.debug('Exception Occured'+e.getMessage());
 }
}


}