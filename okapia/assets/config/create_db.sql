create table note(
    id text not null primary key,
    created_time text not null,
    last_updated_time text not null,
    title text,
    content text
);

create table album(
    id text not null primary key,
    name text not null,
    created_time text not null,
    last_updated_time text not null
);
