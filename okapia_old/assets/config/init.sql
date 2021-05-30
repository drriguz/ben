create table meta_data(
  id int not null primary key,
  content BLOB not null
);

create table structured_item(
  id TEXT not null primary key,
  type int not null,
  meta BLOB not null,
  content BLOB not null
);

create table album(
  id TEXT not null primary key,
  content BLOB not null
);

-- https://github.com/tekartik/sqflite/issues/270
-- Although you can store the image in the database you cannot retrieve it
-- from the database because it is too large to fit into a CursorWindow
-- which has a limitation of 2MB (2097152).

create table image(
  id TEXT not null primary key,
  album_id TEXT not null,
  meta BLOB not null,
  content BLOB not null
);

create table tile(
  id TEXT not null primary key,
  content BLOB not null
);

create table contact(
  id TEXT not null primary key,
  name TEXT not null,
  public_key TEXT not null,
  fingerprint TEXT not null
);