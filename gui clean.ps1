
# Get-filmstats function, provide film stats such as title, votes and imdbrating 

function Get-FilmStats($filmname,$year,$key,$sqlserver,$sqldatabase,$Tablename) {

if ($filmname -contains '* *') {
$filmname -replace "* *", "+"

 }

else {

    $request = "http://www.omdbapi.com/?apikey=" + $key + "&t=" + $filmname +"&y=" + $year +""

    $info = Invoke-RestMethod -Uri $request
    $info | select "Title","imdbVotes","imdbRating","Awards","Runtime","Director","Plot"


    }
}


#Creating Window

Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='GUI for my PoSh script'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true

#Key Label
$KeyLabel = New-Object System.Windows.Forms.Label

$KeyLabel.Text = "API Key"

$KeyLabel.Location  = New-Object System.Drawing.Point(0,70)

$KeyLabel.AutoSize = $true

$main_form.Controls.Add($KeyLabel)

#Film Label
$Label = New-Object System.Windows.Forms.Label

$Label.Text = "Film"

$Label.Location  = New-Object System.Drawing.Point(0,10)

$Label.AutoSize = $true

$main_form.Controls.Add($Label)

#Date Label
$DateLabel = New-Object System.Windows.Forms.Label

$DateLabel.Text = "Year"

$DateLabel.Location  = New-Object System.Drawing.Point(0,40)

$DateLabel.AutoSize = $true

$main_form.Controls.Add($DateLabel)

#Output Label
$OutputLabel = New-Object System.Windows.Forms.Label

$OutputLabel.Text = "Output"

$OutputLabel.Location  = New-Object System.Drawing.Point(0,120)

$OutputLabel.AutoSize = $true

$main_form.Controls.Add($OutputLabel)

#TextBox Title
$TextBox = New-Object System.Windows.Forms.TextBox

$TextBox.Width = 300

$TextBox.Location  = New-Object System.Drawing.Point(60,10)

$main_form.Controls.Add($TextBox)

#TextBox year
$YearTextBox = New-Object System.Windows.Forms.TextBox

$YearTextBox.Width = 200

$YearTextBox.Location  = New-Object System.Drawing.Point(60,40)

$main_form.Controls.Add($YearTextBox)

#TextBox Key

$KeyTextBox = New-Object System.Windows.Forms.TextBox

$KeyTextBox.Width = 200


$KeyTextBox.Location  = New-Object System.Drawing.Point(60,70)

$main_form.Controls.Add($KeyTextBox)

#Output Text Box

$OutputText = New-Object System.Windows.Forms.TextBox

$OutputText.Multiline = "True"

$OutputText.Width = 500

$OutputText.Height = 200

$OutputText.Location  = New-Object System.Drawing.Point(60,120)

$main_form.Controls.Add($OutputText)

#Button

$Button = New-Object System.Windows.Forms.Button

$Button.Location = New-Object System.Drawing.Size(400,10)

$Button.Size = New-Object System.Drawing.Size(120,23)

$Button.Text = "Get Movie Stats"

$main_form.Controls.Add($Button)

#Button Click Action

$Button.Add_Click(

{

$OutputText.Text = (Get-FilmStats -key $KeyTextBox.Text -filmname $TextBox.Text -year $YearTextBox.Text)

}

)



$main_form.ShowDialog()

