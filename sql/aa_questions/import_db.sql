PRAGMA foreign_keys = ON; 

DROP TABLE question_likes;
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE questions;
DROP TABLE users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname character varying(20) NOT NULL,
    lname character varying(20) NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title character varying(100) NOT NULL,
    body TEXT,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    parent_id INTEGER,
    body TEXT NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_follows (
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ("Barrett", "Ross"),
    ("Kat", "Koebel");

INSERT INTO
    questions (title, body, author_id)
VALUES
    ("Deutschbag", "Go ahead, call your medic. He can't unchuckle your nuts.", 2);

INSERT INTO
    question_follows (question_id, user_id)
VALUES
    (1, 1),
    (1, 2);

INSERT INTO
    question_likes (question_id, user_id)
VALUES
    (1, 1),
    (1, 2);

INSERT INTO
    replies (user_id, question_id, parent_id, body)
VALUES
    (1, 1, NULL, "I like this"),
    (2, 1, 1, "Thanks!");