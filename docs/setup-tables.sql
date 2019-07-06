connect appwdsetup/arst2020#PW

create table PeopleFlagsTypes (
    PFT_Id integer not null,
    PFT_Note varchar2(16),
    PFT_Color varchar2(20),
    PFT_Show number(1),
    constraint pft_pk primary key (PFT_Id)
);

create sequence pft_id_seq;
create or replace trigger pft_id_trg 
before insert on PeopleFlagsTypes 
for each row
when (new.PFT_Id is null)
begin
  select pft_id_seq.nextval
  into   :new.PFT_Id
  from   dual;
end;
/*(“SQL - How to create id with auto_increment on Oracle?,” 2018)*/

create table WorkPermissionsTypes (
    WPT_Id integer not null,
    WPT_Name varchar2(16),
    WPT_Color varchar2(20),
    constraint wpt_pk primary key (WPT_Id)
);

create table PFTPreventsWPT (
    PFT_Id integer,
    WPT_Id integer,
    constraint ppw_pk primary key (PFT_Id, WPT_Id),
    constraint ppw_pft_id_fk
        foreign key (PFT_Id)
        references PeopleFlagsTypes (PFT_Id),
    constraint ppw_wpt_id_fk
        foreign key (WPT_Id)
        references WorkPermissionsTypes (WPT_Id)
);

create table PeopleUnavailableReasonsTypes (
    PURT_Id integer not null,
    PURT_ShowOnWeekAs varchar2(25),
    constraint purt_pk primary key (PURT_Id)
);

create table PeoplePhases (
    PP_Id integer
);

create table People (
    P_Id integer not null,
    P_LastName varchar2(25),
    P_FirstName varchar2(25),
    P_MiddleName varchar2(25),
    PP_Id varchar2(25),
    PP_Active number(1),
    PP_Note varchar2(25),
    constraint p_pk primary key (P_Id),
    constraint p_pp_id_fk
        foreign key (PP_Id)
        references PeoplePhases (PP_Id)
);

create table WorkPermissions (
    P_Id integer,
    WPT_Id integer,
    constraint wp_pk primary key (P_Id, WPT_Id),
    constraint wp_p_id_fk
        foreign key (P_Id)
        references People (P_Id),
    constraint wp_wpt_id_fk
        foreign key (WPT_Id)
        references WorkPermissionsTypes (WPT_Id)
);
/*
    constraint wp_p_wpt_unique
        unique (P_Id, WPT_Id), */
create table PeopleUnavailableReasons (
    PUR_Id integer not null,
    P_Id integer,
    PURT_Id varchar2(25),
    PUR_Date DATE,
    PUR_ShowOnWeekAs varchar2(25),
    PUR_Active number(1),
    constraint pur_pk primary key (PUR_Id),
    constraint pur_p_id_fk
        foreign key (P_Id)
        references People (P_Id)
);

create table PeopleFlags (
    P_Id integer,
    PFT_Id integer,
    constraint pf_pk primary key (P_Id, PFT_Id),
    constraint pf_p_id_fk
        foreign key (P_Id)
        references People (P_Id),
    constraint pf_pft_id_fk
        foreign key (PFT_Id)
        references PeopleFlagsTypes (PFT_Id)
);
    /*constraint pf_p_pft_unique unique (P_Id, PFT_Id),*/

create table Weeks (
    W_Id number(6),
    W_FirstDate DATE,
    W_LastDate DATE,
    constraint w_pk primary key (W_Id)
);
/*(“Oracle / PLSQL: unique constraints,” n.d.)*/

create table WeekScheduleColumns (
    WSC_Id integer,
    WSC_ShowAs varchar2(20),
    constraint wsc_pk primary key (WSC_Id),
    constraint wsc_name_unique unique (WSC_ShowAs)
);
/*(“Oracle / PLSQL: unique constraints,” n.d.)*/

create table ScheduleItemsReasons (
    SIR_Id integer not null,
    SIR_WarnOnChange number(1),
    SIR_Note number(22),
    SIR_Color varchar2(20),
    constraint sir_pk primary key (SIR_Id)
);

create table ActivitiesTypes (
    AT_Id integer not null,
    WPT_Id integer,
    SIR_Id integer,
    PP_Id integer,
    AT_ShowOnDay number(1),
    AT_ShowOnDayAs varchar2(20)
    AT_ShowOnWeekAs varchar2(16),
    AT_Bold number(1),
    AT_Italics number(1),
    AT_FGColor varchar2(20),
    AT_BGColor varchar2(20),
    AT_TimeOnWeekAs varchar2(20),
    AT_TimeColor varchar2(20),
    AT_LimitPerWeek number(1),
    AT_FractionOfDay number(1,3),
    AT_Available number(1),
    constraint at_pk primary key (AT_Id),
    constraint at_sir_id_fk
        foreign key (SIR_Id)
        references ScheduleItemsReasons (SIR_Id),
    constraint at_pp_id_fk
        foreign key (PP_Id)
        references PeoplePhases (PP_Id),
    constraint at_wpt_id_fk
        foreign key (WPT_Id)
        references WorkPermissionsTypes (WPT_Id)
);
/*AT_ShowOnWeekAs overrides SlotCodes.SC_ShowOnWeekAs*/

create table ScheduleItems (
    SI_Id integer not null,
    P_Id number not null,
    W_Id integer not null,
    WSC_Id integer not null,
    AT_Id number not null,
    SI_Time time,
    SI_ShowOnWkAs varchar2(16),
    SIR_Id integer,
    constraint si_pk primary key (SI_Id),
    constraint si_p_id_fk
        foreign key (P_Id)
        references People (P_Id),
    constraint si_w_id_fk
        foreign key (W_Id)
        references Week (W_Id),
    constraint si_wsc_id_fk
        foreign key (WSC_Id)
        references WeekScheduleColumns (WSC_Id),
    constraint si_at_id_fk
        foreign key (AT_Id)
        references ActivitiesTypes (AT_Id),
    constraint si_sir_id_fk
        foreign key (SIR_Id)
        references ScheduleItemsReasons (SIR_Id)
);
/* If SI_ShowOnWkAs is not null, it overrides the related value of AT_ShowOnWeekAs*/



/*
* `^` Light Purple, & caret: class (stays same each week, but edited
  after group's 4 weeks are complete)
* Dark Purple: Keep day off after overnight desk (don't change)
* Yellow don't change ('higher up decision', filling in for staff, or resident requested day off)
*/

grant select, insert, update, delete on PeopleFlagsTypes to WD_DBA_ROLE;
grant select, insert, update, delete on WorkPermissionsTypes to WD_DBA_ROLE;
grant select, insert, update, delete on PeopleUnavailableReasonsTypes to WD_DBA_ROLE;
grant select, insert, update, delete on PeoplePhases to WD_DBA_ROLE;
grant select, insert, update, delete on People to WD_DBA_ROLE;
grant select, insert, update, delete on WorkPermissions to WD_DBA_ROLE;
grant select, insert, update, delete on PeopleUnavailableReasons to WD_DBA_ROLE;
grant select, insert, update, delete on PeopleFlags to WD_DBA_ROLE;
grant select, insert, update, delete on Weeks to WD_DBA_ROLE;
grant select, insert, update, delete on WeekScheduleColumns to WD_DBA_ROLE;
grant select, insert, update, delete on ScheduleItemsReasons to WD_DBA_ROLE;
grant select, insert, update, delete on ActivitiesTypes to WD_DBA_ROLE;
grant select, insert, update, delete on ScheduleItems to WD_DBA_ROLE;

create view PublishScheduleItemsView as
    select *
    from ScheduleItems;

grant select on PublishScheduleItemsView TO WD_PUBLISH_SCHEDULE_ROLE;

/*                           References

Oracle / PLSQL: unique constraints. (n.d.). Retrieved June 22, 2019, from TechOnTheNet website: https://www.techonthenet.com/oracle/unique.php

SQL - How to create id with auto_increment on Oracle? (2018, March 16). Retrieved June 24, 2019, from Stack Overflow website: https://stackoverflow.com/questions/11296361/how-to-create-id-with-auto-increment-on-oracle/24222811
*/
