INSERT INTO issue (close, user_id, title, content, created_at, update_time_at)
VALUES (FALSE, 'anonymous', 'anonymous 1', 'anonymous contents1\nanonymous contents1\nanonymous contents1', NOW(),
        NOW()),
       (FALSE, 'anonymous', 'anonymous 2', 'anonymous contents2\nanonymous contents2\nanonymous contents2', NOW(),
        NOW()),
       (FALSE, 'anonymous', 'anonymous 2', 'anonymous contents3\nanonymous contents3\nanonymous contents3', NOW(),
        NOW()),
       (FALSE, 'anonymous', 'anonymous 3', 'anonymous contents4\nanonymous contents4\nanonymous contents4', NOW(),
        NOW()),

       (FALSE, 'delmaSong', 'delmaSong 1', 'delmaSong contents1\ndelmaSong contents1\ndelmaSong contents1', NOW(),
        NOW()),
       (FALSE, 'delmaSong', 'delmaSong 2', 'delmaSong contents2\ndelmaSong contents2\ndelmaSong contents2', NOW(),
        NOW()),
       (FALSE, 'delmaSong', 'delmaSong 2', 'delmaSong contents3\ndelmaSong contents3\ndelmaSong contents3', NOW(),
        NOW()),
       (FALSE, 'delmaSong', 'delmaSong 3', 'delmaSong contents4\ndelmaSong contents4\ndelmaSong contents4', NOW(),
        NOW()),

       (FALSE, 'Hyune-c', 'Hyune-c 1', 'Hyune-c contents1\nHyune-c contents1\nHyune-c contents1', NOW(), NOW()),
       (FALSE, 'Hyune-c', 'Hyune-c 2', 'Hyune-c contents2\nHyune-c contents2\nHyune-c contents2', NOW(), NOW()),
       (FALSE, 'Hyune-c', 'Hyune-c 2', 'Hyune-c contents3\nHyune-c contents3\nHyune-c contents3', NOW(), NOW()),
       (FALSE, 'Hyune-c', 'Hyune-c 3', 'Hyune-c contents4\nHyune-c contents4\nHyune-c contents4', NOW(), NOW()),

       (FALSE, 'corykim0829', 'corykim0829 1', 'corykim0829 contents1\ncorykim0829 contents1\ncorykim0829 contents1',
        NOW(), NOW()),
       (FALSE, 'corykim0829', 'corykim0829 2', 'corykim0829 contents2\ncorykim0829 contents2\ncorykim0829 contents2',
        NOW(), NOW()),
       (FALSE, 'corykim0829', 'corykim0829 2', 'corykim0829 contents3\ncorykim0829 contents3\ncorykim0829 contents3',
        NOW(), NOW()),
       (FALSE, 'corykim0829', 'corykim0829 3', 'corykim0829 contents4\ncorykim0829 contents4\ncorykim0829 contents4',
        NOW(), NOW())
;

INSERT INTO label (title, content, color)
VALUES ('BE', 'BE label', '037a3b'),
       ('FE', 'FE label', 'e206d7'),
       ('iOS', 'iOS label', '6ac4e8'),
       ('BUG', 'Bug label', 'b60205'),
       ('DOCUMENT', 'Document label', 'ccf0ff'),
       ('ENHANCEMENT', 'Enhancement label', 'ed0e9f')
;

INSERT INTO issue_labels (issue_id, labels_id)
VALUES (5, 1),
       (6, 2),
       (7, 3),
       (9, 1),
       (10, 2),
       (11, 3),
       (13, 1),
       (14, 2),
       (15, 3)
;