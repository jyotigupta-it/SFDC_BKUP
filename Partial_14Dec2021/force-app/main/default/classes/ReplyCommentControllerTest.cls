@isTest
public class ReplyCommentControllerTest {
    /*@isTest
    static void replyCommentTest()
    {
        Idea idea = new Idea ();
        idea.Title = 'Increase Vacation Time for Employees';
        Community community = [ SELECT Id FROM Community WHERE Name = 'Ashirvad Pipes' ];
        idea.CommunityId = community.Id;
        insert idea;
        List<Reply_to_Comment_Object__c> replyCommentList = new List<Reply_to_Comment_Object__c>();
        Reply_to_Comment_Object__c comment5 = new Reply_to_Comment_Object__c();
        comment5.CommentId__c = idea.id;
        comment5.Comment_Reply__c ='Testing comment2';
        replyCommentList.add(comment5);
        insert replyCommentList;
        Test.startTest();
        ReplyCommentController.displayCommentDetails(idea.Id);
        Test.stopTest();
        }*/
    /*
    @isTest
    static void replyCommentTest3()
    {
        Idea idea2 = new Idea ();
        idea2.Title = 'Increase Vacation Time for Employees';
        Community community = [ SELECT Id FROM Community WHERE Name = 'Ashirvad Pipes' ];
        idea2.CommunityId = community.Id;
        insert idea2;
        string commentBody='Testing Comment';
        IdeaComment comment2 = new IdeaComment();
        comment2.CommentBody = 'Test';
        comment2.IdeaId = idea2.Id;
        insert comment2;
        Test.startTest();
        ReplyCommentController.CommentsDetails(idea2.Id);
        Test.stopTest();
        }*/
    
    @isTest
    static void replyCommentTest2()
    {
        Idea idea1 = new Idea ();
        idea1.Title = 'Increase Vacation Time for Employees';
        Community community = [ SELECT Id FROM Community WHERE Name = 'Ashirvad Pipes' ];
        idea1.CommunityId = community.Id;
        insert idea1;
        string commentBody='Testing Comment';
        IdeaComment comment1 = new IdeaComment();
        comment1.CommentBody = 'Test';
        comment1.IdeaId = idea1.Id;
        insert comment1;
        Test.startTest();
        ReplyCommentController.displayCommentDetails(idea1.Id);
        ReplyCommentController.CommentsDetails(idea1.Id);
        ReplyCommentController.postComment(idea1.Id, CommentBody);
        ReplyCommentController.deleteIdea(idea1.Id);
        ReplyCommentController.deletecommentFromIdea(comment1.Id);
        Test.stopTest();
        }
    }