--products.sql
copy into raw.olist_products_dataset
from
(
	select
		$1
		,$2
		,$3
		,$4
		,$5
		,$6
		,$7
		,$8
		,$9
		,%(load_id)s
		,%(file_id)s
	from %(stage_path)s
)
FILE_FORMAT=raw.csv_with_headers;