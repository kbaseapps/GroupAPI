
package us.kbase.groupapi;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: LoadReadsGroupOutput</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "data"
})
public class LoadReadsGroupOutput {

    /**
     * <p>Original spec-file type: ReadsGroup</p>
     * 
     * 
     */
    @JsonProperty("data")
    private ReadsGroup data;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    /**
     * <p>Original spec-file type: ReadsGroup</p>
     * 
     * 
     */
    @JsonProperty("data")
    public ReadsGroup getData() {
        return data;
    }

    /**
     * <p>Original spec-file type: ReadsGroup</p>
     * 
     * 
     */
    @JsonProperty("data")
    public void setData(ReadsGroup data) {
        this.data = data;
    }

    public LoadReadsGroupOutput withData(ReadsGroup data) {
        this.data = data;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((("LoadReadsGroupOutput"+" [data=")+ data)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
