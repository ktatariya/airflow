--orders.sql
copy into raw.olist_orders_dataset
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
	from %(stage_path)s
)
FILE_FORMAT=raw.csv_with_headers;