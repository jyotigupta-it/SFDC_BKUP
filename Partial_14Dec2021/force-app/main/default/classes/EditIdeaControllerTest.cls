@isTest
public class EditIdeaControllerTest {
    @isTest
    static void editIdeaTest()
    {
        Idea idea = new Idea ();
        idea.Title = 'Increase Vacation Time for Employees';
        Community community = [ SELECT Id FROM Community WHERE Name = 'Ashirvad Pipes' ];
        idea.CommunityId = community.Id;
        insert idea;
        
        IdeaComment commentIdea =new IdeaComment ();
        commentIdea.CommentBody = 'Test';
        commentIdea.IdeaId = idea.Id;
        insert commentIdea; 
        
        Test.startTest();
        EditIdeaController.fetchIdeaDetails(idea.Id);
         EditIdeaController.fetchIdeaCommentDetails(commentIdea.Id);
        EditIdeaController.categoryPickList();
        EditIdeaController.statusPickList();
        EditIdeaController.updateIdeaRecord(idea);
        EditIdeaController.updateIdeaCommentRecord(commentIdea);
        Test.stopTest();
    }
}