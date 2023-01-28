-- SQL Script file to query the database and the output is log file

-- Start the spooling process
SPOOL C:\sqltemp\query_log.txt

-- sql files to be executed which stored in C:\sqltemp\

@C:\sqltemp\create_table.sql
PROMPT TABLE CREATED

@C:\sqltemp\sequence.sql
PROMPT SEQUENCE CREATED

@C:\sqltemp\fxn_sp_err_log.sql
PROMPT FUNCTION AND ERROR LOG SP CREATED

@C:\sqltemp\sp_new_cus_insert_update_delete.sql
PROMPT CUSTOMER SP CREATED

@C:\sqltemp\sp_new_odr_insert_update_delete.sql
PROMPT ORDER SP CREATED

@C:\sqltemp\sp_new_prd_insert_update_delete.sql
PROMPT PRODUCT SP CREATED

@C:\sqltemp\sp_sys_refcursor_op.sql
PROMPT SYS OUT SP CREATED

@C:\sqltemp\dummy_dataset.sql
PROMPT DUMMY DATA INSERTED

-- Stop the spooling process
SPOOL OFF

-- PROMPT - Display message indicating that the query has been executed and the output has been written to the log file
PROMPT Query executed and results written to query_log.txt

