# -*- coding: utf-8 -*-
#BEGIN_HEADER
#END_HEADER


class GroupAPI:
    '''
    Module Name:
    GroupAPI

    Module Description:
    A KBase module: GroupAPI
    '''

    ######## WARNING FOR GEVENT USERS #######
    # Since asynchronous IO can lead to methods - even the same method -
    # interrupting each other, you must be *very* careful when using global
    # state. A method could easily clobber the state set by another while
    # the latter method is running.
    #########################################
    VERSION = "0.0.1"
    GIT_URL = ""
    GIT_COMMIT_HASH = ""
    
    #BEGIN_CLASS_HEADER
    #END_CLASS_HEADER

    # config contains contents of config file in a hash or None if it couldn't
    # be found
    def __init__(self, config):
        #BEGIN_CONSTRUCTOR
        #END_CONSTRUCTOR
        pass
    

    def load_reads_group(self, ctx, params):
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
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN load_reads_group
        raise ValueError("Method is not implemented yet")
        #END load_reads_group

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method load_reads_group return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def save_reads_group(self, ctx, params):
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
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN save_reads_group
        raise ValueError("Method is not implemented yet")
        #END save_reads_group

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method save_reads_group return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def status(self, ctx):
        #BEGIN_STATUS
        returnVal = {'state': "OK", 'message': "", 'version': self.VERSION, 
                     'git_url': self.GIT_URL, 'git_commit_hash': self.GIT_COMMIT_HASH}
        #END_STATUS
        return [returnVal]
