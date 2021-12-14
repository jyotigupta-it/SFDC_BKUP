@isTest
public class ViewIdeaTest {
@isTest
    static void viewIdeaComponentTest()
    {
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
        ViewIdeaController.displayIdeaDetails(idea.Id);
        ViewIdeaController.postComment(idea.Id, commentBody);
        ViewIdeaController.deleteIdea(idea.Id);
        ViewIdeaController.deletecommentFromIdea(comment.Id);
       
        Test.stopTest();
    }
}