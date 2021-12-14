Public class preventdelteTask{

    public static void prvdeltask(List<Task> lstTask){
        String ProfileId = UserInfo.getProfileId(); 
        Map<Id,Profile> Profiles = new Map<Id,Profile>([select id from Profile where name='System Administrator' or name='HO NEW']);
        
        for(Task t: lstTask){
            if(!Profiles.ContainsKey(ProfileId)){
                t.addError('You can\'t delete this record');
            }
        }
    }

}