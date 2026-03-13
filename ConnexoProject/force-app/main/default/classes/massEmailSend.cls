public class massEmailSend 
{
@InvocableMethod(label='Send Mass Email' description='Send Mass Email in Dev Org Users' category='Security')
    public static void MassMail() 
    {
        // Create an email message object
		Messaging.reserveMassEmailCapacity(10);
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        //mail.setToAddresses = new String[] {'amit.kamat@slipstream-it.com','kamat.navneet@gmail.com'};
        mail.setSenderDisplayName('Slipstream Dev System');
        mail.setSubject('Email Alert for Training : ' + case.Id);
       	EmailTemplate et=[Select id from EmailTemplate where name = 'EmailTemplatename' limit 1];
        mail.setTemplateId(et.id);


        //message sending

      Messaging.sendEmail(new Messaging.Email[] {mail}); 

    }

}