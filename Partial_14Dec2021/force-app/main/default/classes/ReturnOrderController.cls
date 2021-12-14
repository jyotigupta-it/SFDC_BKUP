public class ReturnOrderController 
{
 public Id ReturnOrderIds {get;set;}
    public List<ReturnOrderLineItem> returnlitem{get;set;}
    Public List<ReturnOrderLineItem>  getReturnlineItem(){
       returnlitem =new List<ReturnOrderLineItem>([Select Id,ReturnOrderLineItemNumber,Product2Id,ReturnOrder.ReturnOrderNumber,SourceLocation.Name,ProductItem.Product2.ProductCode,ProductItem.Product2.Description,ProductItemId,QuantityReturned from
                                                                              ReturnOrderLineItem where ReturnOrderId=:ReturnOrderIds]);
        System.debug(returnlitem);
        return returnlitem;
    }
}