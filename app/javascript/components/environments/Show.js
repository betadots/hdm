import { hot } from "react-hot-loader/root";
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

const styles = theme => ({
  root: {
    display: "flex",
    flexWrap: "wrap"
  },
  formControl: {
    margin: theme.spacing.unit,
    width: "100%"
  },
  selectEmpty: {
    marginTop: theme.spacing.unit * 2
  }
});

function Show({ model, classes, environments, nodes }) {
  const handleEnvironmentChange = e =>
    Turbolinks.visit(`/environments/${e.target.value}`);

  const handleNodeChange = e =>
    Turbolinks.visit(`/environments/${model.name}/nodes/${e.target.value}`);

  return (
    <>
      <FormControl className={classes.formControl}>
        <Select
          value={model.name}
          onChange={handleEnvironmentChange}
          name="environment"
          displayEmpty
          className={classes.selectEmpty}
        >
          {environments.map(n => {
            return (
              <MenuItem value={n} key={n}>
                {n}
              </MenuItem>
            );
          })}
        </Select>
        <FormHelperText>Choose the environment</FormHelperText>
      </FormControl>
      <FormControl className={classes.formControl}>
        <Select
          value={""}
          onChange={handleNodeChange}
          name="node"
          displayEmpty
          className={classes.selectEmpty}
        >
          {nodes.map(n => {
            return (
              <MenuItem value={n} key={n}>
                {n}
              </MenuItem>
            );
          })}
        </Select>
        <FormHelperText>Choose the node</FormHelperText>
      </FormControl>
    </>
  );
}

export default hot(wrapper(withStyles(styles)(Show)));
