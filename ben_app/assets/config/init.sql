create table meta_data(
  id int not null primary key,
  content BLOB not null
);
create table items(
  id TEXT not null primary key,
  type int not null,
  meta BLOB not null,
  content BLOB not null,
  checksum BLOB not null
);