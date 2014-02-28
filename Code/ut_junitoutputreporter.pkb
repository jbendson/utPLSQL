CREATE OR REPLACE PACKAGE BODY utjunitoutputreporter
IS
   
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
$Log: ut_filereporter.pkb,v $
Revision 1.3  2005/05/25 12:56:59  chrisrimmer
Fixed file rerporter so it actually works. Doh!

Revision 1.2  2004/11/16 09:46:48  chrisrimmer
Changed to new version detection system.

Revision 1.1  2004/07/14 17:01:57  chrisrimmer
Added first version of pluggable reporter packages
 

************************************************************************/

   norows BOOLEAN;
   domdoc dbms_xmldom.DOMDocument;
   root_node dbms_xmldom.DOMNode;
   prev_case varchar2(100);
   test_case_count pls_integer;
   suite_element dbms_xmldom.DOMElement;
   suite_node dbms_xmldom.DOMNode;
   summary_element dbms_xmldom.DOMElement;
   summary_node dbms_xmldom.DOMNode;
   failure_count pls_integer;
   test_count pls_integer;
   error_count pls_integer;
   
   procedure reset_pkg_vars as
   begin
     norows := null;
     domdoc := null;
     root_node := null;
     prev_case := null;
     test_case_count := -1;
     suite_element := null;
     suite_node := null;
     summary_element := null;
     summary_node := null;
     failure_count := 0;
     test_count := 0;
     error_count := 0;     
   end;
   
   PROCEDURE open
   IS
   BEGIN
     reset_pkg_vars;
     domdoc := dbms_xmldom.newDomDocument;
     root_node := dbms_xmldom.makeNode(domdoc);
     summary_element := dbms_xmldom.createElement(domdoc, 'testsuites');
     dbms_xmldom.setAttribute(summary_element, 'tests', 0);
     dbms_xmldom.setAttribute(summary_element, 'failures', 0);
     dbms_xmldom.setAttribute(summary_element, 'disabled', 0);
     dbms_xmldom.setAttribute(summary_element, 'errors', 0);
     dbms_xmldom.setAttribute(summary_element, 'time', 0);
     dbms_xmldom.setAttribute(summary_element, 'name', 'AllTests');
     summary_node := dbms_xmldom.appendChild(root_node,dbms_xmldom.makeNode(summary_element));
   END;

   PROCEDURE close
   IS
     xt xmltype;
   BEGIN 
     xt := dbms_xmldom.getXmlType(domdoc);
     dbms_xmldom.freeDocument(domdoc);
     dbms_output.put_line(xt.getClobVal);
   END;

   PROCEDURE pl (str VARCHAR2)
   IS
     comment_element dbms_xmldom.DOMElement;
     comment_node dbms_xmldom.DOMNode;
   BEGIN
     comment_element := dbms_xmldom.createElement(domdoc, 'comment');
     dbms_xmldom.setAttribute(comment_element, 'text', str);
     comment_node := dbms_xmldom.appendChild(root_node,dbms_xmldom.makeNode(comment_element));
   END;
   
   PROCEDURE before_results(run_id IN utr_outcome.run_id%TYPE)
   IS     
   BEGIN        
     suite_element := dbms_xmldom.createElement(domdoc, 'testsuite');
     dbms_xmldom.setAttribute(suite_element, 'name', utplsql.currpkg);
     dbms_xmldom.setAttribute(suite_element, 'tests', 0);
     dbms_xmldom.setAttribute(suite_element, 'failures', 0);
     dbms_xmldom.setAttribute(suite_element, 'disabled', 0);
     dbms_xmldom.setAttribute(suite_element, 'errors', 0);
     dbms_xmldom.setAttribute(suite_element, 'time', 0);
     suite_node := dbms_xmldom.appendChild(summary_node, dbms_xmldom.makeNode(suite_element));
   END;

   FUNCTION show_test_case RETURN dbms_xmldom.DOMNode
   IS
     case_element dbms_xmldom.DOMElement;
     test_case varchar2(100);
   BEGIN
     test_case := substr(utreport.outcome.description, 1, instr(utreport.outcome.description, ':') - 1);
     if test_case <> nvl(prev_case, '_') then
       test_case_count := -1;
     end if;
     test_case_count := test_case_count + 1;
     prev_case := test_case;
     test_case := test_case || '.' || test_case_count;
     
     case_element := dbms_xmldom.createElement(domdoc, 'testcase');
     dbms_xmldom.setAttribute(case_element, 'name', test_case);
     dbms_xmldom.setAttribute(case_element, 'status', 'run');
     dbms_xmldom.setAttribute(case_element, 'time', 0);
     dbms_xmldom.setAttribute(case_element, 'classname', utplsql.currpkg);
     return dbms_xmldom.appendChild(suite_node, dbms_xmldom.makeNode(case_element));  
   END;
   
   PROCEDURE show_failure
   IS
     case_node dbms_xmldom.DOMNode;
     failure_element dbms_xmldom.DOMElement; 
     failure_node dbms_xmldom.DOMNode;
   BEGIN
     case_node := show_test_case;
     failure_element := dbms_xmldom.createElement(domdoc, 'failure');
     dbms_xmldom.setAttribute(failure_element, 'message', utreport.outcome.description);
     dbms_xmldom.setAttribute(failure_element, 'type', null);
     failure_node := dbms_xmldom.appendChild(case_node, dbms_xmldom.makeNode(failure_element));  
   END;

   PROCEDURE show_result
   IS
     case_node dbms_xmldom.DOMNode;
   BEGIN
    test_count := test_count + 1;
    if utreport.outcome.status = 'FAILURE' then
      failure_count := failure_count + 1;
      show_failure;
    elsif utreport.outcome.status = 'ERROR' then
      error_count := error_count + 1; 
      show_error;
    else
      case_node := show_test_case;
    end if;
  END;

   PROCEDURE after_results(run_id IN utr_outcome.run_id%TYPE)
   IS
   BEGIN
     dbms_xmldom.setAttribute(suite_element, 'tests', test_count);
     dbms_xmldom.setAttribute(suite_element, 'failures', failure_count);
     dbms_xmldom.setAttribute(suite_element, 'errors', error_count);
     dbms_xmldom.setAttribute(summary_element, 'tests', dbms_xmldom.getAttribute(summary_element, 'tests') + test_count);
     dbms_xmldom.setAttribute(summary_element, 'failures', dbms_xmldom.getAttribute(summary_element, 'failures') + failure_count);
     dbms_xmldom.setAttribute(summary_element, 'errors', dbms_xmldom.getAttribute(summary_element, 'errors') + error_count);   
     test_count := 0;
     failure_count := 0;
     error_count := 0;
   END;

   PROCEDURE before_errors(run_id IN utr_error.run_id%TYPE)
   IS
   BEGIN
     null;
   END;

   PROCEDURE show_error
   IS
     case_node dbms_xmldom.DOMNode;
     error_element dbms_xmldom.DOMElement; 
     error_node dbms_xmldom.DOMNode;
   BEGIN
     case_node := show_test_case;
     error_element := dbms_xmldom.createElement(domdoc, 'error');
     dbms_xmldom.setAttribute(error_element, 'message', utreport.outcome.description);
     dbms_xmldom.setAttribute(error_element, 'type', null);
     error_node := dbms_xmldom.appendChild(case_node, dbms_xmldom.makeNode(error_element));  
   END;

   PROCEDURE after_errors(run_id IN utr_error.run_id%TYPE)
   IS
   BEGIN
     null;
   END;

END;
/