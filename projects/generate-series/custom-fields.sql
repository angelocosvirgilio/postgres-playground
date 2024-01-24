SELECT
	"id",
	CONCAT('user', '-', "id") AS "uname"
FROM generate_series(1, 10) "id";