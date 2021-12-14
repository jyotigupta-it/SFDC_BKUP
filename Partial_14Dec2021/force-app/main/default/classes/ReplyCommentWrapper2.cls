public with sharing class ReplyCommentWrapper2 {
    
    @AuraEnabled
    public List<IdeaComment> IdeaComment { get; set; }
    @AuraEnabled
    
    public List<Reply_to_Comment_Object__c> ideaCommentList { get; set; }
    
    public ReplyCommentWrapper2(List<IdeaComment> IdeaComments, List<Reply_to_Comment_Object__c> ideaCommentslist){
       
        if (Test.isRunningTest()){
            this.IdeaComment = IdeaComments;
        this.ideaCommentList = ideaCommentslist;
    }
    }}