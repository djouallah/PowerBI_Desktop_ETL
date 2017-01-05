# PowerBI_Desktop_ETL
This script Open a pbix file  
refresh the Model  
Export to CSV  
obviousely you can use the task scheduler to automate this script
you need to write the parameter specific to your case, specially the query, and the pbix file


$query = "evaluate TABLE1"  
   you need to change it to the table you want to export  
$template = "C:\Model\template.pbix"     
the Path your pbix file.   
$filename = “TABLE1.csv”    
The Name of the export file  
$PBIDesktop = "C:\Program Files\Microsoft Power BI Desktop\bin\PBIDesktop.exe"    
The Path to PowerBI Desktop executable.   
$waitoPBD  = 10                                                                            
The Time Needed in Seconds for PowerBI Desktop to                                                                                           launch and open the pbix file, 10 second by                                                                                                 default, you may increase it for big file  

