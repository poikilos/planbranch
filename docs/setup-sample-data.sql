/*
insert into PeopleFlagsTypes(PFT_Id, PFT_Name, PFT_Color, PFT_Publish)
values(1, 'no truck/store', 'purple', 0);
*/
insert into PeopleFlagsTypes values(1, 'no truck/store' , 'purple', 0);
insert into PeopleFlagsTypes values(2, 'light duty'     , 'yellow', 1);

insert into WorkPermissionsTypes values(1, 'TRUCK', 'steelblue');
insert into WorkPermissionsTypes values(2, 'Lighthouse', 'darkorange');
insert into WorkPermissionsTypes values(3, 'Kitchen', 'limegreen');
insert into WorkPermissionsTypes values(4, 'Desk', 'gold');
insert into WorkPermissionsTypes values(5, 'Lab', 'gray');

insert into PFTPreventsWPT values(1, 1);
insert into PFTPreventsWPT values(1, 2);
insert into PFTPreventsWPT values(2, 1);
insert into PFTPreventsWPT values(2, 2);
insert into PFTPreventsWPT values(2, 3);
insert into PFTPreventsWPT values(2, 5);

insert into PeoplePhases values(1);
insert into PeoplePhases values(2);
insert into PeoplePhases values(3);
/*                       ID  Last     ,      First,    Middle,Phas, A, Note*/
insert into People values(1, 'Duggery',    'Strom', 'Anonymous', 3, 1, null);
insert into People values(2, 'Carlton',      'Ben', 'Anonymous', 3, 1, null);
insert into People values(3, 'Alto',        'Brad', 'Anonymous', 3, 1, null);
insert into People values(4, 'Spelt',       'Brad', 'Anonymous', 3, 1, null);
insert into People values(5, 'Amos',        'Carl', 'Anonymous', 3, 1, null);
insert into People values(6, 'Thompson',   'Colin', 'Anonymous', 3, 1, null);
insert into People values(7, 'Jamison',     'Carl', 'Anonymous', 3, 1, null);
insert into People values(8, 'Ramos',     'Daniel', 'Anonymous', 3, 1, null);
insert into People values(16, 'Hendricks', 'Hanso', 'Anonymous', 3, 1, null);

insert into PeopleUnavailableReasonsTypes values(1, 'In School');
insert into PeopleUnavailableReasonsTypes values(2, 'Employed');

insert into PeopleUnavailableReasons values(1, 16, 1, to_date('2018-10-08', 'YYYY-MM-DD'), 'STUDENT - P', 1);
insert into PeopleUnavailableReasons values(2, 16, 2, to_date('2018-12-27', 'YYYY-MM-DD'), 'EMPLOYED - P...',  1);

insert into WorkPermissions values(3, 1);
insert into WorkPermissions values(6, 4);
insert into WorkPermissions values(7, 3);
insert into WorkPermissions values(8, 1);

insert into ScheduleItemsReasons values(1, 1, 'other reason'         , 'yellow');
insert into ScheduleItemsReasons values(2, 1, 'directive from mgmt'  , 'yellow');
/* formerly 2 */
insert into ScheduleItemsReasons values(3, 1, 'personal appt.'       , null);
/* formerly 1 */
insert into ScheduleItemsReasons values(4, 1, 'fill in for staff'    , 'yellow');
insert into ScheduleItemsReasons values(5, 1, 'day off requested'    , 'yellow');
insert into ScheduleItemsReasons values(6, 1, 'overnight last night' , 'purple');

/* SIR_Id is just a pre-fill value! The real value is in ScheduleItems */

/*                                 AT   WPT  SIR   PP    ShD  ShowOnDayAs,          ShowOnWeekAs,  Bold,Italics   FgColor,     Bg,    Tme,  TimeColor, Limt,Frac, Avail*/
insert into ActivitiesTypes values(1, null ,    3, null, 0, 'unavailable all day',        null,        0, 0,      null,    'gray',   null,       null, null, 1.0, 1);
/*The following two rows are for a work slot without any details yet*/
insert into ActivitiesTypes values(2, null , null, 1,    0, 'TBA work',                  'work',       0, 0,      null,      null,   null,       null, null, 0.5, 1);
insert into ActivitiesTypes values(3, null , null, 1,    0, 'TBA work**',                'work**',     0, 0,      null,      null, null,         null, null, 0.5, 1);
 /* work**: */
insert into ActivitiesTypes values(4,     4, null, 1,    1, 'Desk',                      'DESK',       1, 0,   'darkred',    null, null,         null, null, 0.5, 1);
/* work**: */
insert into ActivitiesTypes values(5,     3, null, 1,    1, 'Kitchen (*head chef)',      'Kitchen',    1, 0, 'limegreen',    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(6,     1, null, 1,    1, 'Truck',                     'TRUCK',      1, 0,        null,    null, null,         null, null, 1.0, 1);
/*work#1:*/
insert into ActivitiesTypes values(7,     2, null, 1,    1, 'Germantown Store',          'Lighthouse', 1, 0,'darkorange',    null, null,         null, null, 1.0, 1); 
insert into ActivitiesTypes values(8,  null, null, 1,    1, 'Sorting Room',              'work',       0, 0,        null,    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(9,  null, null,1,1,'Sorting Room Cardboard+Trash (see Greg)','work#4',0,0,       null,    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(10, null, null, 1,    1, 'Laundry',                   'work**',     0, 0,        null,    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(11, null, null,1,1,'Cleaning Detail: 1st and 2nd Floors', 'work#1+2',0,0,        null,    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(12, null, null,1,1,'Cleaning Detail: 3rd and 4th Floors', 'work#3+4', 0,0,       null,    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(13,null,null,1,1,'Cleaning Detail: Yard, Sidewalk, Lot, Back','work **',0,0,     null,    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(14, null, null, 1,    1, 'Special Detail - see Ron',   'work',      0,0,         null,    null, null,         null, null, 0.5, 1);
/*malleable half day off: */
insert into ActivitiesTypes values(15, null, null, 1,    0, null,                         'OFF',       0,0,        'red',    null, null,         null, null, 0.5, 1);
/*malleable full day off: */
insert into ActivitiesTypes values(16, null, null, 1,    0, null,                         'OFF',       0,0,        'red',    null, null,         null, null, 1.0, 1);
/*firm full day off: */
insert into ActivitiesTypes values(17, null, null, 1,    1, 'OFF',                        'OFF*',      0,0,        'red',    null, null,         null, null, 1.0, 1);
insert into ActivitiesTypes values(18, null, null, 1,    0, 'TABE',                          '&',      0,0,        'red',    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(19,    5, null, 1,    1, 'Lab Assistant',              null,        0,0,         null,    null, null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(20, null, null, 2,    1, 'Job Hunting on Days Listed', 'JbSrch',    0,0,         null,    null, null,         null, null, 1.0, 1);
insert into ActivitiesTypes values(21, null, null, null, 0, 'Counseling',                 null,        0,0,       null,      null, 'HH12',      'red',    1, 0.5, 1);
insert into ActivitiesTypes values(22, null, null, null, 0, 'Tutoring',                   null,        0,0,       null,      null, 'HH12',       null, null, 0.5, 1);
insert into ActivitiesTypes values(23, null, null, null, 0, 'Computer Class',             '^^',        0,0,         null,  'plum', null,         null, null, 0.5, 1);
insert into ActivitiesTypes values(24, null, null, null, 0, 'Other Class',                '^',         0,0,         null,  'plum', null,         null, null, 0.5, 1);


/*                            W,        first,        last */
insert into Weeks values(201910, to_date('2019-03-11', 'YYYY-MM-DD'), to_date('2019-03-17', 'YYYY-MM-DD'));
/* W_Id is to_number(to_char(W_FirstDate, YYYY) + to_char(W_FirstDate,'iw')) */
/* The ISO week 1, such as found via trunc(SomeDate,'iw'), is the first Monday of year (Hansen, 2016). */

insert into WeekScheduleColumns values(1,'MON');
insert into WeekScheduleColumns values(2,'TUE');
insert into WeekScheduleColumns values(3,'WED');
insert into WeekScheduleColumns values(4,'THU');
insert into WeekScheduleColumns values(5,'FRI');
insert into WeekScheduleColumns values(6,'SAT');
insert into WeekScheduleColumns values(7,'SUN');

/* If SI_ShowOnWkAs is not null, it overrides the related value of AT_ShowOnWeekAs
(recommended when AT_ShowOnWeekAs is null)*/
/*                             SI_Id,  P,      W, WSC, AT, Time                     , ShowOnWkAs, SIR*/




insert into ScheduleItems values(1,  1, 201910,   1,  8, null                     , null     , null);
insert into ScheduleItems values(2,  1, 201910,   1, 21, '14:00', null     , null);
insert into ScheduleItems values(3,  1, 201910,   2,  2, null                     , null     , null);
insert into ScheduleItems values(4,  1, 201910,   2, 21, '14:00', null     , null);
insert into ScheduleItems values(5,  1, 201910,   3,  2, null                     , null     , null);
insert into ScheduleItems values(6,  1, 201910,   3, 22, null                     , null     , null);
insert into ScheduleItems values(7,  1, 201910,   3, 20, '14:00', null     , null);
insert into ScheduleItems values(8,  1, 201910,   4,  7, null                     , null     , null);
insert into ScheduleItems values(9,  1, 201910,   5, 15, null                     , null     , null);
insert into ScheduleItems values(10,  1, 201910,   6,  2, null                     , null     , null);
insert into ScheduleItems values(11,  1, 201910,   7, 15, null                     , null     , null);
insert into ScheduleItems values(12,  2, 201910,   1,  8, null                     , null     , null);
insert into ScheduleItems values(13,  2, 201910,   1, 20, '13:00', null     , null);
insert into ScheduleItems values(14,  2, 201910,   2, 19, null                     , null     , 1);
insert into ScheduleItems values(15,  2, 201910,   2,  2, null                     , null     , null);
insert into ScheduleItems values(16,  2, 201910,   3, 19, null                     , null     , null);
insert into ScheduleItems values(17,  2, 201910,   4,  2, null                     , null     , null);
insert into ScheduleItems values(18,  2, 201910,   5,  2, null                     , null     , null);
insert into ScheduleItems values(19,  2, 201910,   6, 19, null                     , null     , null);
insert into ScheduleItems values(20,  2, 201910,   7, 15, null                     , null     , null);
insert into ScheduleItems values(21,  3, 201910,   1,  8, null                     , null     , null);
insert into ScheduleItems values(22,  3, 201910,   1,  6, null                     , null     , null);
insert into ScheduleItems values(23,  3, 201910,   2,  2, null                     , null     , null);
insert into ScheduleItems values(24,  3, 201910,   2, 20, '13:00', null     , null);
insert into ScheduleItems values(25,  3, 201910,   3, 19, null                     , null     , null);
insert into ScheduleItems values(26,  3, 201910,   4,  7, null                     , null     , null);
insert into ScheduleItems values(27,  3, 201910,   5,  2, null                     , null     , null);
insert into ScheduleItems values(28,  3, 201910,   5, 19, null                     , null     , null);
insert into ScheduleItems values(29,  3, 201910,   6, 19, null                     , null     , null);
insert into ScheduleItems values(30,  3, 201910,   7, 15, null                     , null     , null);

/*                        References

Hansen, K. (2016, March 4). Ask Tom week of year in SQL - confusing. Retrieved June 23, 2019, from https://asktom.oracle.com/pls/apex/asktom.search?tag=week-of-year-in-sql-confusing
*/
