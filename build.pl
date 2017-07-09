#!/usr/bin/perl
#
# Code Generator for XCTestManifests.swift and LinuxMain.swift
# Author: Alex Ramey
# Date: July 9, 2017
#
## Use:
# Run 'perl build.pl' to auto-generate XCTestManifests.swift and LinuxMain.swift
# from the contents of the 'ArrayUtilsTests' directory
#
## Assumptions:
# 0. Tests are in files ending in 'Tests.swift' in the 'ArrayUtilsTests' directory
# 1. There is only one test class (inheriting from XCTestCase) per file
# 2. test functions begin with the word 'test'
#
## Sample Output:
#
### XCTestManifests.swift
#
# extension RadixSortTests {
#     static var allTests = [
#         ("testWellFormedInput", testWellFormedInput),
#         ("testMaxValueZero", testMaxValueZero),
#         ("testNegativeNumbers", testNegativeNumbers),
#         ("testEmptyInput", testEmptyInput),
#     ]
# }
#
### LinuxMain.swift
#
# import XCTest
# @testable import ArrayUtilsTestSuite

# XCTMain([
#     testCase(RadixSortTests.allTests),
# ])
#

use strict;
use warnings;

my @lines = (); # will hold file contents in RAM for processing

my @manifest = (); # will store the eventual contents of XCTestManifests.swift

my @linux = (); # will store the eventual contents of LinuxMain.swift
push @linux, 'import XCTest';
push @linux, '@testable import ArrayUtilsTestSuite';
push @linux, "\nXCTMain([";

# Open Test directory
my $dirname = './Tests/ArrayUtilsTests/';
opendir(DIR, $dirname) or die "Can't open directory $dirname: $!";

# Read filenames from the test directory
my @files = readdir(DIR);
foreach my $file (@files) {
  
  # This line skips files whose name doesn't end in 'Tests.swift'
  next if ($file !~ /\BTests.swift\b/);

  # Set the Input Record Seperator to 'undef' so we can read entire file at once
  local $/ = undef;
  open(FILE, $dirname.$file) or die "Can't open $file: $!";
  my $content = <FILE>;
  close(FILE);

  # Get the className from the file by matching something like:
  # class className : XCTestCase
  next if ($content !~ m/\bclass\s+(\S+)\s+:\s+XCTestCase/);
  my $className = $1;   # first matched variable due to back reference (\S+) is stored in $1

  push @linux, "    testCase($className.allTests),";

  push @manifest, "extension $className {";
  push @manifest, "    static var allTests = [";

  # Loop through every function in the file, matching things like:
  # func testFuncName()
  while ($content =~ m/\bfunc\s+(\S+)\s+/) {
    my $funcName = $1;
    $content = $'; # Special variable $' stores the POSTMATCH part of the string
    next if $funcName !~ m/\btest\B/; # function name must start with 'test'
    $funcName =~ s/[()]//g; # trim off '(' and ')' if they are part of the matched name
    push @manifest, "        (\"$funcName\", $funcName),";
  }

  push @manifest, "    ]";
  push @manifest, "}\n";
}

push @linux, "])";

# Write XCTestManifests.swift from @manifest
open(FILE, ">".$dirname."XCTestManifests.swift");
foreach my $line (@manifest) {
    print FILE $line."\n";
}
close(FILE);

# Write LinuxMain.swift from @manifest
open(FILE, ">".$dirname."../LinuxMain.swift");
foreach my $line (@linux) {
    print FILE $line."\n";
}
close(FILE);