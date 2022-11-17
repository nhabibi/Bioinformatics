CREATE database EcoliOverExpressionDB;

RENAME TABLE 
ecoli.dataset TO EcoliOverExpressionDB.dataset,
ecoli.feedback TO EcoliOverExpressionDB.feedback,
ecoli.new_data TO EcoliOverExpressionDB.new_data;

DROP database ecoli;