/*
A KBase module: GroupAPI
*/

module GroupAPI {

    /*
        The workspace ID for a Reads data object.
        @id ws KBaseFile.SingleEndLibrary KBaseFile.PairedEndLibrary
    */
    typedef string ws_reads_id;

    typedef structure {
        string label;
        ws_reads_id ref;
        mapping<string, string> metadata;
    } ReadsGroupItem;

    typedef structure {
        string description;
        mapping<string, string> metadata;
        list<ReadsGroupItem> items;
    } ReadsGroup;


    /*
        ref - workspace reference to ReadsGroup object.
    */
    typedef structure {
        string ref;
    } LoadReadsGroupParams;

    typedef structure {
        ReadsGroup data;
    } LoadReadsGroupOutput;

    funcdef load_reads_group(LoadReadsGroupParams params)
        returns (LoadReadsGroupOutput) authentication required;


    /*
        workspace_name or workspace_id - alternative options defining 
            target workspace,
        output_object_name - workspace object name (this parameter is
            used together with one of workspace params from above),
        output_ref - optional workspace reference to ReadsGroup object
            (alternative to previous params, this way is preferable when 
            group object already exists and saving operation overrides it).
    */
    typedef structure {
        string workspace_name;
        int workspace_id;
        string output_object_name;
        string output_ref;
        ReadsGroup data;
    } SaveReadsGroupParams;

    typedef structure {
        string output_ref;
    } SaveReadsGroupOutput;

    funcdef save_reads_group(SaveReadsGroupParams params)
        returns (SaveReadsGroupOutput) authentication required;

};
