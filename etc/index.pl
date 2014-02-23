#!/usr/bin/env perl

use IO::All;

my $links = "";
my $styles = "";
my $samples = "";

my $title = 0;
my $txt < io("etc/manifest.txt");
foreach my $line (split(/\n/, $txt)) {
    my ($css) = ($line =~ m/^(.+?)\.(?:otf|ttf).*/);
    $css =~ s/^(.*)\/(.*)/web\/TypoPRO-$1\/TypoPRO-$2.css/s;
    my $txt < io($css);
    my $html = $css;
    $html =~ s/\.css/.html/s;

    my ($font_family)  = ($txt =~ m/font-family:\s+'([^']+)'/s);
    my ($font_style)   = ($txt =~ m/font-style:\s+(.+?);/s);
    my ($font_weight)  = ($txt =~ m/font-weight:\s+(.+?);/s);
    my ($font_stretch) = ($txt =~ m/font-stretch:\s+(.+?);/s);
    my ($font_variant) = ($txt =~ m/font-variant:\s+(.+?);/s);

    my $id = "$font_family-$font_style-$font_weight-$font_stretch-$font_variant";
    $id =~ s/[\s.]+/-/g;

    $links .= "<link href=\"$css\" rel=\"stylesheet\" type=\"text/css\"/>\n";
    $styles .=
        ".$id {\n" .
        "    font-family:  '$font_family';\n" .
        "    font-style:   $font_style;\n" .
        "    font-weight:  $font_weight;\n" .
        "    font-stretch: $font_stretch;\n" .
        "    font-variant: $font_variant;\n" .
        "}\n";
    if ($title == 0) {
        $samples .= "<div class=\"group\">General Purpose</div>\n";
        $title = 1;
    }
    elsif ($title == 1 && $font_family =~ m/Ostrich/) {
        $samples .= "<div class=\"group\">Special Purpose</div>\n";
        $title = 2;
    }
    $samples .=
       "<div class=\"sample\">\n" .
       "    <a href=\"$html\">\n" .
       "    <div class=\"info\">\n" .
       "        <span class=\"family\">$font_family</span>&nbsp;&nbsp;\n" .
       "        <span class=\"param\">$font_style-$font_weight-$font_stretch-$font_variant</span>\n" .
       "    </div>\n" .
       "    <div class=\"text $id\">\n" .
       "        Penultimate: The Quick Brown Fox Jumps Over The Lazy Dog\n" .
       "    </div>\n" .
       "    </a>\n" .
       "</div>\n";
}
$links   =~ s/^/        /mg;
$styles  =~ s/^/            /mg;
$samples =~ s/^/        /mg;

my $html =
   "<!DOCTYPE html>\n" .
   "<html>\n" .
   "    <head>\n" .
   "        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/>\n" .
   $links .
   "        <style type=\"text/css\">\n" .
   "            html { background-color: #dcdcdc; }\n" .
   "            body { background-color: #ffffff; width: 865px; font-size: 14pt; margin: auto; margin-top: 0px; font-family: sans-serif; margin-bottom: 40px; }\n" .
   "            .title { background-color: #000000; color: #ffffff; width: 100%; font-size: 20pt; font-weight: bold; padding: 20px; -moz-box-sizing: border-box; box-sizing: border-box; }\n" .
   "            .group { background-color: #666666; color: #ffffff; width: 100%; font-size: 20pt; font-weight: bold; padding: 20px; -moz-box-sizing: border-box; box-sizing: border-box; margin: 10px 0px 10px 0px; }\n" .
   "            .sample { border-top: 1px solid #cccccc; margin-top: 8px; padding: 8px 0px 0px 20px; }\n" .
   "            .sample a { text-decoration: none; }\n" .
   "            .sample .family { font-size: 10pt; color: #000000; }\n" .
   "            .sample .param  { font-size: 9pt; color: #666666; }\n" .
   "            .sample .text { font-size: 16pt; color: #000000; }\n" .
   $styles .
   "        </style>\n" .
   "        <title>TypoPRO Font Overview</title>\n" .
   "    </head>\n" .
   "    <body>\n" .
   "        <div class=\"title\">TypoPRO Font Overview</div>\n" .
   $samples .
   "    </body>\n" .
   "</html>\n";

$html > io("index.html");

