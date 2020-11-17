create table note(
    id integer primary key autoincrement,
    created_time integer not null,
    last_updated_time integer not null,
    title text,
    content text
);

create table event(
    id integer primary key autoincrement,
    created_time integer not null,
    last_updated_time integer not null,
    title text,
    note_id integer,
    event_time integer
);

create table album(
    id integer primary key autoincrement,
    created_time integer not null,
    last_updated_time integer not null,
    name text,
    cover_image_id integer
);

create table image(
    id integer primary key autoincrement,
    album_id integer,
    created_time integer not null,
    last_updated_time integer not null,
    thumb BLOB,
    path text not null
);

create table password(
    id integer primary key autoincrement,
    name text not null,
    is_active integer not null,
    content blob not null,
    length integer,
    has_number integer,
    has_lower integer,
    has_upper integer,
    has_other integer,
    created_time integer not null,
    last_updated_time integer not null
);
