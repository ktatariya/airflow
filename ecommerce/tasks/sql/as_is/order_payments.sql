--order_payments.sql
copy into raw.olist_order_payments_dataset
from
(
	select
		$1
		,$2
		,$3
		,$4
		,$5
		,%(load_id)s
		,%(file_id)s
	from %(stage_path)s
)
FILE_FORMAT=raw.csv_with_headers;