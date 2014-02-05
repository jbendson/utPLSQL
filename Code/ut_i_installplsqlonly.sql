SET TERMOUT OFF
SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF 
SET TTITLE OFF

SET SERVEROUTPUT ON SIZE 1000000 FORMAT WRAPPED
SET DEFINE ON
SPOOL ut_i_install.log

----------------------------------------------------PACKAGE HEADERS
SET TERMOUT ON
PROMPT &line1
PROMPT CREATING &UT PACKAGE HEADERS
PROMPT &line1

DEFINE prompt_text='Creating &UT package specification '

@@ut_i_packages

----------------------------------------------------PACKAGE BODIES
SET TERMOUT ON
PROMPT &line1
PROMPT CREATING &UT PACKAGE BODIES
PROMPT &line1

DEFINE prompt_text='Creating &UT package body '

@@ut_i_packages_b

SET TERMOUT OFF
SPOOL OFF

----------------------------------------------------GENERIC SCRIPTS

@@ut_i_synonyms

@@ut_i_grants
