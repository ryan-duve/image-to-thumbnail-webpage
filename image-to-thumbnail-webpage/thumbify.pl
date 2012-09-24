#!/usr/bin/perl
#duve-make-thumbnail-webpage.pl

#Executing this script in a directory sniffs out all the .jpg files in a directory and uses ImageMagick to create thumbnails of them.  It then makes a very basic html file, thumbnails.html, with all the thumbnails linking to their fullsized counterparts.

if(-e 'thumbnails.html'){
	print "thumbnails.html already exists!!\n";
	die();
}

#delete all existing duve thumbnails
`rm *.duve.th`;

#stash list of images from current directory
@images=`ls *.jpg`;

#create image.jpg.duve.th from each image.jpg
foreach $i (@images){
	 chomp $i;
	`convert $i -resize 150x150 $i.duve.th`;
}

#store HTML in default variable
$_.="<html>
 <head>
  <!-- style gives thumbnails some flare -->
  <style type=\"text/css\">
   img{
	border-style:solid;
	border-color:blue;
   }
   a:link img{
	filter:none;
   }
   a:hover img{
	border-color:red;
   }
  </style>
 </head>
 <body>
";

#create links to all images, store in default variable
foreach $i (@images){
	chomp $i;
	$_.="<a href=\"$i\"><img src=\"$i.duve.th\" title=\"$i\" /></a>\n";
}

#ending HTML
$_.=" </body>
</html>";

#write default variable to thumbnails.html
open(HTML,'>>thumbnails.html');
print HTML;
close(HTML);
