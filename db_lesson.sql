-- Q1
CREATE TABLE departments (
  department_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

alter table departments modify created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP; -- NULL欄が効かなかったため追加
alter table departments modify updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP;

-- Q2
ALTER TABLE people ADD department_id INT UNSIGNED NULL AFTER email;

-- Q3
-- departments(name)
-- 営業、開発、経理、人事、情報システムの追加
INSERT INTO departments (name)
VALUES
('営業'),
('開発'),
('経理'),
('人事'),
('情報システム');

-- people(name, department_id, age, gender)
-- 10人追加
-- 営業3人、開発4人、経理1人、人事1人、情報システム1人
INSERT INTO people(name, department_id, age, gender)
VALUES
('佐藤たかし', 1, 35, 1),
('高橋はな', 2, 29, 2),
('伊藤みか', 2, 42, 1),
('渡部あやか', 1, 31, 2),
('山本なおき', 3, 58, 1),
('中村ゆうこ', 2, 46, 2),
('小林まさかず', 2, 23, 1),
('加藤ゆきこ', 4, 65, 2),
('木村だいち', 1, 39, 1),
('松本えみこ', 5, 37, 2);

-- 日報
INSERT INTO reports (person_id, content)
VALUES
(12, '来週の出張予定を調整した'),
(8, '顧客対応で課題が発生した'),
(15, '営業資料の見直しを行った'),
(10, '新人の研修サポートを行う'),
(13, 'クレーム対応の報告を作成'),
(7, '午後から会議準備を進めた'),
(16, '部内ミーティングを実施'),
(9, '提案資料の修正を実施した'),
(11, 'バグの原因調査を実施した'),
(14, '新機能のテストを実施した');

-- Q4
-- 25歳以下：営業　26歳以上の女性：開発　それ以外：人事　に配属
UPDATE people SET department_id = 1 WHERE age <= 25 AND department_id is NULL;
UPDATE people SET department_id = 2 WHERE gender = 2 AND department_id is NULL;
UPDATE people SET department_id = 4 WHERE department_id is NULL;

-- Q5
-- 年齢の降順で男性の名前と年齢を取得
SELECT name, age
FROM people
WHERE gender = 1
ORDER BY age DESC;

-- Q6
-- SQL文の説明(テーブル、カラム、レコードを用いる)
```
テーブル名「people」から、
営業に所属している(カラム名「department_id」が1である)者の
名前、メールアドレス、年齢(カラム名「name」「email」「age」)を
データの作成日時の降順に並べたレコードを取得するSQL文。
```

-- Q7
SELECT name -- SELECT文を修正
FROM people
WHERE
gender = 2 AND age BETWEEN 20 AND 29 OR
gender = 1 AND age BETWEEN 40 AND 49;

-- Q8
SELECT *
FROM people
WHERE department_id = 1
ORDER BY age;

--Q9
SELECT AVG(age) average_age
FROM people
WHERE department_id = 2 AND gender = 2;

--Q10
SELECT p.name, d.name, r.content
FROM (people p JOIN departments d USING(department_id))
JOIN reports r USING (person_id);

-- Q11
SELECT p.name FROM people p -- SELECT文を修正
WHERE NOT EXISTS (
  SELECT * FROM reports r
  WHERE p.person_id = r.person_id
);
-- Q11 OUTER JOINで書き直す
SELECT p.name
FROM people p LEFT OUTER JOIN reports r USING (person_id)
WHERE r.content is NULL;