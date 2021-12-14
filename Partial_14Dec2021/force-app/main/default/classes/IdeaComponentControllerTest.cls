@isTest
public class IdeaComponentControllerTest {
    @isTest
    static void testIdeaComponent()
    {
        Idea idea = new Idea ();
        idea.Title = 'Increase Vacation Time for Employees';
        Community community = [ SELECT Id FROM Community WHERE Name = 'Ashirvad Pipes' ];
        idea.CommunityId = community.Id;
        insert idea;
        Test.startTest();
        IdeaComponentController.AllIdeas(idea.CommunityId);
        IdeaComponentController.AllIdeasByCommunityId(idea.CommunityId);
        IdeaComponentController.AllIdeas(null);
        IdeaComponentController.AllTopIdeas(idea.CommunityId);
        IdeaComponentController.AllTopIdeas(null);
        IdeaComponentController.AllRecentIdeas(idea.CommunityId);
        IdeaComponentController.AllRecentIdeas(null);
        IdeaComponentController.AllIdeaComments(null);
        IdeaComponentController.AllIdeaComments(idea.CommunityId);
        IdeaComponentController.communityForIdea();
        IdeaComponentController.handleLikeButtonClickon(idea.Id);
        IdeaComponentController.handleDisLikeButtonClickon(idea.Id);
        Test.stopTest();
    }
}