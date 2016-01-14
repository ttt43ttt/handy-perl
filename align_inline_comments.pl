#!/usr/bin/perl
#
# Align the inline comments.
# For example,
#	 int a = 3; // some words
#	 int b = 4;     // other words
# will be formated to
#	 int a = 3;     // some words
#	 int b = 4;     // other words
#
# perl align_inline_comments.pl filepath 120
#

my $filepath = shift;
my $comment_padding = shift || 80;

open(my $file, $filepath)
		or die "Can not open file $filepath: $!";

my $line;
while ($line = <$file>) {
	chomp $line;

	if ($line =~ /^\s*\/\/.*$/) {
		# comment
		print "$line\n";
	} elsif ($line =~ /^([^\/]+)(\/\/.*)$/) {
        # inline comment
		my $code = trim_end($1);
		my $comment = trim_end($2);
		my $spaces = " " x ($comment_padding - length($code));
        print "$code$spaces$comment\n";
    } else {
		# others
		print "$line\n";
	}
}

close $file;

sub trim_end {
	my ($s) = @_;
    $s =~ s/\s+$//;
    return $s;
}