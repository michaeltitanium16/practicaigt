@isTest (SeeAllData=false)
private class OrderTests {
    
    @testSetup
    static void SetupTestData() {
        TestDataFactory.InsertTestData(5);
    }
 
    @isTest static void OrderExtension_UnitTest() {
        Test.startTest();
        PageReference pageRef = Page.OrderEdit;
        Test.setCurrentPage(pageRef);
        SetupTestData();
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(TestDataFactory.orders[0]);        
        OrderExtension ext = new OrderExtension(stdcontroller);        
           System.assertEquals(Constants.DEFAULT_ROWS, ext.orderItemList.size());
        ext.OnFieldChange();
        ext.SelectFamily();
        ext.Save();
        ext.First();
        ext.Next();
        ext.Previous();
        ext.Last();
        ext.GetHasPrevious();
        ext.GetHasNext();
        ext.GetTotalPages();
        ext.GetPageNumber();
        List<SelectOption> options = ext.GetFamilyOptions();
        
        Test.stopTest();
    }
    @isTest static void OrderUpdate_UnitTest(){

        Test.startTest();
        CollaborationGroup c=new CollaborationGroup();
        c.Name='TEST' + Constants.INVENTORY_ANNOUNCEMENTS;
        c.Description='Description';
       // c.OwnerId=[Select Id from Account Limit 1].Id;
        c.CollaborationType='Public';
        insert c;
        
        Order o = [SELECT Id, Status FROM Order LIMIT 1];
        Product2 p = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 LIMIT 1];
    
        o.status = constants.ACTIVATED_ORDER_STATUS;
        Update o;
        Product2 updatedp = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 LIMIT 1];
    
    
        TestDataFactory.VerifyQuantityOrdered(p, updatedp, constants.DEFAULT_ROWS);
        Test.stopTest();
    
      }
}