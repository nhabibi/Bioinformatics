select * INTO OUTFILE 'D:\\Dropbox\\Thesis\\Code\\MySQL\\dataset.csv' 

FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'

from ecoli.dataset