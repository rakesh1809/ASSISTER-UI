#!/usr/bin/perl

use DBI;

my $driver   = "SQLite"; 
my $database = "test.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
                      or die $DBI::errstr;

print "Opened database successfully\n";
my $branch = "coveros";
my $module = "hios-ffm-avc";

my $stmt = qq(CREATE TABLE IF NOT EXISTS "$branch"
      (MODULE           TEXT    NOT NULL););
my $rv = $dbh->do($stmt);
if($rv < 0){
   print $DBI::errstr;
} else {
   print "Table created successfully\n";
}

my $stmt = qq(INSERT INTO "$branch" (MODULE)
      VALUES ("$module" ));
my $rv = $dbh->do($stmt) or die $DBI::errstr;

$dbh->disconnect();
