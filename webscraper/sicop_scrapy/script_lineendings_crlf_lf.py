# replacement strings
WINDOWS_LINE_ENDING = b'\r\n'
UNIX_LINE_ENDING = b'\n'

# relative or absolute file path, e.g.:
file_path = r"C:\Users\Lidier Campos\Documents\CodeRepositories\ComprasPublicas\compraspublicas/webscraper/sicop_scrapy/sicop_project/sicop_project/other_data/all_procedures_onlyid_noheaders.csv"

with open(file_path, 'rb') as open_file:
    content = open_file.read()
    
content = content.replace(WINDOWS_LINE_ENDING, UNIX_LINE_ENDING)

with open(file_path, 'wb') as open_file:
    open_file.write(content)