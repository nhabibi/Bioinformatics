DELETE FROM dataset;

load data local infile 'D:\\Dropbox\\Thesis\\Objective 1-Data Collection\\dataset.csv' into table ecolioverexpressiondb.dataset fields terminated by ',' enclosed by '"' lines terminated by '\n';

delete from dataset where gene_name='Gene Name';
