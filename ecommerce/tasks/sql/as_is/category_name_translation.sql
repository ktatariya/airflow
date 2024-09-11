--category_name_translation.sql
copy into raw.product_category_name_translation
from
(
	select
		$1
		,$2
	from %(stage_path)s
)
FILE_FORMAT=raw.csv_with_headers;