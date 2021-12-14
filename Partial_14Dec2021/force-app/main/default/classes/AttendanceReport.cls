public class AttendanceReport{ 
    
    public AttendanceReport(){
        try{
            String to=(''+System.today().month()).length()==1?'0'+System.today().month():''+System.today().month();
            String frm;
            if(System.today().month()==1){
                frm='12';
            }else{
                frm=(''+(System.today().month()-1)).length()==1?'0'+(System.today().month()-1):''+(System.today().month()-1);
            }
           System.debug(collectDetails(frm,to,''+System.today().year()));
        }catch(Exception ex){
            System.debug(ex);
            System.debug(ex.getMessage());
            System.debug(ex.getLineNumber());
        }
    }
    @RemoteAction
    public static Map<string,List<AttendanceReport.WrapperAttendance>> collectDetails(String frm,String to,String Year){
        try{
        System.debug(frm);
        System.debug(to);
           Integer year1;
            if(Integer.valueOf(frm)==12){
                year1=(Integer.valueOf(year))+1;
            }else{
                year1=(Integer.valueOf(year));
            }
                 List<User> usrLst=new List<User>([select id,name,Employeenumber from user where isActive=true AND Create_Attendance__c=true]);
            
            
            System.debug(usrLst);
            Set<String> userSet=new Set<String>();
            for(user z:usrlst){
                userSet.add(z.Id+frm+to+year);
            }
            Map<String,WrapperAttendance> mapAttusrData=new Map<String,WrapperAttendance>();
            
            date FromDate = date.newInstance(Integer.valueOf(year),Integer.valueOf(frm),26);
            Date ToDate= Date.newInstance(year1,Integer.valueOf(to),25);
            Integer NumOfDays = Date.daysInMonth(FromDate.year(),FromDate.month());
            
            
            List<Attendance__c> attendanceLSt = [select id,Employee_Id__c,Employee_Name__c, Employee__c,In_Time__c,  Out_Time__c,StatusDaily__c,TourPlanDate__c, CreatedDate from Attendance__c where TourPlanDate__c>=:fromDate AND TourPlanDate__c<=:toDate]; 
            system.debug(attendanceLSt );
            Map<Id,List<Attendance__c>> mapAttendance=new Map<Id,List<Attendance__c>>();
            Map<Id,Attendance_Expense__c > mapAttendanceExpense=new Map<Id,Attendance_Expense__c >(); 
            for(Attendance__c temp:attendanceLSt){
                if(mapAttendance.containsKey(temp.Employee__c)){
                    mapAttendance.get(temp.Employee__c).add(temp);
                }else{
                    mapAttendance.put(temp.Employee__c,new List<Attendance__c>{temp});
                }
            }  
            List<Attendance_Expense__c> attExpLst = [select id,UserName__r.Team_Lead__c,UserName__c,UserName__r.Name,Ex_Station__c,External_Id__c,HeadQuarter__c,Headquarter_Metro__c,Headquarter_State_Capital__c,Outstation__c,Date__c,Employee_Id__c  from Attendance_Expense__c where External_Id__c in:userSet  ];
            
            for(Attendance_Expense__c temp:attExpLst ){
                mapAttendanceExpense.put(temp.UserName__c,temp);
            }
            

            /*iEdit to get Map of custom Setting*/
            List<UsersForAttendance__c> custom_User_Att_lst = new List<UsersForAttendance__c>();  // List of values of the custom settings
            Map<String,UsersForAttendance__c> CustomData_allValues = UsersForAttendance__c.getAll(); // Map of custom settings
            custom_User_Att_lst = CustomData_allValues.values();

            
            Map<String,String> map_TL_Data=new Map<String,String>();
            Map<String,String> map_HB_Data=new Map<String,String>();
            
            for(UsersForAttendance__c temp:custom_User_Att_lst){
              if(temp.TLUserId__c!=null){
                map_TL_Data.put(temp.name,temp.TLUserId__c);
              }
              if(temp.HeadBrandingUserId__c!=null){
                map_HB_Data.put(temp.name,temp.HeadBrandingUserId__c);
              }
            }


            
            
            List<WrapperAttendance> zData=new List<WrapperAttendance>();
            Map<string,WrapperAttendance> zv = new Map<string,WrapperAttendance>();
            for(string usrItr:userSet){
            zv.put(usrItr,null);
            
            }
            
            for(Id z:mapAttendanceExpense.keySet()){
                WrapperAttendance temp=new WrapperAttendance();
                temp.UserName=(''+mapAttendanceExpense.get(z).UserName__c).substring(0,15);
                temp.TeamLeader=mapAttendanceExpense.get(z).UserName__r.Team_Lead__c;
                temp.EmpID=mapAttendanceExpense.get(z).Employee_Id__c;
                temp.EmpName=mapAttendanceExpense.get(z).UserName__r.Name;           
                temp.ExStation=mapAttendanceExpense.get(z).Ex_Station__c==null?0:mapAttendanceExpense.get(z).Ex_Station__c;
                temp.OutStation=mapAttendanceExpense.get(z).Outstation__c==null?0:mapAttendanceExpense.get(z).Outstation__c;
                temp.HQ=mapAttendanceExpense.get(z).HeadQuarter__c==null?0:mapAttendanceExpense.get(z).HeadQuarter__c;
                temp.HQMetro=mapAttendanceExpense.get(z).Headquarter_Metro__c==null?0:mapAttendanceExpense.get(z).Headquarter_Metro__c;
                temp.HQStateCapital=mapAttendanceExpense.get(z).Headquarter_State_Capital__c==null?0:mapAttendanceExpense.get(z).Headquarter_State_Capital__c;
                temp.attlist=mapAttendance.containsKey(z)==true?mapAttendance.get(z):new List<Attendance__c>();
                Map<String,boolean> mapDateStatus=new Map<String,boolean>();
                
                System.debug(temp.attlist);
                System.debug(mapAttendance.get(z));
                
                for(Attendance__c  zm:temp.attlist){
                    List<String> dt=(''+zm.TourPlanDate__c).split(' ');
                    List<String> dateSplt=dt[0].split('-');
                    
                    mapDateStatus.put(dateSplt[2]+'/'+dateSplt[1],zm.StatusDaily__c==1?true:false);    
                }
                
                
                system.debug(mapDateStatus);
                
                
                Integer count=1;
                for(Integer zp=26;zp<=NumOfDays;zp++){
                    WrapperStatusDate wrapStatus = new WrapperStatusDate();
                    wrapStatus.index=count;
                    count++;
                    System.debug('======***>'+zp+' ***** '+frm+'****'+mapDateStatus.containsKey(''+zp+'/'+frm)+'=====>'+mapDateStatus.get(''+zp+'/'+frm));
                    
                    wrapStatus.flag=mapDateStatus.containsKey(''+zp+'/'+frm)==true?mapDateStatus.get(''+zp+'/'+frm):false;
                    wrapStatus.data=''+zp+'/'+frm;
                   temp.wrapStatusLst.add(wrapStatus);
                }
                for(Integer zp=1;zp<=25;zp++){
                    WrapperStatusDate wrapStatus = new WrapperStatusDate();
                    wrapStatus.index=count;
                    count++;
                    String zup=''+zp;
                    if((''+zp).length()==1){
                        zup='0'+zp;
                    }
                    System.debug('======***>'+zp+' ***** '+to+'****'+mapDateStatus.containsKey(''+zp+'/'+to)+'=====>'+mapDateStatus.get(''+zp+'/'+to));
                    
                    wrapStatus.flag=mapDateStatus.containsKey(''+zup+'/'+to)==true?mapDateStatus.get(''+zup+'/'+to):false;
                    wrapStatus.data=''+zup+'/'+to;
                    temp.wrapStatusLst.add(wrapStatus);
                }
        
             zData.add(temp);
                
            }
            system.debug(zData);

            
            
            Map<String,List<WrapperAttendance>> mapTLWrapAttendence=new Map<String,List<WrapperAttendance>>();
            Map<string,List<WrapperAttendance>> mapHBWrapAttendance = new  Map<string,List<WrapperAttendance>>();
            system.debug(map_TL_Data);

            /**************************************************************************************/
            for(WrapperAttendance rv:zData){
            
            system.debug(rv.UserName);
              if(map_TL_Data.containsKey(rv.UserName)){
                if(mapTLWrapAttendence.containsKey(map_TL_Data.get(rv.UserName))){
                  mapTLWrapAttendence.get(map_TL_Data.get(rv.UserName)).add(rv);
                }else{
                  mapTLWrapAttendence.put(map_TL_Data.get(rv.UserName),new List<WrapperAttendance>{rv});
                }
              }
              
             if(map_HB_Data.containsKey(rv.UserName)){
                 if(mapHBWrapAttendance.containsKey(map_HB_Data.get(rv.UserName))){
                     mapHBWrapAttendance.get(map_HB_Data.get(rv.UserName)).add(rv);
                  }else{
                     mapHBWrapAttendance.put(map_HB_Data.get(rv.UserName),new List<WrapperAttendance>{rv});
                  }
              }
            }
            
            
            





            /**************************************************************************************/
            /*for(WrapperAttendance rv:zData){
                if(mapTLWrapAttendence.containsKey(rv.TeamLeader)){
                    mapTLWrapAttendence.get(rv.TeamLeader).add(rv);
                }else{
                    mapTLWrapAttendence.put(rv.TeamLeader,new List<WrapperAttendance>{rv});    
                }
            }*/
            System.debug('Team Leader Map :'+mapTLWrapAttendence);
            
            Map<String,List<WrapperAttendance>> zMapData=new Map<String,List<WrapperAttendance>>();
            
            zMapData.putAll(mapTLWrapAttendence);
            zMapData.putAll(mapHBWrapAttendance);
            zMapData.put('ALL_Data',zData);
            System.debug(zMapData.keySet());

            Map<string,blob> userRepBlobMap =new Map<string,Blob>();
            
            for(String z:zMapData.keySet()){
                userRepBlobMap.put(z,generateTable(zMapData.get(z),frm,to,year));
            }
            anotherFunc(userRepBlobMap);







            
            return zMapData;

                 
        }catch(Exception ex){
            system.debug(ex);
            System.debug(ex.getMessage());
            System.debug(ex.getLineNumber());
        }
        return null;
    } 

    @RemoteAction
    public static blob generateTable(List<WrapperAttendance> zData,string frm,string to,String Year){
      try{
        Integer year1;
        if(Integer.valueOf(frm)==12){
            year1=(Integer.valueOf(year))+1;
        }else{
            year1=(Integer.valueOf(year));
        }
        date FromDate = date.newInstance(Integer.valueOf(year),Integer.valueOf(frm),26);
        Date ToDate= Date.newInstance(year1,Integer.valueOf(to),25);
        Integer NumOfDays = Date.daysInMonth(FromDate.year(),FromDate.month());

        //to display Header inside CSV
        string header = '<table><thead><th>Employee Id</th><th>Employee Name</th> ';
        List<String> headerArr=new List<String>();
        for(Integer zp=26;zp<=NumOfDays;zp++){   
            headerArr.add('<th>'+zp+'/'+frm+'</th>');   
        }
        for(Integer zp=1;zp<=25;zp++){
            String zk;
            if((''+zp).length()==1){
                zk='0'+zp;
                system.debug('its zp from 1 to 26');
                system.debug(zp);
            }else{
                zk=''+zp;
                system.debug('Else its zp from 1 to 26');
                system.debug(zp);

            }
            headerArr.add('<th>'+zk+'/'+to+'</th>');
            system.debug('headerArr'+headerArr);
        }
        header+=String.join(headerArr,'');
        header+='<th>HQ</th><th>HQMetro</th><th>HQStateCapital</th><th>ExStation</th><th>OutStation</th></thead>';
        System.debug(header+'\n');

        String pHeader=header;
        String pData='<tbody>';
        
        for(WrapperAttendance zk:zData){
          pData+='<tr><td>'+zk.EmpID+'</td>';
          pData+='<td>'+zk.EmpName+'</td>';
          List<String> pDataArr=new List<String>();
          for(Integer i=0;i<zk.wrapStatusLst.size();i++){
              if(zk.wrapStatusLst[i].flag){
                 pDataArr.add('<td bgcolor="#00FF00" align="center">1</td>');
              }else{
                 pDataArr.add('<td bgcolor="#FF0000" align="center">0</td>');
              }
          }
          pData+=String.join(pDataArr,'');
          pData+='<td align="center">'+zk.HQ+'</td>';
          pData+='<td align="center">'+zk.HQMetro+'</td>';
          pData+='<td align="center">'+zk.HQStateCapital+'</td>';
          pData+='<td align="center">'+zk.ExStation+'</td>';
          pData+='<td align="center">'+zk.OutStation+'</td></tr>';
        }
        return(Blob.valueOf(pHeader+pData+'</tbody></table>'));
        
      }catch(Exception ex){
        System.debug(ex);
        System.debug(ex.getMessage());
        System.debug(ex.getLineNumber());
      }
      return null;
    }
    
    
    @RemoteAction
    public static boolean anotherFunc(Map<string,blob> userRepBlobMap){
        try{
        
            system.debug(userRepBlobMap);
            Blob AllData;
            //List<String> ProfName;
            Map<String,String> emaMapusr_AllData;
            
            Map<String,Blob> zpk=new Map<String,Blob>();
            for(String dta:userRepBlobMap.keySet()){
                if(dta!='ALL_Data'){
                    zpk.put(dta,userRepBlobMap.get(dta));
                }
            }
            
            if(userRepBlobMap.containsKey('ALL_Data')){
                
                AllData=userRepBlobMap.get('ALL_Data');
                //userRepBlobMap.remove('ALL_Data');
                
                
                //List<String> ProfName=new List<String>{'Customer Support Team' ,'System Administrator','HO NEW'};
                List<String> ProfName=new List<String>{'System Administrator'};
                Map<Id,profile> mapprof=new Map<Id,profile>([select id from profile where name in:ProfName]); 
                
                
                List<User> usrlst=new List<User>([select id,email from user where profileid in:mapprof.keySet()]);
                emaMapusr_AllData=new Map<String,String>();
                for(User temp:usrlst){
                   emaMapusr_AllData.put((''+temp.id).substring(0,15),temp.email);
                }
            }
            
            
                          
        
           List<user> u = [select id,email from user where Id in:userRepBlobMap.keySet()];
           Map<String,String> emaMapusr=new Map<String,String>();
           for(User temp:u){
               emaMapusr.put((''+temp.id).substring(0,15),temp.email);
           }
            System.debug(emaMapusr);
            system.debug(userRepBlobMap);
            List<Messaging.SingleEmailMessage> emailList =new List<Messaging.SingleEmailMessage>();
            if(userRepBlobMap!=null){
            for(string zp: zpk.keySet()){
                Messaging.SingleEmailMessage temp=new Messaging.SingleEmailMessage();
                Messaging.EmailFileAttachment tempAttc = new Messaging.EmailFileAttachment();
                String csvname=''+zp+'_Attendance.xls';
                tempAttc.setFileName(csvname);
                //tempAttc.setBody(EncodingUtil.base64Decode(zpk.get(zp).substring(zpk.get(zp).indexOf(',')+1,zpk.get(zp).length())));
                tempAttc.setBody(zpk.get(zp));
                temp.setSubject('Attendence Report');
                temp.setToAddresses(new List<String>{emaMapusr.get(zp)});
                //temp.setToAddresses(new List<String>{'shaikhisaaq@gmail.com'});
                temp.setPlainTextBody('Attendence XLS ');
                temp.setFileAttachments(new Messaging.EmailFileAttachment[]{tempAttc});
                emailList.add(temp);
            }
          
            
            if(AllData!=null){
                Messaging.SingleEmailMessage temp=new Messaging.SingleEmailMessage();
                Messaging.EmailFileAttachment tempAttc = new Messaging.EmailFileAttachment();
                String csvname='ALL DATA_Attendance.xls';
                tempAttc.setFileName(csvname);
                //tempAttc.setBody(EncodingUtil.base64Decode(AllData.substring(AllData.indexOf(',')+1,AllData.length())));
                tempAttc.setBody(AllData);
                temp.setSubject('ALL_Attendence Report');
                temp.setToAddresses(emaMapusr_AllData.values());
                //temp.setToAddresses(new List<String>{'shaikhisaaq@gmail.com'});
                temp.setPlainTextBody('Attendence XLS ');
                temp.setFileAttachments(new Messaging.EmailFileAttachment[]{tempAttc});
                emailList.add(temp);
            }
            
            System.debug(emailList);
            
            
            if(emailList.size()>0){
                Messaging.SendEmailResult [] result = Messaging.sendEmail(emailList);
            }
           }
            return true;
        }catch(Exception ex){
            system.debug(ex);
            System.debug(ex.getMessage());
            System.debug(ex.getLineNumber());   
        }
        return false;
    }
  

    /**********************************************************************************************************/
  
    public class WrapperAttendance{
        
        public decimal StatusDaily{get;set;}
        public decimal ExStation{get;set;}
        public decimal OutStation{get;set;}
        public decimal HQ{get;set;}
        public decimal HQMetro{get;set;}
        public decimal HQStateCapital{get;set;}
        public string EmpID{get;set;}
        public string EmpName{get;set;}
        public string UserName{get;set;}
        public string TeamLeader{get;set;}
        public string HeadBranding{get;set;}
        public List<Attendance__c> attlist{get;set;}
        public List<WrapperStatusDate> wrapStatusLst{get;set;}
        public WrapperAttendance(){
            StatusDaily=0;
            ExStation=0;
            OutStation=0;
            HQ=0;
            HQMetro=0;
            HQStateCapital=0;
            EmpId='';
            EmpName='';
            attlist=new List<Attendance__c>();
            wrapStatusLst= new List<WrapperStatusDate>();
        }    
    }
    
    public class WrapperStatusDate{
        integer index;
        boolean flag;
        String data;
        
        WrapperStatusDate(){
            flag=false;
     
        }
    
        
    
    }
}