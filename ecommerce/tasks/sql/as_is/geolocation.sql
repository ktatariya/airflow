--geolocation.sql
copy into raw.olist_geolocation_dataset
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