--category_name_translation.sql
copy into raw.product_category_name_translation
from
(
	select
		$1
		,$2
		,%(load_id)s
		,%(file_id)s
	from %(stage_path)s
)
FILE_FORMAT=raw.csv_with_headers;