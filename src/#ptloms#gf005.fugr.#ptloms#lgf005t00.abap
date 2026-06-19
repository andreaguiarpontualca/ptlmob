*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: /PTLOMS/TB036...................................*
DATA:  BEGIN OF STATUS_/PTLOMS/TB036                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/PTLOMS/TB036                 .
CONTROLS: TCTRL_/PTLOMS/TB036
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */PTLOMS/TB036                 .
TABLES: /PTLOMS/TB036                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
