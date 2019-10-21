# Change password Commands
## 6.2.12 Server Handling of Expired Passwords
The client can reset the account password with ALTER USER or SET PASSWORD. After that has been
done, the server restores normal access for the session, as well as for subsequent connections that
use the account.

## [修改mysql用户密码](https://www.cnblogs.com/jyginger/archive/2011/04/27/2030017.html).
### mysqladmin
格式如下（其中，USER为用户名，PASSWORD为新密码）：
```
mysqladmin -u USER -p password PASSWORD
```
### update user
这种方式必须是先用root帐户登入mysql，然后执行：
```
UPDATE user SET password=PASSWORD('123456') WHERE user='root';
UPDATE mysql.user SET authentication_string=PASSWORD('123456') WHERE user='abc';
FLUSH PRIVILEGES;
```
### alter user 
* 不指定认证方式
```
alter user testuser@localhost identified by 'testpassword';
```
* 指定认证方式
```
alter user testuser@localhost identified with mysql_native_password by 'testpassword';
```
### create user 
```
create user abc@localhost identified with 'mysql_sm3_password' by 'abc';
```
### set password
这种方式也需要先用root命令登入mysql，然后执行：
```
SET PASSWORD FOR root=PASSWORD('123456');
```

# Functions to handle SET PASSWORD
{
    int set_var_password::check(THD *thd);
    int set_var_password::update(THD *thd);
    void set_var_password::print(THD *thd, String *str);
}

int set_var_password::update(THD *thd){
    // new_password: New password hash for host@user
    change_password(THD *thd, const char *host, const char *user,char *new_password){
        check_change_password()
        acl_user= find_acl_user(host, user, TRUE);
        combo->plugin= EMPTY_CSTR;
        combo->auth.str= new_password;
        combo->auth.length= new_password_len;
        ret= replace_user_table(thd, table, combo, 0, false, true, what_to_set);
    }
}

# mysql_create_user
bool mysql_create_user(THD *thd, List <LEX_USER> &list, bool if_not_exists){

}

# mysql_alter_user
bool mysql_alter_user(THD *thd, List <LEX_USER> &list, bool if_exists){

}

# append_user



## set password for abc=password('123');

···
#0  0x00000000016c92b4 in change_password (thd=0x7fd128000b60, host=0x202f8e1 "%", 
    user=0x7fd128007590 "abc", new_password=0x7fd1280075e8 "123456")
    at /home/mysql/repo/mysql-server/sql/auth/sql_user.cc:660
#1  0x00000000014780ff in set_var_password::update (this=0x7fd128007668, thd=0x7fd128000b60)
    at /home/mysql/repo/mysql-server/sql/set_var.cc:931
#2  0x0000000001477677 in sql_set_variables (thd=0x7fd128000b60, var_list=0x7fd128003250)
    at /home/mysql/repo/mysql-server/sql/set_var.cc:662
#3  0x000000000153d77c in mysql_execute_command (thd=0x7fd128000b60, first_level=true)
    at /home/mysql/repo/mysql-server/sql/sql_parse.cc:3677
#4  0x0000000001542931 in mysql_parse (thd=0x7fd128000b60, parser_state=0x7fd149af7690)
    at /home/mysql/repo/mysql-server/sql/sql_parse.cc:5582
#5  0x00000000015381bc in dispatch_command (thd=0x7fd128000b60, com_data=0x7fd149af7df0, 
    command=COM_QUERY) at /home/mysql/repo/mysql-server/sql/sql_parse.cc:1458
#6  0x00000000015370f0 in do_command (thd=0x7fd128000b60)
    at /home/mysql/repo/mysql-server/sql/sql_parse.cc:999
#7  0x000000000166838e in handle_connection (arg=0x4c112b0)
    at /home/mysql/repo/mysql-server/sql/conn_handler/connection_handler_per_thread.cc:300
#8  0x0000000001cdec24 in pfs_spawn_thread (arg=0x4c0ff90)
    at /home/mysql/repo/mysql-server/storage/perfschema/pfs.cc:2190
#9  0x00007fd161749dd5 in start_thread () from /lib64/libpthread.so.0
#10 0x00007fd160611b3d in clone () from /lib64/libc.so.6

## PASSWORD function related
### var old_passwords  and related functions
```
static Sys_var_uint Sys_old_passwords(
       "old_passwords",
       "Determine which hash algorithm to use when generating passwords using "
       "the PASSWORD() function",
       SESSION_VAR(old_passwords), CMD_LINE(REQUIRED_ARG),
       VALID_RANGE(0, 2), DEFAULT(0), BLOCK_SIZE(1), NO_MUTEX_GUARD,
       NOT_IN_BINLOG, ON_CHECK(old_passwords_check));
       
       
static size_t calculate_password(String *str, char *buffer)
change_password;
```


## UPDATE mysql.user SET authentication_string=PASSWORD('123456') WHERE user='abc'; 
```
#0  0x0000000000ee2f52 in my_make_scrambled_password_sha1 (
    to=0x7fbfd80072a8 '\217' <repeats 80 times>, password=0x7fbfd80065d0 "123456", pass_len=6)
    at /home/mysql/repo/mysql-server/sql/auth/password.c:245
#1  0x00000000013cde66 in calculate_password (str=0x7fbfd80065e8, 
    buffer=0x7fbfd80072a8 '\217' <repeats 80 times>)
    at /home/mysql/repo/mysql-server/sql/item_strfunc.cc:2184
#2  0x00000000013cdf38 in Item_func_password::fix_length_and_dec (this=0x7fbfd80071b0)
    at /home/mysql/repo/mysql-server/sql/item_strfunc.cc:2202
#3  0x0000000000fbc8db in Item_func::fix_fields (this=0x7fbfd80071b0, thd=0x7fbfd8000d80, 
    ref=0x7fbfd8006798) at /home/mysql/repo/mysql-server/sql/item_func.cc:246
#4  0x00000000013c6e3b in Item_str_func::fix_fields (this=0x7fbfd80071b0, thd=0x7fbfd8000d80, 
    ref=0x7fbfd8006798) at /home/mysql/repo/mysql-server/sql/item_strfunc.cc:105
#5  0x00000000014c1777 in setup_fields (thd=0x7fbfd8000d80, ref_pointer_array=..., fields=..., 
    want_privilege=1, sum_func_list=0x0, allow_sum_func=false, column_update=false)
    at /home/mysql/repo/mysql-server/sql/sql_base.cc:8968
#6  0x00000000015f1805 in mysql_prepare_update (thd=0x7fbfd8000d80, update_table_ref=0x7fbfd8006af0, 
    covering_keys_for_cond=0x7fbff9bc2350, update_value_list=...)
    at /home/mysql/repo/mysql-server/sql/sql_update.cc:1166
#7  0x00000000015eed0a in mysql_update (thd=0x7fbfd8000d80, fields=..., values=..., 
    limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7fbff9bc2458, 
    updated_return=0x7fbff9bc2450) at /home/mysql/repo/mysql-server/sql/sql_update.cc:293
#8  0x00000000015f6c3a in Sql_cmd_update::try_single_table_update (this=0x7fbfd8006ac0, 
    thd=0x7fbfd8000d80, switch_to_multitable=0x7fbff9bc24ff)
    at /home/mysql/repo/mysql-server/sql/sql_update.cc:2881
#9  0x00000000015f716b in Sql_cmd_update::execute (this=0x7fbfd8006ac0, thd=0x7fbfd8000d80)
    at /home/mysql/repo/mysql-server/sql/sql_update.cc:3008
#10 0x000000000153d19c in mysql_execute_command (thd=0x7fbfd8000d80, first_level=true)
    at /home/mysql/repo/mysql-server/sql/sql_parse.cc:3576
#11 0x0000000001542931 in mysql_parse (thd=0x7fbfd8000d80, parser_state=0x7fbff9bc3690)
    at /home/mysql/repo/mysql-server/sql/sql_parse.cc:5582
#12 0x00000000015381bc in dispatch_command (thd=0x7fbfd8000d80, com_data=0x7fbff9bc3df0, 
    command=COM_QUERY) at /home/mysql/repo/mysql-server/sql/sql_parse.cc:1458
#13 0x00000000015370f0 in do_command (thd=0x7fbfd8000d80)
    at /home/mysql/repo/mysql-server/sql/sql_parse.cc:999
#14 0x000000000166838e in handle_connection (arg=0x3acec20)
    at /home/mysql/repo/mysql-server/sql/conn_handler/connection_handler_per_thread.cc:300
#15 0x0000000001cdec24 in pfs_spawn_thread (arg=0x3c31880)
    at /home/mysql/repo/mysql-server/storage/perfschema/pfs.cc:2190
#16 0x00007fc01181bdd5 in start_thread () from /lib64/libpthread.so.0
#17 0x00007fc0106e3b3d in clone () from /lib64/libc.so.6
```

