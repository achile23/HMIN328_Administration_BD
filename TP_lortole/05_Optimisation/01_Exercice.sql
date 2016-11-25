/*
Vous reprendrez les questions pos ́ees lors du dernier TP concernant le recours `a l'index 1 dans
une s ́erie de requˆetes SQL sur la table Commune. Vous afficherez les plans propos ́es par l'optimiseur
pour chacune de ces questions et vous analyserez les r ́esultats obtenus. Vous pouvez aussi rapidement
dessiner les plans physiques destin ́es `
a l'ex ́ecution des requˆetes. Dans un second temps, soit vous
d ́esactiverez la contrainte de cl ́e primaire sur code_insee qui conduit `a la suppression de l'index, soit
vous exploiterez la directive NO INDEX et vous r ́e ́evaluerez les plans pr ́ec ́edents.
*/

/*1*/

explain plan for select code_insee from commune ;
select plan_table_output from table(dbms_xplan.display()) ;

/*
PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 4248164495

--------------------------------------------------------------------------------

| Id  | Operation	     | Name	  | Rows  | Bytes | Cost (%CPU)| Time|

--------------------------------------------------------------------------------

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |		  | 36318 |   177K|    24   (0)| 00:00:01 |

|   1 |  INDEX FAST FULL SCAN| PK_COMMUNE | 36318 |   177K|    24   (0)| 00:00:01 |
--------------------------------------------------------------------------------
*/

/*2*/

explain plan for select nom_Com from commune ;
select plan_table_output from table(dbms_xplan.display()) ;

/*
PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 1326938554

-----------------------------------------------------------------------------
| Id  | Operation	  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |	    | 36318 |	425K|	581   (1)| 00:00:07 |
|   1 |  TABLE ACCESS FULL| COMMUNE | 36318 |	425K|	581   (1)| 00:00:07 |
-----------------------------------------------------------------------------

8 rows selected.

*/


/*3*/

explain plan for select nom_Com from commune where code_insee='34192' ;
select plan_table_output from table(dbms_xplan.display()) ;
/*

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 3392824061

--------------------------------------------------------------------------------
----------

| Id  | Operation		    | Name	 | Rows  | Bytes | Cost (%CPU)|
Time	 |

--------------------------------------------------------------------------------
----------


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	    |		 |     1 |    17 |     2   (0)|
00:00:01 |

|   1 |  TABLE ACCESS BY INDEX ROWID| COMMUNE	 |     1 |    17 |     2   (0)|
00:00:01 |

|*  2 |   INDEX UNIQUE SCAN	    | PK_COMMUNE |     1 |	 |     1   (0)|
00:00:01 |

--------------------------------------------------------------------------------
----------

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("CODE_INSEE"='34192')

14 rows selected.


*/
/*4*/

explain plan for select nom_Com from commune where code_insee like '34%' ;
select plan_table_output from table(dbms_xplan.display()) ;
/*

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 3123005126

--------------------------------------------------------------------------------
----------

| Id  | Operation		    | Name	 | Rows  | Bytes | Cost (%CPU)|
Time	 |

--------------------------------------------------------------------------------
----------


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	    |		 |    17 |   289 |     5   (0)|
00:00:01 |

|   1 |  TABLE ACCESS BY INDEX ROWID| COMMUNE	 |    17 |   289 |     5   (0)|
00:00:01 |

|*  2 |   INDEX RANGE SCAN	    | PK_COMMUNE |    17 |	 |     2   (0)|
00:00:01 |

--------------------------------------------------------------------------------
----------

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("CODE_INSEE" LIKE '34%')
       filter("CODE_INSEE" LIKE '34%')

15 rows selected.


*/
/*5*/

explain plan for select nom_Com from commune where code_insee like '%392' ;
select plan_table_output from table(dbms_xplan.display()) ;
/*

*/
/*6*/

explain plan for select nom_Com from commune where code_insee >= 34 ;
select plan_table_output from table(dbms_xplan.display()) ;
/*

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 1326938554

-----------------------------------------------------------------------------
| Id  | Operation	  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |	    |  1816 | 30872 |	582   (1)| 00:00:07 |
|*  1 |  TABLE ACCESS FULL| COMMUNE |  1816 | 30872 |	582   (1)| 00:00:07 |
-----------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------

   1 - filter("CODE_INSEE" LIKE '%392')

13 rows selected.


*/
/*7*/

explain plan for select nom_Com from commune where code_insee in ('09330','09331','09332','09334');
select plan_table_output from table(dbms_xplan.display()) ;
/*

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 3876897031

--------------------------------------------------------------------------------
-----------

| Id  | Operation		     | Name	  | Rows  | Bytes | Cost (%CPU)|
 Time	  |

--------------------------------------------------------------------------------
-----------


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	     |		  |	4 |    68 |	6   (0)|
 00:00:01 |

|   1 |  INLIST ITERATOR	     |		  |	  |	  |	       |
	  |

|   2 |   TABLE ACCESS BY INDEX ROWID| COMMUNE	  |	4 |    68 |	6   (0)|
 00:00:01 |

|*  3 |    INDEX UNIQUE SCAN	     | PK_COMMUNE |	4 |	  |	5   (0)|
 00:00:01 |

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-----------


Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("CODE_INSEE"='09330' OR "CODE_INSEE"='09331' OR "CODE_INSEE"='0933
2'


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
	      OR "CODE_INSEE"='09334')

16 rows selected.

*/
