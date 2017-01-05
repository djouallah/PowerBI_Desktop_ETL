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

although the local SSAS is refreshed with the latest data, the changes are not saved in the PBIX file (which is zipped *.abf plus metadata and reports), and the reports show the old data, which give the impression that the refresh did not work, if you want to save the changes, you need to click save on the PowerBI Desktop  
I don't know how to trigger PowerBI desktop to refresh the view of the data in SSAS refreshed by external means  
Please there is no guaranty whatever, always make a copy of your pbix before doing anything  
