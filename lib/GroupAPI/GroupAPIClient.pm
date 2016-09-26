package GroupAPI::GroupAPIClient;

use JSON::RPC::Client;
use POSIX;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
my $get_time = sub { time, 0 };
eval {
    require Time::HiRes;
    $get_time = sub { Time::HiRes::gettimeofday() };
};

use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

GroupAPI::GroupAPIClient

=head1 DESCRIPTION


A KBase module: GroupAPI


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => GroupAPI::GroupAPIClient::RpcClient->new,
	url => $url,
	headers => [],
    };

    chomp($self->{hostname} = `hostname`);
    $self->{hostname} ||= 'unknown-host';

    #
    # Set up for propagating KBRPC_TAG and KBRPC_METADATA environment variables through
    # to invoked services. If these values are not set, we create a new tag
    # and a metadata field with basic information about the invoking script.
    #
    if ($ENV{KBRPC_TAG})
    {
	$self->{kbrpc_tag} = $ENV{KBRPC_TAG};
    }
    else
    {
	my ($t, $us) = &$get_time();
	$us = sprintf("%06d", $us);
	my $ts = strftime("%Y-%m-%dT%H:%M:%S.${us}Z", gmtime $t);
	$self->{kbrpc_tag} = "C:$0:$self->{hostname}:$$:$ts";
    }
    push(@{$self->{headers}}, 'Kbrpc-Tag', $self->{kbrpc_tag});

    if ($ENV{KBRPC_METADATA})
    {
	$self->{kbrpc_metadata} = $ENV{KBRPC_METADATA};
	push(@{$self->{headers}}, 'Kbrpc-Metadata', $self->{kbrpc_metadata});
    }

    if ($ENV{KBRPC_ERROR_DEST})
    {
	$self->{kbrpc_error_dest} = $ENV{KBRPC_ERROR_DEST};
	push(@{$self->{headers}}, 'Kbrpc-Errordest', $self->{kbrpc_error_dest});
    }

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my $token = Bio::KBase::AuthToken->new(@args);
	
	if (!$token->error_message)
	{
	    $self->{token} = $token->token;
	    $self->{client}->{token} = $token->token;
	}
        else
        {
	    #
	    # All methods in this module require authentication. In this case, if we
	    # don't have a token, we can't continue.
	    #
	    die "Authentication failed: " . $token->error_message;
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 load_reads_group

  $return = $obj->load_reads_group($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a GroupAPI.LoadReadsGroupParams
$return is a GroupAPI.LoadReadsGroupOutput
LoadReadsGroupParams is a reference to a hash where the following keys are defined:
	ref has a value which is a string
LoadReadsGroupOutput is a reference to a hash where the following keys are defined:
	data has a value which is a GroupAPI.ReadsGroup
ReadsGroup is a reference to a hash where the following keys are defined:
	description has a value which is a string
	metadata has a value which is a reference to a hash where the key is a string and the value is a string
	items has a value which is a reference to a list where each element is a GroupAPI.ReadsGroupItem
ReadsGroupItem is a reference to a hash where the following keys are defined:
	label has a value which is a string
	ref has a value which is a GroupAPI.ws_reads_id
	metadata has a value which is a reference to a hash where the key is a string and the value is a string
ws_reads_id is a string

</pre>

=end html

=begin text

$params is a GroupAPI.LoadReadsGroupParams
$return is a GroupAPI.LoadReadsGroupOutput
LoadReadsGroupParams is a reference to a hash where the following keys are defined:
	ref has a value which is a string
LoadReadsGroupOutput is a reference to a hash where the following keys are defined:
	data has a value which is a GroupAPI.ReadsGroup
ReadsGroup is a reference to a hash where the following keys are defined:
	description has a value which is a string
	metadata has a value which is a reference to a hash where the key is a string and the value is a string
	items has a value which is a reference to a list where each element is a GroupAPI.ReadsGroupItem
ReadsGroupItem is a reference to a hash where the following keys are defined:
	label has a value which is a string
	ref has a value which is a GroupAPI.ws_reads_id
	metadata has a value which is a reference to a hash where the key is a string and the value is a string
ws_reads_id is a string


=end text

=item Description



=back

=cut

 sub load_reads_group
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function load_reads_group (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to load_reads_group:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'load_reads_group');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "GroupAPI.load_reads_group",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'load_reads_group',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method load_reads_group",
					    status_line => $self->{client}->status_line,
					    method_name => 'load_reads_group',
				       );
    }
}
 


=head2 save_reads_group

  $return = $obj->save_reads_group($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a GroupAPI.SaveReadsGroupParams
$return is a GroupAPI.SaveReadsGroupOutput
SaveReadsGroupParams is a reference to a hash where the following keys are defined:
	workspace_name has a value which is a string
	workspace_id has a value which is an int
	output_object_name has a value which is a string
	output_ref has a value which is a string
	data has a value which is a GroupAPI.ReadsGroup
ReadsGroup is a reference to a hash where the following keys are defined:
	description has a value which is a string
	metadata has a value which is a reference to a hash where the key is a string and the value is a string
	items has a value which is a reference to a list where each element is a GroupAPI.ReadsGroupItem
ReadsGroupItem is a reference to a hash where the following keys are defined:
	label has a value which is a string
	ref has a value which is a GroupAPI.ws_reads_id
	metadata has a value which is a reference to a hash where the key is a string and the value is a string
ws_reads_id is a string
SaveReadsGroupOutput is a reference to a hash where the following keys are defined:
	output_ref has a value which is a string

</pre>

=end html

=begin text

$params is a GroupAPI.SaveReadsGroupParams
$return is a GroupAPI.SaveReadsGroupOutput
SaveReadsGroupParams is a reference to a hash where the following keys are defined:
	workspace_name has a value which is a string
	workspace_id has a value which is an int
	output_object_name has a value which is a string
	output_ref has a value which is a string
	data has a value which is a GroupAPI.ReadsGroup
ReadsGroup is a reference to a hash where the following keys are defined:
	description has a value which is a string
	metadata has a value which is a reference to a hash where the key is a string and the value is a string
	items has a value which is a reference to a list where each element is a GroupAPI.ReadsGroupItem
ReadsGroupItem is a reference to a hash where the following keys are defined:
	label has a value which is a string
	ref has a value which is a GroupAPI.ws_reads_id
	metadata has a value which is a reference to a hash where the key is a string and the value is a string
ws_reads_id is a string
SaveReadsGroupOutput is a reference to a hash where the following keys are defined:
	output_ref has a value which is a string


=end text

=item Description



=back

=cut

 sub save_reads_group
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function save_reads_group (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to save_reads_group:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'save_reads_group');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "GroupAPI.save_reads_group",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'save_reads_group',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method save_reads_group",
					    status_line => $self->{client}->status_line,
					    method_name => 'save_reads_group',
				       );
    }
}
 
  
sub status
{
    my($self, @args) = @_;
    if ((my $n = @args) != 0) {
        Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
                                   "Invalid argument count for function status (received $n, expecting 0)");
    }
    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
        method => "GroupAPI.status",
        params => \@args,
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
                           code => $result->content->{error}->{code},
                           method_name => 'status',
                           data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
                          );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method status",
                        status_line => $self->{client}->status_line,
                        method_name => 'status',
                       );
    }
}
   

sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
        method => "GroupAPI.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'save_reads_group',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method save_reads_group",
            status_line => $self->{client}->status_line,
            method_name => 'save_reads_group',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for GroupAPI::GroupAPIClient\n";
    }
    if ($sMajor == 0) {
        warn "GroupAPI::GroupAPIClient version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 ws_reads_id

=over 4



=item Description

The workspace ID for a Reads data object.
@id ws KBaseFile.SingleEndLibrary KBaseFile.PairedEndLibrary


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 ReadsGroupItem

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
label has a value which is a string
ref has a value which is a GroupAPI.ws_reads_id
metadata has a value which is a reference to a hash where the key is a string and the value is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
label has a value which is a string
ref has a value which is a GroupAPI.ws_reads_id
metadata has a value which is a reference to a hash where the key is a string and the value is a string


=end text

=back



=head2 ReadsGroup

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
description has a value which is a string
metadata has a value which is a reference to a hash where the key is a string and the value is a string
items has a value which is a reference to a list where each element is a GroupAPI.ReadsGroupItem

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
description has a value which is a string
metadata has a value which is a reference to a hash where the key is a string and the value is a string
items has a value which is a reference to a list where each element is a GroupAPI.ReadsGroupItem


=end text

=back



=head2 LoadReadsGroupParams

=over 4



=item Description

ref - workspace reference to ReadsGroup object.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ref has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ref has a value which is a string


=end text

=back



=head2 LoadReadsGroupOutput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
data has a value which is a GroupAPI.ReadsGroup

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
data has a value which is a GroupAPI.ReadsGroup


=end text

=back



=head2 SaveReadsGroupParams

=over 4



=item Description

workspace_name or workspace_id - alternative options defining 
    target workspace,
output_object_name - workspace object name (this parameter is
    used together with one of workspace params from above),
output_ref - optional workspace reference to ReadsGroup object
    (alternative to previous params, this way is preferable when 
    group object already exists and saving operation overrides it).


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
workspace_name has a value which is a string
workspace_id has a value which is an int
output_object_name has a value which is a string
output_ref has a value which is a string
data has a value which is a GroupAPI.ReadsGroup

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
workspace_name has a value which is a string
workspace_id has a value which is an int
output_object_name has a value which is a string
output_ref has a value which is a string
data has a value which is a GroupAPI.ReadsGroup


=end text

=back



=head2 SaveReadsGroupOutput

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
output_ref has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
output_ref has a value which is a string


=end text

=back



=cut

package GroupAPI::GroupAPIClient::RpcClient;
use base 'JSON::RPC::Client';
use POSIX;
use strict;

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $headers, $obj) = @_;
    my $result;


    {
	if ($uri =~ /\?/) {
	    $result = $self->_get($uri);
	}
	else {
	    Carp::croak "not hashref." unless (ref $obj eq 'HASH');
	    $result = $self->_post($uri, $headers, $obj);
	}

    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $headers, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	@$headers,
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
