#!/usr/bin/perl
use threads;
use DBI;

my $driver   = "SQLite";
my $database = "/opt/jenkins/scripts/test.db";
#my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
#my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 })
#                      or die $DBI::errstr;

my $repo_url = @ARGV[0];
my $user = @ARGV[1];


#open file to read
open (INPUT, '/opt/jenkins/scripts/modules.txt') or die "Could not open file ";
#read file
my @modules=();
while (<INPUT>){
     my($line) = $_;
     chomp($line);
     push(@modules , $line);
}
     close(INPUT);
     `mkdir hios`;
     #`cp clone-module.sh hios/`;
     chdir "hios";
#loop through each module
my @thr;
foreach $module (@modules){
     system("mkdir", "-p", $module);
     push @thr, threads->create( 'poll' , $module);
}
foreach (@thr){
    $_->join();
}
#$thr->join();
sub poll {
     $module = $_[0];
     print "starting for $module \n";
     #system("mkdir", "-p",  $module);
     #chdir "$module"; 
     #get branches
     system( "python", "/opt/jenkins/scripts/parser.py", $module);    
     
     #now read in from /opt/jenkins/branches/$module-branches.txt and assign them
     $branchesFile = "/opt/jenkins/branches/$module-branches.txt";
     if (-e $branchesFile){
     }else{
          print "WARNING: NO CI BRANCHES FOR MODULE: $module";
     }
     #read branches
     open (BRANCHES, "/opt/jenkins/branches/$module-branches.txt") or die "Could not open branches file!";
     @branches=();
     while (<BRANCHES>){
          my($line) = $_;
          #print "\n \n \n $line \n \n \n";
          chomp($line);
	  push @branches, $line;
     }
     close (BRANCHES);
     
     #print branches
     foreach $branch (@branches){
          print "cloning for $branch in module $module";
          system( "sh", "/opt/jenkins/scripts/clone-module.sh", $repo_url , $module, $branch);
     }


#     system( "sh", "/opt/jenkins/scripts/clone-module.sh", $repo_url , $module, $branch);
     #cd into module directory
     #chdir "$module";

     #get all ci branches
     #@branches = `git branch -a | grep "remotes/HIOS-*"`;

     #check if the modules has a hash file
     $hashFile = "/opt/jenkins/hashes/hash-$module.txt";
     if (-e $hashFile) {
     }else{
          print "WARNING: It does not exist";
          system("touch", $hashFile);
     }

     #read current hashes
     open (HASHES, "/opt/jenkins/hashes/hash-$module.txt") or die "Could not open hash.txt";
     %currentHashes=();
     while (<HASHES>){
          my($line) = $_;
          chomp($line);
          @values = split(',', $line);
          $currentHashes{"$values[0]"} = "$values[1]";
     }
     close (HASHES);

     #print hashes
     open (OUTPUT, ">/opt/jenkins/hashes/hash-$module.txt") or die "Could not write to hash.txt";
     %newHashes=();
     foreach $branch (@branches){
          chomp($branch);
          $commit = `sh /opt/jenkins/scripts/get-commit.sh $module $branch 2>&1`;
          chomp($commit);
          $newHashes{"$branch"} = "$commit";
          print OUTPUT "$branch,$commit\n";
     }
     close (OUTPUT);

     #compare hashes
     foreach $key (keys %newHashes){
          if($newHashes{$key} eq $currentHashes{$key}){
                print "the hashes are the same for branch:$key in module: $module\n";
          }else{
                print "the hashes are different for branch:$key in module: $module\n";
                #remove spaces
                $key =~ s/^[ ]*//g;
                #remove remotes/origin
                $key =~ s/remotes\/*//g;
                #call jenkins job through rest api
		my $dsn = "DBI:$driver:dbname=$database";
		my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 })
                      or die $DBI::errstr;
		my $stmt = qq(CREATE TABLE IF NOT EXISTS "$key"
		      (MODULE           TEXT    NOT NULL););
		my $rv = $dbh->do($stmt);
		if($rv < 0){
		   print $DBI::errstr;
		} else {
		   print "Table created successfully\n";
		}
		my $stmt = qq(INSERT INTO "$key" (MODULE)
      		   VALUES ("$module" ));
		my $rv = $dbh->do($stmt) or die $DBI::errstr;
                
                print "A jenkins job for $key would be triggered in module $module \n";
#                `curl -X POST \"10.200.1.16:8080/jenkins/job/BUILD_HIOS/buildWithParameters?token=token123&BRANCH=$key\"`
          }
     }
     close (OUTPUT);
}
