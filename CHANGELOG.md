# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a
Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased] - 2019-06-24
### Added
- Implement forms and other partials.
- Create icon.
- Hard-code some of the sample data.
- Add table definitions.
- Add `alter` statements temporarily to upgrade old database
  (see docs/setup-tables.sql).
- Create sequence for `ScheduleItems` primary key.

### Changed
- Manually specify primary key value so that sequence and trigger are
  not needed (so, for example, testing as Oracle SYSDBA is possible).
- Rename db user from appwd and appwdsetup to pbapp and pbappsetup.
- Change `time` to `char(5)` (fix PL/SQL syntax).
- Refererence Weeks not Week (fix bug).
- Correct use of precision (first param counts all digits, including
  count specified as second param).
- Increase string sizes to account for sample data.
- Change `number(22)` to `varchar2(22)` (fix bug).
- Change foreign key PP_Id in People to `integer` (allow relationship).
- Add `not null` as necessary to allow setting `primary key`.
