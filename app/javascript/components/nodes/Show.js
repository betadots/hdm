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
import Grid from "@material-ui/core/Grid";
import DataEditor from "../DataEditor";

const styles = theme => ({
  root: {
    display: "flex",
    flexWrap: "wrap"
  },
  container: {
    flexGrow: 1,
    padding: 20
  },
  formControl: {
    margin: theme.spacing.unit,
    width: "100%"
  },
  selectEmpty: {
    marginTop: theme.spacing.unit * 2
  }
});

function Show({
  model,
  classes,
  environment,
  environments,
  node,
  nodes,
  node_data
}) {
  const handleEnvironmentChange = e =>
    Turbolinks.visit(`/environments/${e.target.value}`);

  const handleNodeChange = e =>
    Turbolinks.visit(
      `/environments/${environment.environment}/nodes/${e.target.value}`
    );

  return (
    <Grid container className={classes.container} spacing={16}>
      <Grid item xs={12} md={6}>
        <FormControl className={classes.formControl}>
          <Select
            value={environment.environment}
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
      </Grid>
      <Grid item xs={12} md={6}>
        <FormControl className={classes.formControl}>
          <Select
            value={model.host}
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
      </Grid>
      <DataEditor environment={environment} node={model} data={node_data} />
    </Grid>
  );
}

export default hot(wrapper(withStyles(styles)(Show)));
