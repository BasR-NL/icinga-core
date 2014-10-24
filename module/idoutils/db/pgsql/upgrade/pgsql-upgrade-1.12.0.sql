-- -----------------------------------------
-- upgrade path for Icinga 1.12.0
--
-- -----------------------------------------
-- Copyright (c) 2014 Icinga Development Team (http://www.icinga.org)
--
-- Please check http://docs.icinga.org for upgrading information!
-- -----------------------------------------

ALTER TABLE icinga_programstatus ADD COLUMN program_version TEXT default NULL;

-- -----------------------------------------
-- update dbversion
-- -----------------------------------------

SELECT updatedbversion('1.12.0');

