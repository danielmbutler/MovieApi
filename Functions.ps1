
$request = "http://www.omdbapi.com/?apikey=" + $key + "&t=star+wars&y=1977"
$info = Invoke-RestMethod -Uri $request


# Get-filmstats function, provide film stats such as title, votes and imdbrating 

function Get-FilmStats($filmname,$year,$key){


if ($filmname -contains '* *') {
$filmname -replace "* *", "+"

 }

else {

    $request = "http://www.omdbapi.com/?apikey=" + $key + "&t=" + $filmname +"&y=" + $year +""

    $info = Invoke-RestMethod -Uri $request
    $info | select "Title","imdbVotes","imdbRating"

    
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

