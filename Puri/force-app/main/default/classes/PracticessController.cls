public class PracticessController {
	@AuraEnabled
    public static void saveData(string jsonData){
        //debug json
        System.debug('json received' + jsonData);
        //json to wrapper
        PracticeWrapper data = (PracticeWrapper) JSON.deserialize(jsonData, PracticeWrapper.class);
        // Wrapper → Record
        Practice_Form__c rec = new Practice_Form__c();
        rec.Name = data.name;
        rec.City__c = data.city;
        rec.Phone__c = data.phone;
        
        insert rec;
    }
    
    public class PracticeWrapper{
        public string name;
        public string city;
        public string phone;
    }
}