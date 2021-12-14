public class ReplyCommentController {
 @AuraEnabled
    public static ReplyCommentWrapper2 displayCommentDetails(String ideaId){
        ReplyCommentWrapper2 responseWrapper;
        List<IdeaComment> comment = new List<IdeaComment>();
        comment = [Select Id, CommentBody, UpVotes, CreatorName, CreatedDate From IdeaComment Where Id=:ideaId];
        System.debug('comment' +comment);
        List<Reply_to_Comment_Object__c> commentList=new List<Reply_to_Comment_Object__c>();
        commentList = [Select Id, Comment_Reply__c From Reply_to_Comment_Object__c Where CommentId__c =: ideaId];
        responseWrapper = new ReplyCommentWrapper2(comment, commentList);
        return responseWrapper;
    }
    @AuraEnabled
    public static List<Ideacomment> CommentsDetails(String ideaId){
      List<IdeaComment> comment = new List<IdeaComment>();
        comment = [Select Id, CommentBody, UpVotes, CreatorName, CreatedDate From IdeaComment Where Id=:ideaId];
        return comment;
    }
    @AuraEnabled
    public Static String postComment(String ideaId, String commentBody){
        Reply_to_Comment_Object__c comment = new Reply_to_Comment_Object__c();
        comment.CommentId__c = ideaId;
        comment.Comment_Reply__c = commentBody;
          if(Schema.sObjectType.IdeaComment.fields.IdeaId.isCreateable() && 
            Schema.sObjectType.IdeaComment.fields.CommentBody.isCreateable())
        insert comment;
        return null;
    }
    @AuraEnabled
    public static void deleteIdea(String ideaId){
       List<Idea> idea =new List<Idea>();
           if(Schema.SObjectType.Idea.isQueryable() && 
        Schema.sObjectType.Idea.fields.ID.isAccessible() &&
      Schema.sObjectType.Idea.fields.Title.isAccessible() &&
      Schema.sObjectType.Idea.fields.Body.isAccessible()&&
      Schema.sObjectType.Idea.fields.Categories.isAccessible() &&
      Schema.sObjectType.Idea.fields.CreatorName.isAccessible() &&
      Schema.sObjectType.Idea.fields.NumComments.isAccessible() &&
      Schema.sObjectType.Idea.fields.CommunityId.isAccessible() &&
       Schema.sObjectType.Idea.fields.CreatedDate.isAccessible())
        idea= [Select Id, Title, Body, Categories, CreatorName, NumComments From Idea Where Id=:ideaId];
       IF(Schema.sObjectType.Idea.isDeletable())
        delete idea;
        
    }
    @AuraEnabled
    public static void deletecommentFromIdea(String commentId){
      List<IdeaComment> comment=new List <IdeaComment> ();
       if(Schema.SObjectType.IdeaComment.isQueryable()&& 
            Schema.sObjectType.IdeaComment.fields.Id.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.CommentBody.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.UpVotes.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.CreatorName.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.IdeaId.isAccessible())
           comment = [Select Id, CommentBody, UpVotes, CreatorName, CreatedDate From IdeaComment Where id =: commentId];
       IF(Schema.sObjectType.IdeaComment.isDeletable())
        delete comment;
        
    }
    

}