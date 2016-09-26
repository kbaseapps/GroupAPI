
package us.kbase.groupapi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: ReadsGroup</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "description",
    "metadata",
    "items"
})
public class ReadsGroup {

    @JsonProperty("description")
    private java.lang.String description;
    @JsonProperty("metadata")
    private Map<String, String> metadata;
    @JsonProperty("items")
    private List<ReadsGroupItem> items;
    private Map<java.lang.String, Object> additionalProperties = new HashMap<java.lang.String, Object>();

    @JsonProperty("description")
    public java.lang.String getDescription() {
        return description;
    }

    @JsonProperty("description")
    public void setDescription(java.lang.String description) {
        this.description = description;
    }

    public ReadsGroup withDescription(java.lang.String description) {
        this.description = description;
        return this;
    }

    @JsonProperty("metadata")
    public Map<String, String> getMetadata() {
        return metadata;
    }

    @JsonProperty("metadata")
    public void setMetadata(Map<String, String> metadata) {
        this.metadata = metadata;
    }

    public ReadsGroup withMetadata(Map<String, String> metadata) {
        this.metadata = metadata;
        return this;
    }

    @JsonProperty("items")
    public List<ReadsGroupItem> getItems() {
        return items;
    }

    @JsonProperty("items")
    public void setItems(List<ReadsGroupItem> items) {
        this.items = items;
    }

    public ReadsGroup withItems(List<ReadsGroupItem> items) {
        this.items = items;
        return this;
    }

    @JsonAnyGetter
    public Map<java.lang.String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(java.lang.String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public java.lang.String toString() {
        return ((((((((("ReadsGroup"+" [description=")+ description)+", metadata=")+ metadata)+", items=")+ items)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
