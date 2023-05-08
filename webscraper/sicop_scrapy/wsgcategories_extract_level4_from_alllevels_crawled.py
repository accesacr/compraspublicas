import pandas as pd
import pandasql as ps

var_crawled_root = 'sicop_project/sicop_project/crawled_data'
var_crawled_filename = 'wgscategories_alllevels_2023_test_v5.csv'
var_cleaned_filename = 'wgscategories_level4_onlyid_noheader_test_v5.csv'
df_cat = pd.read_csv(var_crawled_root + '/' + var_crawled_filename)

query_001 = """
	SELECT 
		category_id
	FROM df_cat 
	WHERE 1 = 1
	AND LENGTH(CAST(category_id AS VARCHAR(255))) = 8
	--AND CAST(category_id AS VARCHAR(255)) LIKE '%01' -- test when debugging
"""

ps.sqldf(query_001).to_csv(var_crawled_root + '/' + var_cleaned_filename, header=False, index=False, encoding='utf-16')

#print(df_cat.head(10))
#print(ps.sqldf(query_001))





# THIS SCRIPT HAS RAN AT LEAST TWICE, ONE PER PARAMETER GROUP BELOW

#Group 1
#var_crawled_filename = 'wgscategories_alllevels_2023_test_v5.csv'
#var_cleaned_filename = 'wgscategories_level4_onlyid_noheader_test_v5.csv'

#Group 2
#var_crawled_filename = 'wgscategories_alllevels.csv'
#var_cleaned_filename = 'wgscategories_level4_onlyid_noheader_test_v5_withOriginalCategoriesSourceFile.csv'