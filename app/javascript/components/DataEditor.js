import React, { useState } from "react";

import { wrapper } from "reativo";

import { withStyles } from "@material-ui/core/styles";
import Input from "@material-ui/core/Input";
import OutlinedInput from "@material-ui/core/OutlinedInput";
import FilledInput from "@material-ui/core/FilledInput";
import InputLabel from "@material-ui/core/InputLabel";
import MenuItem from "@material-ui/core/MenuItem";
import FormHelperText from "@material-ui/core/FormHelperText";
import FormControl from "@material-ui/core/FormControl";
import Select from "@material-ui/core/Select";
import Grid from "@material-ui/core/Grid";

import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemIcon from "@material-ui/core/ListItemIcon";
import ListItemText from "@material-ui/core/ListItemText";
import ChevronRightIcon from "@material-ui/icons/ChevronRight";
import TextField from "@material-ui/core/TextField";
import ValueInspector from "./ValueInspector";

const styles = theme => ({
  container: {
    flexGrow: 1,
    padding: 20
  },
  list: {
    width: "100%",
    // maxWidth: 360,
    backgroundColor: theme.palette.background.paper,
    maxHeight: 300,
    minHeight: 300,
    overflowX: "hidden",
    overflowY: "scroll"
  },
  textField: {
    marginLeft: theme.spacing.unit,
    marginRight: theme.spacing.unit,
    width: "50%",
    paddingBottom: 20
  }
});

function DataEditor({ classes, model, environment, node, data, keyData }) {
  const [selectedKeys, setSelectedKeys] = useState(data._all_keys);
  const [searchString, setSearchString] = useState("");

  const handleKeyChange = value =>
    Turbolinks.visit(
      `/environments/${environment.environment}/nodes/${
        node.host
      }/keys/${value}`
    );

  const handleSearchChange = e => {
    const lookupKey = e.target.value;
    setSearchString(lookupKey);
    const results = data._all_keys.filter(x => x.match(lookupKey));
    setSelectedKeys(results);
  };

  return (
    <Grid container className={classes.container} spacing={16}>
      <TextField
        id="standard-search"
        label="Search Key"
        type="search"
        value={searchString}
        className={classes.textField}
        margin="normal"
        onChange={handleSearchChange}
      />
      <Grid item xs={12} md={6}>
        <List component="nav" className={classes.list} dense={true}>
          {selectedKeys.map((key, index) => (
            <ListItem button key={index} onClick={e => handleKeyChange(key)}>
              {model !== undefined && key === model.id && (
                <ListItemIcon>
                  <ChevronRightIcon />
                </ListItemIcon>
              )}
              <ListItemText inset primary={key} />
            </ListItem>
          ))}
        </List>
      </Grid>
      {model && (
        <Grid item xs={12} md={6}>
          <ValueInspector model={model} data={data} keyData={keyData} />
        </Grid>
      )}
    </Grid>
  );
}

export default withStyles(styles)(DataEditor);
