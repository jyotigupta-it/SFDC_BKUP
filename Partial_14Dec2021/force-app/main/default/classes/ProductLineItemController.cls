public class ProductLineItemController {
 public Id ParentIds {get;set;}
    Public List<ProductRequestLineItem>  getProductlineItem(){
        List<ProductRequestLineItem> prlitem=new List<ProductRequestLineItem>([Select Id,ProductRequestLineItemNumber,Product_family__c,Product2Id,DestinationLocation.Name,Product2.ProductCode,Parent.ProductRequestNumber,Parent.NeedByDate,Product2.Name,Product2.Description,QuantityRequested,Quantity_Received__c from
                                                                              ProductRequestLineItem where ParentId=:ParentIds]);
        System.debug(prlitem);
        return prlitem;
        
    }
}