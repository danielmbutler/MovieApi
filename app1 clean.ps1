$key = ""
$request = "http://www.omdbapi.com/?apikey=" + $key + "&t=star+wars&y=1977"
$info = Invoke-RestMethod -Uri $request


# Get-filmstats function, provide film stats such as title, votes and imdbrating 

function Get-FilmStats($filmname,$year,$key,$sqlserver,$sqldatabase,$Tablename) {


if ($filmname -contains '* *') {
$filmname -replace "* *", "+"

 }

else {

    $request = "http://www.omdbapi.com/?apikey=" + $key + "&t=" + $filmname +"&y=" + $year +""

    $info = Invoke-RestMethod -Uri $request
    $info | select "Title","imdbVotes","imdbRating"

    #send data to sql server 

        $conn=new-object System.Data.SqlClient.SQLConnection

        $ConnectionString = "Server=" + $sqlserver + ";Database=" + $sqldatabase + ";Integrated Security=True;Connect Timeout=5"

        $conn.ConnectionString=$ConnectionString

        $conn.Open()

        $commandText = "insert $Tablename Values('" + $filmname + "','" + $year + "','" + $info.imdbVotes + "','" + $info.imdbRating + "')"

        $command = $conn.CreateCommand()

        $command.CommandText = $commandText

        $command.ExecuteNonQuery()

 

        $conn.Close()


    }
}

#using Get-filmstats in for each loop

#creating filmobjects

$starwarsIv = [PSCustomObject]@{
Year = "1977"
Title = "Star Wars"
}

$starwarsV = [PSCustomObject]@{
Year = "1980"
Title = "Star Wars"
}

$starwarsVI = [PSCustomObject]@{
Year = "1983"
Title = "Star Wars"
}

$films = $starwarsIv,$starwarsV,$starwarsVI

foreach($film in $films) {

Get-FilmStats -key $key -filmname $film.Title -year $film.Year

}


#Post film stats to sql database

$servername = 


$films = $starwarsIv,$starwarsV,$starwarsVI

foreach($film in $films) {

Get-FilmStats -key $key -filmname $film.Title -year $film.Year -sqlserver  -sqldatabase FilmData -Tablename StarWars

}


