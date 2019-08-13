create table meta_data(
  name TEXT not null primary key,
  value BLOB not null
);
create table secret_data(
  id TEXT not null primary key,
  type TEXT not null,
  content BLOB not null,
  checksum BLOB not null
);