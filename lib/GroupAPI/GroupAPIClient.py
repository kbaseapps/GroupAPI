# -*- coding: utf-8 -*-
############################################################
#
# Autogenerated by the KBase type compiler -
# any changes made here will be overwritten
#
############################################################

from __future__ import print_function
# the following is a hack to get the baseclient to import whether we're in a
# package or not. This makes pep8 unhappy hence the annotations.
try:
    # baseclient and this client are in a package
    from .baseclient import BaseClient as _BaseClient  # @UnusedImport
except:
    # no they aren't
    from baseclient import BaseClient as _BaseClient  # @Reimport


class GroupAPI(object):

    def __init__(
            self, url=None, timeout=30 * 60, user_id=None,
            password=None, token=None, ignore_authrc=False,
            trust_all_ssl_certificates=False,
            auth_svc='https://kbase.us/services/authorization/Sessions/Login'):
        if url is None:
            raise ValueError('A url is required')
        self._service_ver = None
        self._client = _BaseClient(
            url, timeout=timeout, user_id=user_id, password=password,
            token=token, ignore_authrc=ignore_authrc,
            trust_all_ssl_certificates=trust_all_ssl_certificates,
            auth_svc=auth_svc)

    def load_reads_group(self, params, context=None):
        """
        :param params: instance of type "LoadReadsGroupParams" (ref -
           workspace reference to ReadsGroup object.) -> structure: parameter
           "ref" of String
        :returns: instance of type "LoadReadsGroupOutput" -> structure:
           parameter "data" of type "ReadsGroup" -> structure: parameter
           "description" of String, parameter "metadata" of mapping from
           String to String, parameter "items" of list of type
           "ReadsGroupItem" -> structure: parameter "label" of String,
           parameter "ref" of type "ws_reads_id" (The workspace ID for a
           Reads data object. @id ws KBaseFile.SingleEndLibrary
           KBaseFile.PairedEndLibrary), parameter "metadata" of mapping from
           String to String
        """
        return self._client.call_method(
            'GroupAPI.load_reads_group',
            [params], self._service_ver, context)

    def save_reads_group(self, params, context=None):
        """
        :param params: instance of type "SaveReadsGroupParams"
           (workspace_name or workspace_id - alternative options defining
           target workspace, output_object_name - workspace object name (this
           parameter is used together with one of workspace params from
           above), output_ref - optional workspace reference to ReadsGroup
           object (alternative to previous params, this way is preferable
           when group object already exists and saving operation overrides
           it).) -> structure: parameter "workspace_name" of String,
           parameter "workspace_id" of Long, parameter "output_object_name"
           of String, parameter "output_ref" of String, parameter "data" of
           type "ReadsGroup" -> structure: parameter "description" of String,
           parameter "metadata" of mapping from String to String, parameter
           "items" of list of type "ReadsGroupItem" -> structure: parameter
           "label" of String, parameter "ref" of type "ws_reads_id" (The
           workspace ID for a Reads data object. @id ws
           KBaseFile.SingleEndLibrary KBaseFile.PairedEndLibrary), parameter
           "metadata" of mapping from String to String
        :returns: instance of type "SaveReadsGroupOutput" -> structure:
           parameter "output_ref" of String
        """
        return self._client.call_method(
            'GroupAPI.save_reads_group',
            [params], self._service_ver, context)

    def status(self, context=None):
        return self._client.call_method('GroupAPI.status',
                                        [], self._service_ver, context)
