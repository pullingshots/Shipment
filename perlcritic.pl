use File::Find::Rule;

system "perlcritic --profile=perlcriticrc " . $_
    for File::Find::Rule->file->name("*.pm")->in("./lib/");