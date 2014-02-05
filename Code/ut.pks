CREATE OR REPLACE PACKAGE UT AUTHID CURRENT_USER AS 
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
$Log: ut.pks,v $
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
