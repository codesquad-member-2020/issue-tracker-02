INSERT INTO issue (close, user_id, title, description, created_at, update_time_at)
VALUES (TRUE, 'anonymous', 'anonymous 1', 'anonymous contents1\nanonymous contents1\nanonymous contents1', NOW(),
        NOW()),
       (FALSE, 'anonymous', 'anonymous 2', 'anonymous contents2\nanonymous contents2\nanonymous contents2', NOW(),
        NOW()),
       (FALSE, 'anonymous', 'anonymous 2', 'anonymous contents3\nanonymous contents3\nanonymous contents3', NOW(),
        NOW()),
       (FALSE, 'anonymous', 'anonymous 3', 'anonymous contents4\nanonymous contents4\nanonymous contents4', NOW(),
        NOW()),

       (FALSE, 'delmaSong', 'delmaSong 1', 'delmaSong contents1\ndelmaSong contents1\ndelmaSong contents1', NOW(),
        NOW()),
       (TRUE, 'delmaSong', 'delmaSong 2', 'delmaSong contents2\ndelmaSong contents2\ndelmaSong contents2', NOW(),
        NOW()),
       (FALSE, 'delmaSong', 'delmaSong 2', 'delmaSong contents3\ndelmaSong contents3\ndelmaSong contents3', NOW(),
        NOW()),
       (FALSE, 'delmaSong', 'delmaSong 3', 'delmaSong contents4\ndelmaSong contents4\ndelmaSong contents4', NOW(),
        NOW()),

       (FALSE, 'Hyune-c', 'Hyune-c 1', 'Hyune-c contents1\nHyune-c contents1\nHyune-c contents1', NOW(), NOW()),
       (FALSE, 'Hyune-c', 'Hyune-c 2', 'Hyune-c contents2\nHyune-c contents2\nHyune-c contents2', NOW(), NOW()),
       (TRUE, 'Hyune-c', 'Hyune-c 2', 'Hyune-c contents3\nHyune-c contents3\nHyune-c contents3', NOW(), NOW()),
       (FALSE, 'Hyune-c', 'Hyune-c 3', 'Hyune-c contents4\nHyune-c contents4\nHyune-c contents4', NOW(), NOW()),

       (FALSE, 'corykim0829', 'corykim0829 1', 'corykim0829 contents1\ncorykim0829 contents1\ncorykim0829 contents1',
        NOW(), NOW()),
       (TRUE, 'corykim0829', 'corykim0829 2', 'corykim0829 contents2\ncorykim0829 contents2\ncorykim0829 contents2',
        NOW(), NOW()),
       (FALSE, 'corykim0829', 'corykim0829 2', 'corykim0829 contents3\ncorykim0829 contents3\ncorykim0829 contents3',
        NOW(), NOW()),
       (TRUE, 'corykim0829', 'corykim0829 3', 'corykim0829 contents4\ncorykim0829 contents4\ncorykim0829 contents4',
        NOW(), NOW())
;

INSERT INTO label (title, description, color)
VALUES ('BE', 'BE label', '037a3b'),
       ('FE', 'FE label', 'e206d7'),
       ('iOS', 'iOS label', '6ac4e8'),
       ('BUG', 'Bug label', 'b60205'),
       ('DOCUMENT', 'Document label', 'ccf0ff'),
       ('ENHANCEMENT', 'Enhancement label', 'ed0e9f')
;

INSERT INTO issue_label_relation (issue_id, label_id)
VALUES (5, 1),
       (5, 2),
       (5, 3),
       (6, 2),
       (7, 3),
       (9, 1),
       (10, 2),
       (11, 3),
       (13, 1),
       (14, 2),
       (15, 3)
;

INSERT INTO milestone (title, description, due_date)
VALUES ('1차 목표', '1차 목표 상세 설명\n스켈레톤 코드 구성', '2020-06-12'),
       ('2차 목표', '2차 목표 상세 설명\n내부 기능 구성', '2020-06-19'),
       ('3차 목표', '3차 목표 상세 설명\n시연하기', '2020-06-26')
;

INSERT INTO issue_milestone_relation (milestone_id, issue_id)
VALUES (1, 1),
       (1, 5),
       (1, 9),
       (1, 13),
       (2, 2),
       (2, 6),
       (2, 10),
       (2, 14),
       (3, 3),
       (3, 7),
       (3, 11),
       (3, 15)
;

-- INSERT INTO reply (user_id, contents, created_at, issue_id)
-- VALUES ('Hyune-c', 'Hyune-c reply 1\nline2', NOW(), 5),
--        ('Hyune-c', 'Hyune-c reply 1\nline2', NOW(), 9),
--        ('Hyune-c', 'Hyune-c reply 1\nline2', NOW(), 13),
--        ('delmaSong', 'delmaSong reply 1\nline2', NOW(), 6),
--        ('delmaSong', 'delmaSong reply 1\nline2', NOW(), 10),
--        ('delmaSong', 'delmaSong reply 1\nline2', NOW(), 14),
--        ('corykim0829', 'corykim0829 reply 1\nline2', NOW(), 7),
--        ('corykim0829', 'corykim0829 reply 1\nline2', NOW(), 11),
--        ('corykim0829', 'corykim0829 reply 1\nline2', NOW(), 15)
-- ;
