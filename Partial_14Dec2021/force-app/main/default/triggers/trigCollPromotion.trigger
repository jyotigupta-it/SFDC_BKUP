trigger trigCollPromotion on Promotion__c (after insert, after update) {
CollateralPromotionTrigger triggerHandler =  new CollateralPromotionTrigger ();
triggerHandler.bulkAfter();
}