
kinit -kt /etc/hadoopeco.keytab hdfs/host-10-0-129-8@CHLOE
hdfs dfsadmin -refreshServiceAcl
hdfs dfsadmin -refreshUserToGroupsMappings
hdfs dfsadmin -refreshSuperUserGroupsConfiguration
 
# 리소스 매니저 적용
kinit -kt /etc/hadoopeco.keytab yarn/{host_name}@{realm_name}
yarn rmadmin -refreshSuperUserGroupsConfiguration
yarn rmadmin -refreshUserToGroupsMappings
yarn rmadmin -refreshAdminAcls
yarn rmadmin -refreshServiceAcl

