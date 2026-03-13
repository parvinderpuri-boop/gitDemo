global with sharing class VfPageForExportReportController {

    //public String accountName { get; set; }
    public static List<Report> Reports { get; set; }
    public VfPageForExportReportController() { } // empty constructor
    
    @RemoteAction
    global static List<Report> getReports() {
        Reports = [select Id,Name from Report where DeveloperName IN ('Quality_Events_per_Month','Change_Control_by_Status')];
        return Reports;
    }
	@RemoteAction
    global static String getRemoteCSV(String reportId) {
        ApexPages.PageReference report = new ApexPages.PageReference('/'+reportId+'?csv=1');
		return EncodingUtil.base64Decode(EncodingUtil.base64Encode(report.getContent())).toString();
    }
}