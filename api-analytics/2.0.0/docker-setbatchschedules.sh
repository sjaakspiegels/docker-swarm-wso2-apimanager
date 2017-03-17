#!/bin/bash

# temp folder to unpack car file
mkdir /tempcar

CarPath='/wso2analytics/repository/deployment/server/carbonapps'

# unzip one of the car files
unzip $CarPath/org_wso2_carbon_analytics_apim-1.0.0.car -d /tempcar
    
cd /tempcar 

# APIM_INCREMENTAL_PROCESSING_SCRIPT
xmlstarlet edit --inplace \
    -u "/Analytics/CronExpression" -v \
       "${WSO2_DAS_APIM_INCREMENTAL_PROCESSING_SCRIPT:-0 0/2 * 1/1 * ?}" \
    APIM_INCREMENTAL_PROCESSING_SCRIPT_1.0.0/APIM_INCREMENTAL_PROCESSING_SCRIPT.xml
 
# APIM_LAST_ACCESS_TIME_SCRIPT
xmlstarlet edit --inplace \
    -u "/Analytics/CronExpression" -v \
       "${WSO2_DAS_APIM_LAST_ACCESS_TIME_SCRIPT:-0 0/5 * 1/1 * ? *}" \
    APIM_LAST_ACCESS_TIME_SCRIPT_1.0.0/APIM_LAST_ACCESS_TIME_SCRIPT.xml

# APIM_LATENCY_BREAKDOWN_STATS
xmlstarlet edit --inplace \
    -u "/Analytics/CronExpression" -v \
       "${WSO2_DAS_APIM_LATENCY_BREAKDOWN_STATS:-0 0/5 * 1/1 * ? *}" \
    APIM_LATENCY_BREAKDOWN_STATS_1.0.0/APIM_LATENCY_BREAKDOWN_STATS.xml

# APIM_LOGANALYZER_SCRIPT
xmlstarlet edit --inplace \
    -u "/Analytics/CronExpression" -v \
       "${WSO2_DAS_APIM_LOGANALYZER_SCRIPT:-0 0/15 * 1/1 * ? *}" \
    APIM_LOGANALYZER_SCRIPT_1.0.0/APIM_LOGANALYZER_SCRIPT.xml

# APIM_STAT_SCRIPT
xmlstarlet edit --inplace \
    -u "/Analytics/CronExpression" -v \
       "${WSO2_DAS_APIM_STAT_SCRIPT:-0 0/2 * 1/1 * ?}" \
    APIM_STAT_SCRIPT_1.0.0/APIM_STAT_SCRIPT.xml

# APIM_STAT_SCRIPT_THROTTLE
xmlstarlet edit --inplace \
    -u "/Analytics/CronExpression" -v \
       "${WSO2_DAS_APIM_STAT_SCRIPT_THROTTLE:-0 0/2 * 1/1 * ?}" \
    APIM_STAT_SCRIPT_THROTTLE_1.0.0/APIM_STAT_SCRIPT_THROTTLE.xml

# APIM_USER_AGENT_STATS
xmlstarlet edit --inplace \
    -u "/Analytics/CronExpression" -v \
       "${WSO2_DAS_APIM_USER_AGENT_STATS:-0 0/2 * 1/1 * ?}" \
    APIM_USER_AGENT_STATS_1.0.0/APIM_USER_AGENT_STATS.xml

zip -g $CarPath/org_wso2_carbon_analytics_apim-1.0.0.car \
    APIM_INCREMENTAL_PROCESSING_SCRIPT_1.0.0/APIM_INCREMENTAL_PROCESSING_SCRIPT.xml \
    APIM_LAST_ACCESS_TIME_SCRIPT_1.0.0/APIM_LAST_ACCESS_TIME_SCRIPT.xml \
    APIM_LATENCY_BREAKDOWN_STATS_1.0.0/APIM_LATENCY_BREAKDOWN_STATS.xml \
    APIM_LOGANALYZER_SCRIPT_1.0.0/APIM_LOGANALYZER_SCRIPT.xml \
    APIM_STAT_SCRIPT_1.0.0/APIM_STAT_SCRIPT.xml \
    APIM_STAT_SCRIPT_THROTTLE_1.0.0/APIM_STAT_SCRIPT_THROTTLE.xml \
    APIM_USER_AGENT_STATS_1.0.0/APIM_USER_AGENT_STATS.xml


cp $CarPath/org_wso2_carbon_analytics_apim-1.0.0.car \
   /wso2analytics/repository/components/features/org.wso2.analytics.apim_2.0.0/org_wso2_carbon_analytics_apim-1.0.0.car

rmdir /tempcar