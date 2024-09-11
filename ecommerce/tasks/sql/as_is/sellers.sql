--sellers.sql
copy into raw.olist_sellers_dataset
from
(
	select
		$1
		,$2
		,$3
		,$4
	from %(stage_path)s
)
FILE_FORMAT=raw.csv_with_headers;