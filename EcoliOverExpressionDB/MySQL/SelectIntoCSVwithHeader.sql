SELECT *
INTO OUTFILE 'D:\\Dropbox\\Thesis\\Code\\MySQL\\dataset.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'

FROM (
      ( SELECT 'author_approved', 'gene_name', 'gene_id',
			   'vector', 'host', 'iptg', 'temperature',
               'yield', 'expression_level', 'result_type',
               'reference', 'note', 'gene_sequence')
      UNION
      ( SELECT * FROM ecoli.dataset)
) AS temp

