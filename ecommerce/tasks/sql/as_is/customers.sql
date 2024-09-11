--customers.sql
copy into raw.olist_customers_dataset
from
(
	select
		$1
		,$2
		,$3
		,$4
		,$5
	from %(stage_path)s
)
FILE_FORMAT=raw.csv_with_headers;