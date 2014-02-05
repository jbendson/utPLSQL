CREATE OR REPLACE PACKAGE UT AS 
/************************************************************************
GNU General Public License for utPLSQL

Copyright (C) 2000-2003 
Steven Feuerstein and the utPLSQL Project
(steven@stevenfeuerstein.com)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program (see license.txt); if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
************************************************************************
$Log: ut.pkb,v $
Revision 1.0  2013/10/18 16:18  jdurango
Initial wrapper package for mostly used utplsql units.

************************************************************************/

   PROCEDURE test (
      package_in         IN   VARCHAR2,
      samepackage_in     IN   BOOLEAN := FALSE,
      prefix_in          IN   VARCHAR2 := NULL,
      recompile_in       IN   BOOLEAN := TRUE,
      dir_in             IN   VARCHAR2 := NULL,
      suite_in           IN   VARCHAR2 := NULL,
      owner_in           IN   VARCHAR2 := NULL,
      reset_results_in   IN   BOOLEAN := TRUE,
      from_suite_in      IN   BOOLEAN := FALSE,
      subprogram_in in varchar2 := '%',
      per_method_setup_in in boolean := FALSE, -- 2.0.8
	  override_package_in IN varchar2 := NULL -- 2.0.9.2
   -- If recompiling, then always looks for
   -- <pkg>.pks and <pkg>.pkb files
   );

   PROCEDURE testsuite (
      suite_in           IN   VARCHAR2,
      recompile_in       IN   BOOLEAN := TRUE,
      reset_results_in   IN   BOOLEAN := TRUE,
      per_method_setup_in in boolean := FALSE, -- 2.0.8
      override_package_in IN BOOLEAN := FALSE
   -- If recompiling, then always looks for
   -- <pkg>.pks and <pkg>.pkb files
   );

   /* Single package test engine. */
   -- 2.0.9.2: run a test package directly
   PROCEDURE run (
      testpackage_in     IN   VARCHAR2,
      prefix_in          IN   VARCHAR2 := NULL,
      suite_in           IN   VARCHAR2 := NULL,
      owner_in           IN   VARCHAR2 := NULL,
      reset_results_in   IN   BOOLEAN := TRUE,
      from_suite_in      IN   BOOLEAN := FALSE,
      subprogram_in in varchar2 := '%',
      per_method_setup_in in boolean := FALSE
   );

   PROCEDURE runsuite (
      suite_in           IN   VARCHAR2,
      reset_results_in   IN   BOOLEAN := TRUE,
      per_method_setup_in in boolean := FALSE
   );
   
   PROCEDURE assert_this (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   BOOLEAN,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE,
      register_in     IN   BOOLEAN := TRUE -- 2.0.1
   );

   PROCEDURE assert_eval (
      msg_in            IN   VARCHAR2,
          using_in IN VARCHAR2, -- The expression
          value_name_in IN utAssert2.value_name_tt,
          null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eval (
      msg_in            IN   VARCHAR2,
          using_in IN VARCHAR2, -- The expression
          value1_in IN VARCHAR2,
          value2_in IN VARCHAR2,
          name1_in IN VARCHAR2 := NULL,
          name2_in IN VARCHAR2 := NULL,
          null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eq (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      against_this_in   IN   VARCHAR2,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eq (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   DATE,
      against_this_in   IN   DATE,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE,
      truncate_in       IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eq (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   BOOLEAN,
      against_this_in   IN   BOOLEAN,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqtable (
      msg_in             IN   VARCHAR2,
      check_this_in      IN   VARCHAR2,
      against_this_in    IN   VARCHAR2,
      check_where_in     IN   VARCHAR2 := NULL,
      against_where_in   IN   VARCHAR2 := NULL,
      raise_exc_in       IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqtabcount (
      msg_in             IN   VARCHAR2,
      check_this_in      IN   VARCHAR2,
      against_this_in    IN   VARCHAR2,
      check_where_in     IN   VARCHAR2 := NULL,
      against_where_in   IN   VARCHAR2 := NULL,
      raise_exc_in       IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqquery (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      against_this_in   IN   VARCHAR2,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqqueryvalue (
      msg_in             IN   VARCHAR2,
      check_query_in     IN   VARCHAR2,
      against_value_in   IN   VARCHAR2,
      null_ok_in         IN   BOOLEAN := FALSE,
      raise_exc_in       IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqqueryvalue (
      msg_in             IN   VARCHAR2,
      check_query_in     IN   VARCHAR2,
      against_value_in   IN   DATE,
      null_ok_in         IN   BOOLEAN := FALSE,
      raise_exc_in       IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqqueryvalue (
      msg_in             IN   VARCHAR2,
      check_query_in     IN   VARCHAR2,
      against_value_in   IN   NUMBER,
      null_ok_in         IN   BOOLEAN := FALSE,
      raise_exc_in       IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqcursor (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      against_this_in   IN   VARCHAR2,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqfile (
      msg_in                IN   VARCHAR2,
      check_this_in         IN   VARCHAR2,
      check_this_dir_in     IN   VARCHAR2,
      against_this_in       IN   VARCHAR2,
      against_this_dir_in   IN   VARCHAR2 := NULL,
      raise_exc_in          IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqpipe (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      against_this_in   IN   VARCHAR2,
      check_nth_in      IN   VARCHAR2 := NULL,
      against_nth_in    IN   VARCHAR2 := NULL,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqcoll (
      msg_in                IN   VARCHAR2,
      check_this_in         IN   VARCHAR2,                     /* pkg1.coll */
      against_this_in       IN   VARCHAR2,                     /* pkg2.coll */
      eqfunc_in             IN   VARCHAR2 := NULL,
      check_startrow_in     IN   PLS_INTEGER := NULL,
      check_endrow_in       IN   PLS_INTEGER := NULL,
      against_startrow_in   IN   PLS_INTEGER := NULL,
      against_endrow_in     IN   PLS_INTEGER := NULL,
      match_rownum_in       IN   BOOLEAN := FALSE,
      null_ok_in            IN   BOOLEAN := TRUE,
      raise_exc_in          IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqcollapi (
      msg_in                IN   VARCHAR2,
      check_this_pkg_in     IN   VARCHAR2,
      against_this_pkg_in   IN   VARCHAR2,
      eqfunc_in             IN   VARCHAR2 := NULL,
      countfunc_in          IN   VARCHAR2 := 'COUNT',
      firstrowfunc_in       IN   VARCHAR2 := 'FIRST',
      lastrowfunc_in        IN   VARCHAR2 := 'LAST',
      nextrowfunc_in        IN   VARCHAR2 := 'NEXT',
      getvalfunc_in         IN   VARCHAR2 := 'NTHVAL',
      check_startrow_in     IN   PLS_INTEGER := NULL,
      check_endrow_in       IN   PLS_INTEGER := NULL,
      against_startrow_in   IN   PLS_INTEGER := NULL,
      against_endrow_in     IN   PLS_INTEGER := NULL,
      match_rownum_in       IN   BOOLEAN := FALSE,
      null_ok_in            IN   BOOLEAN := TRUE,
      raise_exc_in          IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_isnotnull (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   VARCHAR2,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_isnull (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   VARCHAR2,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_isnotnull (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   BOOLEAN,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_isnull (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   BOOLEAN,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE
   );

   --Check a given call throws a named exception
   PROCEDURE assert_throws (
      msg_in                VARCHAR2,
      check_call_in    IN   VARCHAR2,
      against_exc_in   IN   VARCHAR2
   );

   --Check a given call throws an exception with a given SQLCODE
   PROCEDURE assert_throws (
      msg_in                VARCHAR2,
      check_call_in    IN   VARCHAR2,
      against_exc_in   IN   NUMBER
   );

   PROCEDURE assert_showresults;

   PROCEDURE assert_noshowresults;

   FUNCTION assert_showing_results
      RETURN BOOLEAN;

   PROCEDURE assert_objExists (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

  PROCEDURE assert_objnotExists (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   );

   FUNCTION assert_previous_passed
       RETURN BOOLEAN;

   FUNCTION assert_previous_failed
       RETURN BOOLEAN;

   PROCEDURE assert_eqoutput (
      msg_in                IN   VARCHAR2,
      check_this_in         IN   DBMS_OUTPUT.CHARARR,
      against_this_in       IN   DBMS_OUTPUT.CHARARR,
      ignore_case_in        IN   BOOLEAN := FALSE,
      ignore_whitespace_in  IN   BOOLEAN := FALSE,
      null_ok_in            IN   BOOLEAN := TRUE,
      raise_exc_in          IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eqoutput (
      msg_in                IN   VARCHAR2,
      check_this_in         IN   DBMS_OUTPUT.CHARARR,
      against_this_in       IN   VARCHAR2,
      line_delimiter_in     IN   CHAR := NULL,
      ignore_case_in        IN   BOOLEAN := FALSE,
      ignore_whitespace_in  IN   BOOLEAN := FALSE,
      null_ok_in            IN   BOOLEAN := TRUE,
      raise_exc_in          IN   BOOLEAN := FALSE
   );

   PROCEDURE assert_eq_refc_table(
      p_msg_nm          IN   VARCHAR2,
      proc_name         IN   VARCHAR2,
      params            IN   utplsql_util.utplsql_params,
      cursor_position   IN   PLS_INTEGER,
      table_name        IN   VARCHAR2 );

   PROCEDURE assert_eq_refc_query(
      p_msg_nm          IN   VARCHAR2,
      proc_name         IN   VARCHAR2,
      params            IN   utplsql_util.utplsql_params,
      cursor_position   IN   PLS_INTEGER,
      qry               IN   VARCHAR2 );

END UT;
/


CREATE OR REPLACE PACKAGE BODY UT AS

   PROCEDURE test (
      package_in         IN   VARCHAR2,
      samepackage_in     IN   BOOLEAN := FALSE,
      prefix_in          IN   VARCHAR2 := NULL,
      recompile_in       IN   BOOLEAN := TRUE,
      dir_in             IN   VARCHAR2 := NULL,
      suite_in           IN   VARCHAR2 := NULL,
      owner_in           IN   VARCHAR2 := NULL,
      reset_results_in   IN   BOOLEAN := TRUE,
      from_suite_in      IN   BOOLEAN := FALSE,
      subprogram_in in varchar2 := '%',
      per_method_setup_in in boolean := FALSE, -- 2.0.8
	  override_package_in IN varchar2 := NULL -- 2.0.9.2
   ) AS
   BEGIN
    utplsql.test (
      package_in         ,
      samepackage_in     ,
      prefix_in          ,
      recompile_in       ,
      dir_in             ,
      suite_in           ,
      owner_in           ,
      reset_results_in   ,
      from_suite_in      ,
      subprogram_in,
      per_method_setup_in ,
	  override_package_in);
  END test;

   PROCEDURE testsuite (
      suite_in           IN   VARCHAR2,
      recompile_in       IN   BOOLEAN := TRUE,
      reset_results_in   IN   BOOLEAN := TRUE,
      per_method_setup_in in boolean := FALSE, -- 2.0.8
      override_package_in IN BOOLEAN := FALSE
   -- If recompiling, then always looks for
   -- <pkg>.pks and <pkg>.pkb files
   ) AS
   BEGIN
    utplsql.testsuite (
      suite_in           ,
      recompile_in       ,
      reset_results_in   ,
      per_method_setup_in,
      override_package_in);
  END testsuite;

   /* Single package test engine. */
   -- 2.0.9.2: run a test package directly
   PROCEDURE run (
      testpackage_in     IN   VARCHAR2,
      prefix_in          IN   VARCHAR2 := NULL,
      suite_in           IN   VARCHAR2 := NULL,
      owner_in           IN   VARCHAR2 := NULL,
      reset_results_in   IN   BOOLEAN := TRUE,
      from_suite_in      IN   BOOLEAN := FALSE,
      subprogram_in in varchar2 := '%',
      per_method_setup_in in boolean := FALSE
   ) AS
   BEGIN
    utplsql.run (
      testpackage_in     ,
      prefix_in          ,
      suite_in           ,
      owner_in           ,
      reset_results_in   ,
      from_suite_in      ,
      subprogram_in ,
      per_method_setup_in);
  END run;

   PROCEDURE runsuite (
      suite_in           IN   VARCHAR2,
      reset_results_in   IN   BOOLEAN := TRUE,
      per_method_setup_in in boolean := FALSE
   ) AS
   BEGIN
    utplsql.runsuite (
      suite_in           ,
      reset_results_in   ,
      per_method_setup_in);
  END runsuite;

  PROCEDURE assert_this (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   BOOLEAN,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE,
      register_in     IN   BOOLEAN := TRUE -- 2.0.1
   ) AS
  BEGIN
    utassert.this ( msg_in, check_this_in, null_ok_in, raise_exc_in, register_in);
  END assert_this;

  PROCEDURE assert_eval (
      msg_in            IN   VARCHAR2,
      using_in          IN VARCHAR2, -- The expression
      value_name_in     IN utAssert2.value_name_tt,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eval ( msg_in, using_in, value_name_in, null_ok_in, raise_exc_in);
  END assert_eval;

  PROCEDURE assert_eval (
      msg_in            IN   VARCHAR2,
          using_in IN VARCHAR2, -- The expression
          value1_in IN VARCHAR2,
          value2_in IN VARCHAR2,
          name1_in IN VARCHAR2 := NULL,
          name2_in IN VARCHAR2 := NULL,
          null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eval ( msg_in, using_in, value1_in, value2_in, name1_in, name2_in, null_ok_in, raise_exc_in);
  END assert_eval;

  PROCEDURE assert_eq (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      against_this_in   IN   VARCHAR2,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eq ( msg_in, check_this_in, against_this_in, null_ok_in, raise_exc_in);
  END assert_eq;

  PROCEDURE assert_eq (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   DATE,
      against_this_in   IN   DATE,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE,
      truncate_in       IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eq ( msg_in, check_this_in, against_this_in, null_ok_in, raise_exc_in, truncate_in);
  END assert_eq;

  PROCEDURE assert_eq (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   BOOLEAN,
      against_this_in   IN   BOOLEAN,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eq ( msg_in, check_this_in, against_this_in, null_ok_in, raise_exc_in);
  END assert_eq;

  PROCEDURE assert_eqtable (
      msg_in             IN   VARCHAR2,
      check_this_in      IN   VARCHAR2,
      against_this_in    IN   VARCHAR2,
      check_where_in     IN   VARCHAR2 := NULL,
      against_where_in   IN   VARCHAR2 := NULL,
      raise_exc_in       IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqtable ( msg_in, check_this_in, against_this_in, check_where_in, against_where_in, raise_exc_in);
  END assert_eqtable;

  PROCEDURE assert_eqtabcount (
      msg_in             IN   VARCHAR2,
      check_this_in      IN   VARCHAR2,
      against_this_in    IN   VARCHAR2,
      check_where_in     IN   VARCHAR2 := NULL,
      against_where_in   IN   VARCHAR2 := NULL,
      raise_exc_in       IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqtabcount ( msg_in, check_this_in, against_this_in, check_where_in, against_where_in, raise_exc_in);
  END assert_eqtabcount;

  PROCEDURE assert_eqquery (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      against_this_in   IN   VARCHAR2,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqquery ( msg_in, check_this_in, against_this_in, raise_exc_in);
  END assert_eqquery;

  PROCEDURE assert_eqqueryvalue (
      msg_in             IN   VARCHAR2,
      check_query_in     IN   VARCHAR2,
      against_value_in   IN   VARCHAR2,
      null_ok_in         IN   BOOLEAN := FALSE,
      raise_exc_in       IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqqueryvalue ( msg_in, check_query_in, against_value_in, null_ok_in, raise_exc_in);
  END assert_eqqueryvalue;

  PROCEDURE assert_eqqueryvalue (
      msg_in             IN   VARCHAR2,
      check_query_in     IN   VARCHAR2,
      against_value_in   IN   DATE,
      null_ok_in         IN   BOOLEAN := FALSE,
      raise_exc_in       IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqqueryvalue ( msg_in, check_query_in, against_value_in, null_ok_in, raise_exc_in);
  END assert_eqqueryvalue;

  PROCEDURE assert_eqqueryvalue (
      msg_in             IN   VARCHAR2,
      check_query_in     IN   VARCHAR2,
      against_value_in   IN   NUMBER,
      null_ok_in         IN   BOOLEAN := FALSE,
      raise_exc_in       IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqqueryvalue ( msg_in, check_query_in, against_value_in, null_ok_in, raise_exc_in);
  END assert_eqqueryvalue;

  PROCEDURE assert_eqcursor (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      against_this_in   IN   VARCHAR2,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqcursor ( msg_in, check_this_in, against_this_in, raise_exc_in);
  END assert_eqcursor;

  PROCEDURE assert_eqfile (
      msg_in                IN   VARCHAR2,
      check_this_in         IN   VARCHAR2,
      check_this_dir_in     IN   VARCHAR2,
      against_this_in       IN   VARCHAR2,
      against_this_dir_in   IN   VARCHAR2 := NULL,
      raise_exc_in          IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqfile ( msg_in, check_this_in, check_this_dir_in, against_this_in, against_this_dir_in, raise_exc_in);
  END assert_eqfile;

  PROCEDURE assert_eqpipe (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      against_this_in   IN   VARCHAR2,
      check_nth_in      IN   VARCHAR2 := NULL,
      against_nth_in    IN   VARCHAR2 := NULL,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqpipe ( msg_in, check_this_in, against_this_in, check_nth_in, against_nth_in, raise_exc_in);
  END assert_eqpipe;

  PROCEDURE assert_eqcoll (
      msg_in                IN   VARCHAR2,
      check_this_in         IN   VARCHAR2,                     /* pkg1.coll */
      against_this_in       IN   VARCHAR2,                     /* pkg2.coll */
      eqfunc_in             IN   VARCHAR2 := NULL,
      check_startrow_in     IN   PLS_INTEGER := NULL,
      check_endrow_in       IN   PLS_INTEGER := NULL,
      against_startrow_in   IN   PLS_INTEGER := NULL,
      against_endrow_in     IN   PLS_INTEGER := NULL,
      match_rownum_in       IN   BOOLEAN := FALSE,
      null_ok_in            IN   BOOLEAN := TRUE,
      raise_exc_in          IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqcoll ( msg_in, check_this_in, against_this_in, eqfunc_in, check_startrow_in, check_endrow_in, against_startrow_in, against_endrow_in, match_rownum_in, null_ok_in, raise_exc_in);
  END assert_eqcoll;

  PROCEDURE assert_eqcollapi (
      msg_in                IN   VARCHAR2,
      check_this_pkg_in     IN   VARCHAR2,
      against_this_pkg_in   IN   VARCHAR2,
      eqfunc_in             IN   VARCHAR2 := NULL,
      countfunc_in          IN   VARCHAR2 := 'COUNT',
      firstrowfunc_in       IN   VARCHAR2 := 'FIRST',
      lastrowfunc_in        IN   VARCHAR2 := 'LAST',
      nextrowfunc_in        IN   VARCHAR2 := 'NEXT',
      getvalfunc_in         IN   VARCHAR2 := 'NTHVAL',
      check_startrow_in     IN   PLS_INTEGER := NULL,
      check_endrow_in       IN   PLS_INTEGER := NULL,
      against_startrow_in   IN   PLS_INTEGER := NULL,
      against_endrow_in     IN   PLS_INTEGER := NULL,
      match_rownum_in       IN   BOOLEAN := FALSE,
      null_ok_in            IN   BOOLEAN := TRUE,
      raise_exc_in          IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqcollapi ( msg_in, check_this_pkg_in,
      against_this_pkg_in,
      eqfunc_in,
      countfunc_in,
      firstrowfunc_in,
      lastrowfunc_in,
      nextrowfunc_in,
      getvalfunc_in,
      check_startrow_in,
      check_endrow_in,
      against_startrow_in,
      against_endrow_in,
      match_rownum_in,
      null_ok_in,
      raise_exc_in);
  END assert_eqcollapi;

  PROCEDURE assert_isnotnull (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   VARCHAR2,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.isnotnull ( msg_in, check_this_in, null_ok_in, raise_exc_in);
  END assert_isnotnull;

  PROCEDURE assert_isnull (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   VARCHAR2,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.isnull ( msg_in, check_this_in, null_ok_in, raise_exc_in);
  END assert_isnull;

  PROCEDURE assert_isnotnull (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   BOOLEAN,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.isnotnull ( msg_in, check_this_in, null_ok_in, raise_exc_in);
  END assert_isnotnull;

  PROCEDURE assert_isnull (
      msg_in          IN   VARCHAR2,
      check_this_in   IN   BOOLEAN,
      null_ok_in      IN   BOOLEAN := FALSE,
      raise_exc_in    IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.isnull ( msg_in, check_this_in, null_ok_in, raise_exc_in);
  END assert_isnull;

  PROCEDURE assert_throws (
      msg_in                VARCHAR2,
      check_call_in    IN   VARCHAR2,
      against_exc_in   IN   VARCHAR2
   ) AS
  BEGIN
    utassert.throws ( msg_in, check_call_in, against_exc_in);
  END assert_throws;

  PROCEDURE assert_throws (
      msg_in                VARCHAR2,
      check_call_in    IN   VARCHAR2,
      against_exc_in   IN   NUMBER
   ) AS
  BEGIN
    utassert.throws ( msg_in, check_call_in, against_exc_in);
  END assert_throws;

  PROCEDURE assert_showresults AS
  BEGIN
    utassert.showresults;
  END assert_showresults;

  PROCEDURE assert_noshowresults AS
  BEGIN
    utassert.noshowresults;
  END assert_noshowresults;

  FUNCTION assert_showing_results
      RETURN BOOLEAN AS
  BEGIN
    RETURN utassert.showing_results;
  END assert_showing_results;

  PROCEDURE assert_objExists (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.objExists ( msg_in, check_this_in, null_ok_in, raise_exc_in);
  END assert_objExists;

  PROCEDURE assert_objnotExists (
      msg_in            IN   VARCHAR2,
      check_this_in     IN   VARCHAR2,
      null_ok_in        IN   BOOLEAN := FALSE,
      raise_exc_in      IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.objnotExists ( msg_in, check_this_in, null_ok_in, raise_exc_in);
  END assert_objnotExists;

  FUNCTION assert_previous_passed
       RETURN BOOLEAN AS
  BEGIN
    RETURN utassert.previous_passed;
  END assert_previous_passed;

  FUNCTION assert_previous_failed
       RETURN BOOLEAN AS
  BEGIN
    RETURN utassert.previous_failed;
  END assert_previous_failed;

  PROCEDURE assert_eqoutput (
      msg_in                IN   VARCHAR2,
      check_this_in         IN   DBMS_OUTPUT.CHARARR,
      against_this_in       IN   DBMS_OUTPUT.CHARARR,
      ignore_case_in        IN   BOOLEAN := FALSE,
      ignore_whitespace_in  IN   BOOLEAN := FALSE,
      null_ok_in            IN   BOOLEAN := TRUE,
      raise_exc_in          IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqoutput ( msg_in, check_this_in, against_this_in, ignore_case_in, ignore_whitespace_in, null_ok_in, raise_exc_in);
  END assert_eqoutput;

  PROCEDURE assert_eqoutput (
      msg_in                IN   VARCHAR2,
      check_this_in         IN   DBMS_OUTPUT.CHARARR,
      against_this_in       IN   VARCHAR2,
      line_delimiter_in     IN   CHAR := NULL,
      ignore_case_in        IN   BOOLEAN := FALSE,
      ignore_whitespace_in  IN   BOOLEAN := FALSE,
      null_ok_in            IN   BOOLEAN := TRUE,
      raise_exc_in          IN   BOOLEAN := FALSE
   ) AS
  BEGIN
    utassert.eqoutput ( msg_in, check_this_in, against_this_in, line_delimiter_in, ignore_case_in, ignore_whitespace_in, null_ok_in, raise_exc_in);
  END assert_eqoutput;

  PROCEDURE assert_eq_refc_table(
      p_msg_nm          IN   VARCHAR2,
      proc_name         IN   VARCHAR2,
      params            IN   utplsql_util.utplsql_params,
      cursor_position   IN   PLS_INTEGER,
      table_name        IN   VARCHAR2 ) AS
  BEGIN
    utassert.eq_refc_table ( p_msg_nm, proc_name, params, cursor_position, table_name);
  END assert_eq_refc_table;

  PROCEDURE assert_eq_refc_query(
      p_msg_nm          IN   VARCHAR2,
      proc_name         IN   VARCHAR2,
      params            IN   utplsql_util.utplsql_params,
      cursor_position   IN   PLS_INTEGER,
      qry               IN   VARCHAR2 ) AS
  BEGIN
    utassert.eq_refc_query ( p_msg_nm, proc_name, params, cursor_position, qry);
  END assert_eq_refc_query;

END UT;
/
