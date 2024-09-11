--order_reviews.sql
copy into raw.olist_order_reviews_dataset
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
	from %(stage_path)s
)
FILE_FORMAT=raw.csv_with_headers;