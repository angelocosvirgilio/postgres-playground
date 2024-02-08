NOTIFY channel1, 'hello world!';
SELECT pg_notify('channel2', 'this is another communication');