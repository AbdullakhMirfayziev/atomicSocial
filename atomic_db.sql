-- create database atomic if not exists;

-- use atomic;

create table user_table (
    id serial primary key,
    username varchar(50) unique not null,
    full_name varchar(50),
    email varchar(100) not null unique,
    password varchar(68) not null,
    enabled boolean,
    image bytea,
    created_at timestamp with time zone default current_timestamp,
    updated_at timestamp
);

create table role_table (
    username varchar(50),
    role_name varchar(50) not null,
    foreign key (username) references user_table(username),
    primary key (username, role_name)
);

create table post (
    id serial primary key,
    photo bytea,
    title varchar(100),
    description text,
    created_at timestamp with time zone default current_timestamp,
    user_id bigint references user_table(id)
);

create table category (
    id serial primary key,
    category_name varchar(50)
);

create table category_post (
    post_id bigint,
    category_id bigint,
    primary key (post_id, category_id),
    foreign key (post_id) references post(id),
    foreign key (category_id) references category(id)
);

create table like_table (
    id serial primary key,
    post_id bigint references post(id),
    user_id bigint references user_table(id),
    created_at timestamp with time zone default current_timestamp,
    unique (post_id, user_id)
);

create table comment_table (
    id serial primary key,
    content text not null,
    post_id bigint references post(id),
    user_id bigint references user_table(id),
    created_at timestamp with time zone default current_timestamp
);