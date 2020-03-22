CREATE KEYSPACE ktuspace WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
USE ktuspace;

CREATE TABLE songs (id int primary key, title varchar);
INSERT INTO songs (id, title) values (1, 'Aphex Twin - Xtal');
INSERT INTO songs (id, title) values (2, 'Vacant - Reality');
INSERT INTO songs (id, title) values (3, 'Jamie xx - Seesaw');
INSERT INTO songs (id, title) values (4, 'Vacant - Apart');
INSERT INTO songs (id, title) values (4, 'Burial - Hiders');