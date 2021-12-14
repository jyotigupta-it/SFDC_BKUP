public class ViewIdeaController {
    @AuraEnabled
    public static ViewIdeaWrapper displayIdeaDetails(String ideaId){
        ViewIdeaWrapper responseWrapper;
        Idea idea=new Idea();
        if(Schema.SObjectType.Idea.isQueryable() && 
        Schema.sObjectType.Idea.fields.ID.isAccessible() &&
      Schema.sObjectType.Idea.fields.Title.isAccessible() &&
      Schema.sObjectType.Idea.fields.Body.isAccessible()&&
      Schema.sObjectType.Idea.fields.Categories.isAccessible() &&
      Schema.sObjectType.Idea.fields.CreatorName.isAccessible() &&
      Schema.sObjectType.Idea.fields.NumComments.isAccessible() &&
      Schema.sObjectType.Idea.fields.CommunityId.isAccessible() &&
       Schema.sObjectType.Idea.fields.CreatedDate.isAccessible())
        idea = [Select Id, Title, Body, Categories, CreatorName, NumComments From Idea Where Id=:ideaId];
        List<IdeaComment> commentList=new List<IdeaComment>();
         if(Schema.sObjectType.IdeaComment.fields.Id.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.CommentBody.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.UpVotes.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.CreatorName.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.CreatedDate.isAccessible())
        commentList = [Select Id, CommentBody, UpVotes, CreatorName, CreatedDate From IdeaComment Where IdeaId =: ideaId];
        responseWrapper = new ViewIdeaWrapper(idea, commentList);
        return responseWrapper;
    }
    
    @AuraEnabled
    public Static String postComment(String ideaId, String commentBody){
        IdeaComment comment = new IdeaComment();
        comment.IdeaId = ideaId;
        comment.CommentBody = commentBody;
          if(Schema.sObjectType.IdeaComment.fields.IdeaId.isCreateable() && 
            Schema.sObjectType.IdeaComment.fields.CommentBody.isCreateable())
        insert comment;
        return null;
    }
    @AuraEnabled
    public static void deleteIdea(String ideaId){
        Idea idea =new Idea();
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
    public static String deletecommentFromIdea(String commentId){
        list<IdeaComment> comment = new list<IdeaComment> ();
       if(Schema.SObjectType.IdeaComment.isQueryable()&& 
            Schema.sObjectType.IdeaComment.fields.Id.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.CommentBody.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.UpVotes.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.CreatorName.isAccessible() &&
        Schema.sObjectType.IdeaComment.fields.IdeaId.isAccessible())
           comment = [Select Id,IdeaId, CommentBody, UpVotes, CreatorName, CreatedDate From IdeaComment Where id =: commentId];
       System.debug('Comment : '+comment);
       IF(Schema.sObjectType.IdeaComment.isDeletable())
        delete comment;
         return 'Success';
    }
    
}