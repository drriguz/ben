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

create table image(
  id TEXT not null primary key,
  album_id TEXT not null,
  meta BLOB not null,
  content BLOB not null
);