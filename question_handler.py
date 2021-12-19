import sqlite3

con = sqlite3.connect('./questions.db')

cur = con.cursor()

cur.execute('CREATE TABLE IF NOT EXISTS questions(key TEXT NOT NULL, question TEXT NOT NULL);')
cur.execute('DELETE FROM questions;')
# All the questions
questions_list = [
    ('WelcomeMessage', 'Welcome! Press Next to continue.'),
    ('StartQuestion', 'So you want to watch YouTube?'),
    ('CollabSingleQuestion', 'Do you want a collab or single channel?'),
    ('NewOldVideosQuestion', 'Do you want to watch new video or two year old videos? '),
    ('RelationshipsQuestion', 'People in relationships make you...'),
    ('DoctorWhoQuestion', 'Are you obsessed with doctor who?'),
    ('HowManyPeopleQuestion', 'How many people do you want to watch?'),
    ('ShortTallQuestion', 'Do you want to watch short or tall people?'),
    ('GirlsBoysQuestion', 'Girls Or Boys?'),
    ('AccentQuestion', 'What kind of accent do you like?'),
    ('CanadaQuestion', 'Canada\'s cool, right?'),
    ('FunnierQuestion', 'Which is funnier?'),
    ('DavidTennantQuestion', 'Do you find David Tennant attractive?'),
    ('InstrumentBoysQuestion', 'Well then, are boys who play an instrument hot?'),
    ('ScriptedSpontaneousQuestion', 'Do you prefer scripted or spontaneous videos?'),
    ('TwilightQuestion', 'Do you hate twilight?'),
]
cur.executemany('INSERT INTO questions VALUES (?, ?);', questions_list)

con.commit()

con.close()