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
