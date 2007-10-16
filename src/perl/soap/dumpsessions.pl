#!/usr/bin/perl -w 
# 
# ***** BEGIN LICENSE BLOCK *****
# Zimbra Collaboration Suite Server
# Copyright (C) 2006 Zimbra, Inc.
# 
# The contents of this file are subject to the Yahoo! Public License
# Version 1.0 ("License"); you may not use this file except in
# compliance with the License.  You may obtain a copy of the License at
# http://www.zimbra.com/license.
# 
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
# ***** END LICENSE BLOCK *****
# 

#
# Simple SOAP test-harness for the AddMsg API
#

use strict;
use lib '.';

use LWP::UserAgent;
use Getopt::Long;
use XmlElement;
use XmlDoc;
use Soap;
use ZimbraSoapTest;

#standard options
my ($user, $pw, $host, $help); #standard
GetOptions("u|user=s" => \$user,
           "p|port=s" => \$pw,
           "h|host=s" => \$host,
           "help|?" => \$help);

if (!defined($user)) {
    die "USAGE: $0 -u USER [-p PASSWD] [-h HOST]";
}

my $z = ZimbraSoapTest->new($user, $host, $pw);
$z->doAdminAuth();

my $d = new XmlDoc;
$d->add('DumpSessionsRequest', $Soap::ZIMBRA_ADMIN_NS);

my $response = $z->invokeAdmin($d->root());
print "REQUEST:\n-------------\n".$z->to_string_simple($d);
print "RESPONSE:\n--------------\n".$z->to_string_simple($response);

