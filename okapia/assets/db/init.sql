create table note(
    id integer primary key autoincrement,
    created_time integer not null,
    last_updated_time integer not null,
    title text,
    content text
);

insert into note values(1, 1622719706, 1622719706, "他为求升迁而小心谨慎。", "He is cautious inorder to get promoted. 他为求升迁而小心谨慎。 Its continously reform were made inorder to waste . 不停变化的新潮款式,完全是为浪费而刻意制作的。");