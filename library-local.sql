--  -----------------------------------------------------------  --
--  CREATE OR UPDATE THE LIBRARY DEMO DATABASE ON YOUR COMPUTER  --
--  -----------------------------------------------------------  --

--  * * REMEMBER * *:  You will need to press the 🔄 Refresh arrows in the top right corner of the SCHEMAS sidebar
--                     to see the new/updated library database (schema).

DROP SCHEMA IF EXISTS library;
CREATE SCHEMA library;

USE library;

CREATE TABLE borrowers (
  borrowerid int NOT NULL AUTO_INCREMENT,
  firstname varchar(45) NOT NULL,
  familyname varchar(45) NOT NULL,
  dateofbirth date DEFAULT NULL,
  address varchar(50) DEFAULT NULL,
  suburb varchar(25) DEFAULT NULL,
  city varchar(25) DEFAULT NULL,
  postcode varchar(4) DEFAULT NULL,
  PRIMARY KEY (borrowerid)
);

CREATE TABLE categories (
  category varchar(15) NOT NULL,
  PRIMARY KEY (category)
);

CREATE TABLE books (
  bookid int NOT NULL AUTO_INCREMENT,
  booktitle varchar(45) NOT NULL,
  author varchar(45) NOT NULL,
  bookcategory varchar(15) DEFAULT NULL,
  yearofpublication int DEFAULT NULL,
  description longtext,
  image varchar(50) DEFAULT NULL,
  PRIMARY KEY (bookid),
  CONSTRAINT FK_Category FOREIGN KEY (bookcategory) REFERENCES categories (category)
);

CREATE TABLE bookcopies (
  bookcopyid int NOT NULL AUTO_INCREMENT,
  bookid int NOT NULL,
  format varchar(12) NOT NULL,
  PRIMARY KEY (bookcopyid),
  KEY bookid_idx (bookid),
  CONSTRAINT bookid FOREIGN KEY (bookid) REFERENCES books (bookid) ON DELETE CASCADE
);

CREATE TABLE loans (
  loanid int NOT NULL AUTO_INCREMENT,
  bookcopyid int NOT NULL,
  borrowerid int NOT NULL,
  loandate date NOT NULL,
  returned date DEFAULT NULL,
  PRIMARY KEY (loanid),
  KEY borrowedbook_idx (bookcopyid),
  KEY borrower_idx (borrowerid),
  CONSTRAINT borrowedbook FOREIGN KEY (bookcopyid) REFERENCES bookcopies (bookcopyid),
  CONSTRAINT borrower FOREIGN KEY (borrowerid) REFERENCES borrowers (borrowerid)
);

INSERT INTO categories (category) VALUES 
  ('Fiction'),
  ('Picture Book'),
  ('Non-Fiction'),
  ('Magazine/Serial');

INSERT INTO books VALUES
(56,'Harry Potter and the Order of the Phoenix','J. K. Rowling','Fiction',2011,"Dark times have come to Hogwarts. After the Dementors' attack on his cousin Dudley, Harry Potter knows that Voldemort will stop at nothing to find him. There are many who deny the Dark Lord's return, but Harry is not alone: a secret order gathers at Grimmauld Place to fight against the Dark forces. Harry must allow Professor Snape to teach him how to protect himself from Voldemort's savage assaults on his mind. But they are growing stronger by the day and Harry is running out of time ...","Harry_Potter_and_the_Order_of_the_Phoenix.jpg"),
(34,'The Wind in the Willows','Kenneth Grahame','Fiction',1908, "The Wind in the Willows is a children's novel by Kenneth Grahame, first published in England in 1908. The story focuses on four anthropomorphized animals in a pastoral version of Edwardian England. The novel is notable for its mixture of mysticism, adventure, morality and camaraderie, and celebrated for its evocation of the nature of the Thames Valley. It is a delightful and captivating tale that is sure to delight.","Wind in the Willows.jpg"),
(7455, 'Python Crash Course', 'Eric Matthes', 'Non-Fiction', 2019, "A fast-paced, no-nonsense, updated guide to programming in Python.","Python Crash Course.jpg"),
(622, "The Very Hungry Caterpillar", "Eric Carle", "Picture Book", 1970, "A caterpillar eats a varied and very large quantity of food until, full at last, it forms a cocoon to transform. Die-cut pages illustrate what the caterpillar ate on successive days.","TheVeryHungryCaterpillar.jpg"),
(630, "The Phoenix Pencil Company", "Allison King", "Fiction", 2025, "Monica Tsai spends most days coding. She longs to return home to her beloved grandparents, now in their nineties, and worries about her grandmother Yun whose memory is fading. Monica is intent on finding Yun's cousin, Meng, before it's too late. In her search, Monica connects with a young woman who gifts her a pencil that holds a clue to a hidden family history and the special power the family women possess. Monica learns of Yun's years in Shanghai, WWII, betrayal, espionnage, and reconnections, changing their lives in ways she can scarcely imagine.","PhoenixPencilCo.jpg"),
(652, "Jiffy's Greatest Hits", "Catherine Chidgey", "Picture Book", 2022, "Jiffy the cat loves to express himself through song. That would be just fine by his human family, the Bees, if he didn't go on all night! A laugh-out-loud story, which also introduces children to telling the time.","JiffysGreatest.jpg"),
(81, "Human Spatial Computing", "Reginé Gilbert and Doug North Cook", "Non-Fiction", 2025, "Spatial Computing does not limit us to only physical screens, but includes natural interfaces, haptic feedback, and virtual and augmented reality. This book explores spatial computing's historical roots and contemporary implications, ...connecting people and adapting to new social norms. Each chapter includes questions and suggested activities, and provides an in-depth view of the practical factors to consider when creating spatial computing experiences, essential to consider the intricacies of making experiences inclusive and accessible to a broad audience, to ensure a future centred around humanity.","HumanSpatialComputing.jpg"),
(82, "The Axeman's Carnival", "Catherine Chidgey", "Fiction", 2022, "Tama is just a helpless chick when he is rescued by Marnie, and this is where his story might have ended. ‘If it keeps me awake,’ says Marnie’s husband Rob, a farmer, ‘I’ll have to wring its neck.’ But with Tama come new possibilities for the couple’s future. Tama can speak, and his fame is growing. Outside, in the pines, his father warns him of the wickedness wrought by humans.","AxemansCarnival.jpg"),
(654, "Jiffy, Cat Detective", "Catherine Chidgey", "Picture Book", 2019, "When Dad can't find his shoe the family is sent to find it, but Jiffy, the cat, knows how to solve this mystery. In fact he knew even before the loss was noticed. Told in rhyme and rhythm with a very satisfying ending... for cats.","jiffy_cat.jpg")
;

INSERT INTO bookcopies VALUES (3, 56, 'Hardcover');
INSERT INTO bookcopies VALUES (11, 56, 'Paperback');
INSERT INTO bookcopies VALUES (27, 56, 'eBook');
INSERT INTO bookcopies VALUES (81, 56, 'Audio Book');
INSERT INTO bookcopies VALUES (19, 56, 'Paperback');
INSERT INTO bookcopies VALUES (93, 56, 'Paperback');
INSERT INTO bookcopies VALUES (56, 56, 'Paperback');
INSERT INTO bookcopies VALUES (4, 7455, 'Paperback');
INSERT INTO bookcopies VALUES (25, 7455, 'Hardcover');
INSERT INTO bookcopies VALUES (34, 7455, 'Paperback');
INSERT INTO bookcopies VALUES (49, 7455, 'Paperback');
INSERT INTO bookcopies VALUES (234, 7455, 'Paperback');
INSERT INTO bookcopies VALUES (47, 34, 'Paperback');
INSERT INTO bookcopies VALUES (4789, 34, 'Illustrated');
INSERT INTO bookcopies VALUES (7, 34, 'Paperback');
INSERT INTO bookcopies VALUES (2, 622, 'Illustrated');
INSERT INTO bookcopies VALUES (8, 622, 'Illustrated');
INSERT INTO bookcopies VALUES (9, 622, 'Illustrated');
INSERT INTO bookcopies VALUES (235, 622, 'Illustrated');
INSERT INTO bookcopies VALUES (333, 630, 'Paperback');
INSERT INTO bookcopies VALUES (334, 630, 'eBook');
INSERT INTO bookcopies VALUES (372, 81, 'eBook');
INSERT INTO bookcopies VALUES (237, 654, 'Hardcover');
INSERT INTO bookcopies VALUES (238, 654, 'Hardcover');
INSERT INTO bookcopies VALUES (411, 82, 'Audio Book');
INSERT INTO bookcopies VALUES (412, 82, 'Paperback');
INSERT INTO bookcopies VALUES (233, 82, 'Paperback');
INSERT INTO bookcopies VALUES (402, 652, 'Illustrated');
INSERT INTO bookcopies VALUES (400, 652, 'Illustrated');


INSERT INTO borrowers VALUES (7523, 'Simon', 'Charles', '1980-07-24', '19a Elmwood Drive',null, 'Lincoln', '7608');
INSERT INTO borrowers VALUES (65233, 'Charlie', 'Venz', '2013-11-05', '2 Windsor Rd', 'Hoon Hay', 'Christchurch', '8034');
INSERT INTO borrowers VALUES (533, 'Zhe', 'Wang', '2001-04-12', '3 Prebblewood Drive', null, 'Prebbleton','7601');
INSERT INTO borrowers VALUES (659, 'Di', 'Wang', '2003-11-25', '26 Kahu Rd', null, 'Lincoln', '7608');


-- INSERT LOAN DATA
-- This query could be simple like the one commented out below, but we use fancier code so that the dates will be more 
--    appropriate for your semester. 
/*
INSERT INTO loans VALUES(233444, 402, 7523, '2025-08-01', NULL);
INSERT INTO loans VALUES(2333546, 93, 7523, '2025-08-01', NULL);
INSERT INTO loans VALUES(2355546, 4789, 65233, '2025-06-10', NULL);
INSERT INTO loans VALUES(2395546, 4789, 533, '2024-09-01', '2024-10-02');
INSERT INTO loans VALUES(236, 4789, 7523, '2024-08-10', '2024-08-20');
INSERT INTO loans VALUES(54656, 47, 659, '2025-03-28', NULL);
INSERT INTO loans VALUES(5468956, 34, 659, '2025-03-28', '2025-05-14');
INSERT INTO loans VALUES(54660, 372, 533, '2025-07-10', NULL);
INSERT INTO loans VALUES(54657, 2, 659, '2025-07-10', '2025-07-16');
INSERT INTO loans VALUES(54658, 2, 65233, '2025-07-16', NULL);
INSERT INTO loans VALUES(23457, 412, 659, '2025-07-15', NULL);
INSERT INTO loans VALUES(226677, 234, 7523, '2023-12-27', NULL);
INSERT INTO loans VALUES(54678, 411, 533, '2025-05-14', '2025-06-13');
*/ 

-- This query inserts dates into the loan table that will make sense in the middle of your semester

-- Choose a fixed "mid-semester date" based on the current date and your semester rules.
-- Semester dates (wrapping year):
--   • From 10 Nov up to (but not including) 10 Feb  ⇒ use 6 Jan (next Jan if we're in Nov/Dec)
--   • From 10 Feb up to 7 Jul                       ⇒ use 21 Apr (same year)
--   • From 7 Jul up to 10 Nov                       ⇒ use 1 Sep (same year)

SET @today := CURDATE();
SET @md := DATE_FORMAT(@today, '%m-%d');

SET @mid_semester_date :=
  CASE
    WHEN (@md >= '11-10') OR (@md < '02-10') THEN
      -- If we're in Nov/Dec, use 6 Jan of next year; if we're in Jan before 10 Feb, use 6 Jan of this year
      STR_TO_DATE(CONCAT(YEAR(@today) + (DATE_FORMAT(@today,'%m') >= '11'), '-01-06'), '%Y-%m-%d')
    WHEN (@md >= '02-10') AND (@md < '07-07') THEN
      STR_TO_DATE(CONCAT(YEAR(@today), '-04-21'), '%Y-%m-%d')
    ELSE
      STR_TO_DATE(CONCAT(YEAR(@today), '-09-01'), '%Y-%m-%d')
  END;

-- Optional: quick check
-- SELECT @today AS server_today, @mid_semester_date AS mid_semester_date;

-- Inserts with dates relative to @mid_semester_date.
-- Offsets chosen so that if @mid_semester_date = '2025-08-15', these resolve to your original dates.
INSERT INTO loans VALUES(53667, 234, 7523, @mid_semester_date - INTERVAL 597 DAY, NULL);         -- 2023-12-27
INSERT INTO loans VALUES(53668, 4789, 7523, @mid_semester_date - INTERVAL 370 DAY, @mid_semester_date - INTERVAL 360 DAY); -- 2024-08-10 .. 2024-08-20
INSERT INTO loans VALUES(53669, 4789, 533,  @mid_semester_date - INTERVAL 348 DAY, @mid_semester_date - INTERVAL 317 DAY); -- 2024-09-01 .. 2024-10-02
INSERT INTO loans VALUES(53670, 47,   659,  @mid_semester_date - INTERVAL 140 DAY, NULL);         -- 2025-03-28
INSERT INTO loans VALUES(53671, 34,   659,  @mid_semester_date - INTERVAL 140 DAY, @mid_semester_date - INTERVAL 93 DAY);  -- 2025-03-28 .. 2025-05-14
INSERT INTO loans VALUES(53672, 411,  533,  @mid_semester_date - INTERVAL 93 DAY,  @mid_semester_date - INTERVAL 63 DAY);  -- 2025-05-14 .. 2025-06-13
INSERT INTO loans VALUES(53673, 4789, 65233,@mid_semester_date - INTERVAL 66 DAY,  NULL);         -- 2025-06-10
INSERT INTO loans VALUES(53674, 2,    659,  @mid_semester_date - INTERVAL 39 DAY,  @mid_semester_date - INTERVAL 30 DAY);  -- 2025-07-10 .. 2025-07-16
INSERT INTO loans VALUES(53675, 372,  533,  @mid_semester_date - INTERVAL 35 DAY,  NULL);         -- 2025-07-10
INSERT INTO loans VALUES(53676, 412,  659,  @mid_semester_date - INTERVAL 31 DAY,  NULL);         -- 2025-07-15
INSERT INTO loans VALUES(53677, 2,    65233,@mid_semester_date - INTERVAL 30 DAY,  NULL);         -- 2025-07-16
INSERT INTO loans VALUES(53678, 402,  7523, @mid_semester_date - INTERVAL 14 DAY,  NULL);         -- 2025-08-01
INSERT INTO loans VALUES(53679, 93,   7523, @mid_semester_date - INTERVAL 12 DAY,  NULL);         -- 2025-08-01


