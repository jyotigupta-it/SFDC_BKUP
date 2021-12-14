@isTest
public class CreateIdeaTest {
 
    @istest
    static void testCreateIdeaComponent(){
        Idea idea = new Idea ();
        idea.Title = 'Increase Vacation Time for Employees';
        Community community = [ SELECT Id FROM Community WHERE Name = 'Ashirvad Pipes' ];
        idea.CommunityId = community.Id;
        insert idea;
        string commentBody='Testing Comment';
        IdeaComment comment= new IdeaComment();
        comment.CommentBody = 'Test';
        comment.IdeaId = idea.Id;
        insert comment;
        Test.startTest();
        CreateIdeaController.postIdeaLightning(idea.Title, idea.Body, idea.Categories, idea.CommunityId, idea.Status);
        CreateIdeaController.CommunityForIdeas();
        CreateIdeaController.categoryPickList();
        CreateIdeaController.statusPickList();
      
        Test.stopTest();
        
    }
}