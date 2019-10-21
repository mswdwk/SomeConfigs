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

# mysql_alter_user
handle_connection {
  do_command{
    dispatch_command{
      mysql_parse{
        mysql_execute_command{
          mysql_alter_user{
            tables.init_one_table("mysql", 5, "user", 4, "user", TL_WRITE); 
            set_and_validate_user_attributes(thd, user_from, what_to_alter,is_privileged_user, "ALTER USER");
            int ret= replace_user_table(thd, table, user_from, 0, false, true);
          }
        }
      }
    }
  }
}