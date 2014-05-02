#!/usr/bin/env perl

use IO::All;
my $fonts = {};
my $json = "TypoPRO_Manifest = [\n";
my $txt < io("etc/manifest.txt");
foreach my $line (split(/\n/, $txt)) {
    my ($css) = ($line =~ m/^(.+?)\.(?:otf|ttf).*/);
    $css =~ s/^(.*)\/(.*)/web\/TypoPRO-$1\/TypoPRO-$2.css/s;
    my $txt < io($css);
    my ($font_name)    = ($txt =~ m/\/\*\s+(.+?)\s+\*\//s);
    my ($font_family)  = ($txt =~ m/font-family:\s+'([^']+)'/s);
    my ($font_style)   = ($txt =~ m/font-style:\s+(.+?);/s);
    my ($font_weight)  = ($txt =~ m/font-weight:\s+(.+?);/s);
    my ($font_stretch) = ($txt =~ m/font-stretch:\s+(.+?);/s);
    my ($font_variant) = ($txt =~ m/font-variant:\s+(.+?);/s);
    $json .= "    { " .
        "\"name\": \"$font_name\", " .
        "\"family\": \"$font_family\", " .
        "\"style\": \"$font_style\", " .
        "\"weight\": \"$font_weight\", " .
        "\"stretch\": \"$font_stretch\", " .
        "\"variant\": \"$font_variant\", " .
        "\"css\": \"$css\" " .
    "},\n";
}
$json =~ s/,\n$/\n/s;
$json .= "];\n";
$json > io("etc/manifest.js");

