#Mimoune Djouallah https://datamonkeysite.com/

$query = "evaluate TABLE1"                                                             # export table1 you need to change it to the table you want to export
$template = "C:\Model\template.pbix"                                                   # the Path your pbix file. 
$filename = “TABLE1.csv”                                                               # The Name of the export file
$PBIDesktop = "C:\Program Files\Microsoft Power BI Desktop\bin\PBIDesktop.exe"         # The Path to PowerBI Desktop executable. 
$waitoPBD  = 10                                                                        # the Time Needed in Seconds for PowerBI Desktop to launch and open the pbix file, 10 second by default, you may increase it for big file

START-PROCESS $PBIDesktop $template | Out-Null
Start-Sleep -s $waitoPBD


# get the server name and the port name of PowerBI desktop SSAS , thanks for Imke http://www.thebiccountant.com/2016/04/09/hackpowerbi/#more-1147

$pathtofile = (Get-ChildItem -Path c:\users -Filter msmdsrv.port.txt -Recurse -ErrorAction SilentlyContinue -Force).FullName
$port = gc $pathtofile
$port = $port -replace '\D',''
$dataSource = "localhost:$port"
$pathtoDataBase_Name = $pathtofile -replace 'msmdsrv.port.txt',''
$Database_Name = Get-ChildItem -Path $pathtoDataBase_Name -Filter *.db.xml -Recurse -ErrorAction SilentlyContinue -Force
$Database_Name = $Database_Name.ToString().Split(".") | select -First 1


#  Connect using AMO thanks for stackexchange :)


[System.Reflection.Assembly]::LoadFile("C:\Program Files (x86)\Microsoft SQL Server\130\SDK\Assemblies\Microsoft.AnalysisServices.tabular.DLL")
 ("Microsoft.AnalysisServices") >$NULL
$server = New-Object Microsoft.AnalysisServices.tabular.Server

$server.connect($dataSource)
$database = $server.Databases.Item($Database_Name)


# thanks for Marco russo http://www.sqlbi.com/articles/using-process-add-in-tabular-models/

$model = $database.Model
$model.RequestRefresh("Full")
$model.SaveChanges()


$server.disconnect($dataSource)


# Connect using ADOMD.NET

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.AnalysisServices.AdomdClient")   
 
# Create the first connection object  
$con = new-object Microsoft.AnalysisServices.AdomdClient.AdomdConnection 
$con.ConnectionString = "Datasource=$dataSource; Initial Catalog=$Database_Name;timeout=0; connect timeout =0" 
$con.Open() 

 
# Create a command and send a query to get the data, the dax/mdx query is defined at the top  
$command = $con.CreateCommand()
$command.CommandText = $query
#$Reader = $Comand.ExecutedataReader()
 
$adapter = New-Object -TypeName Microsoft.AnalysisServices.AdomdClient.AdomdDataAdapter $command
$dataset = New-Object -TypeName System.Data.DataSet
$adapter.Fill($dataset)

$dataset.Tables[0] | export-csv $filename -notypeinformation
   
"Datasource= " +$dataSource
"Database_Name= " +$Database_Name
 

$con.Close() 
