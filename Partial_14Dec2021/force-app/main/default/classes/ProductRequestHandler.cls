public class ProductRequestHandler {
    public static void afterInsert(Map<Id,ProductRequest> mapOfProductRequest){
        Map<Id,ProductRequest> mapOfProduct=new Map<Id,ProductRequest>();
        for(ProductRequest po : mapOfProductRequest.values()){
            if(po.Status!=null && po.Status == 'Received'){
                mapOfProduct.put(po.Id,po);
            }
            
        }
        if(!mapOfProduct.isEmpty()){
            ProductRequestHelper.ProductRequestLineItem(mapOfProduct);
        }

}
     public static void afterUpdate(Map<Id,ProductRequest> mapOfProductRequest,Map<Id,ProductRequest> mapOfOldProductRequest){
        Map<Id,ProductRequest> mapOfProduct=new Map<Id,ProductRequest>();
          Map<Id,ProductRequest> mapOfProductReq=new Map<Id,ProductRequest>();
        for(ProductRequest po : mapOfProductRequest.values()){
            if(po.Status!=null && po.Status =='Received' && po.Status!=mapOfOldProductRequest.get(po.id).Status){
                mapOfProduct.put(po.Id,po);
            }
            if(po.Status!=null && po.Status=='Submitted' && po.Status!=mapOfOldProductRequest.get(po.id).Status){
                mapOfProductReq.put(po.Id,po);
            }
            
        }
        if(!mapOfProduct.isEmpty()){
            ProductRequestHelper.ProductRequestLineItem(mapOfProduct);
        }
         if(!mapOfProductReq.isEmpty()){
             ProductRequestHelper.ProductRequestEmail(mapOfProductReq);
         }
     }
}