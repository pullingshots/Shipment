use File::Find::Rule;

my $ver = $ARGV[0] ? "./$ARGV[0]" : ".";

print  "... cleaning up $ver";

system "perltidy --pro=perltidyrc " . $_
    for File::Find::Rule->file->name("*.pm")->in("$ver/lib/");

if ($ver ne '.') {
    system "rm $ver.tar.gz";
    system "tar -czf $ver.tar.gz $ver/*";
}